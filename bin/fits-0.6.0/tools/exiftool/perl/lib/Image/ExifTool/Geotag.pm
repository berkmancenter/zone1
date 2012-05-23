#------------------------------------------------------------------------------
# File:         Geotag.pm
#
# Description:  Geotagging utility routines
#
# Revisions:    2009/04/01 - P. Harvey Created
#
# References:   1) http://www.topografix.com/GPX/1/1/
#------------------------------------------------------------------------------

package Image::ExifTool::Geotag;

use strict;
use vars qw($VERSION);
use Image::ExifTool;

$VERSION = '1.00';

sub SetGeoValues($$;$);

# maximum time (sec) from nearest GPS fix when position is still considered valid
my $fixValidTime = 1800;  # (30 minutes)

# XML tags that we recognize
my %xmlTag = (
    lat         => 'lat',   # GPX
    latitude    => 'lat',   # Garmin
    lon         => 'lon',   # GPX
    longitude   => 'lon',   # Garmin
    ele         => 'ele',   # GPX
    elevation   => 'ele',   # PH
    alt         => 'ele',   # PH
    altitude    => 'ele',   # Garmin
   'time'       => 'time',  # GPX/Garmin
    position    => '',      # collapse this structure (Garmin)
);

#------------------------------------------------------------------------------
# Load GPS track log file
# Inputs: 0) ExifTool ref, 1) track log data or file name
# Returns: geotag hash data reference or error string
# - the geotag hash has the following members:
#       Points - hash of GPS Lat/Long/Alt position arrays keyed by Unix time
#       Times  - list of sorted Unix times (keys of Points hash)
#       NoDate - flag if some points have no date (ie. referenced to 1970:01:01)
#       IsDate - flag if some points have date
# - concatinates new data with existing track data stored in ExifTool NEW_VALUE
#   for the Geotag tag
sub LoadTrackLog($$;$)
{
    local $_;
    my ($exifTool, $val) = @_;
    my ($raf, $time0, $time, $from, $noDate, $isDate, %xmlVal);

    unless (eval 'require Time::Local') {
        return 'Geotag feature requires Time::Local installed';
    }
    # add data to existing track
    my $geotag = $exifTool->GetNewValues('Geotag') || { };
    my $oldSep = $/;
    if ($val =~ /(\x0d\x0a|\x0d|\x0a)/) {
        # $val is track log data
        $/ = $1;
        $raf = new File::RandomAccess(\$val);
        $from = 'data';
    } else {
        # $val is track file name
        open EXIFTOOL_TRKFILE, $val or return "Error opening GPS file '$val'";
        $raf = new File::RandomAccess(\*EXIFTOOL_TRKFILE);
        unless ($raf->Read($_, 256) and /(\x0d\x0a|\x0d|\x0a)/) {
            close EXIFTOOL_TRKFILE;
            return "Invalid track file '$val'";
        }
        $/ = $1;
        $raf->Seek(0,0);
        $from = "file '$val'";
    }
    # initialize track points lookup
    my $points = $$geotag{Points};
    $points or $points = $$geotag{Points} = { };

    my $numPoints = 0;
    my $skipped = 0;
    my $format = '';
    for (;;) {
        $raf->ReadLine($_) or last;
        my @pos;
#
# XML format (GPX, Garmin XML, etc)
#
        if ($format eq 'XML') {
            foreach (split) {
                # parse attributes (ie. GPX 'lat' and 'lon')
                # (note: ignore namespace prefixes if they exist)
                if (/^(\w+:)?(\w+)=(['"])(.*?)\3/g) {
                    my $tag = $xmlTag{lc $2};
                    $xmlVal{$tag} = $4 if $tag;
                }
                # loop through XML elements
                while (m{([^<>]*)</(\w+:)?(\w+)>}g) {
                    my $tag = $xmlTag{lc $3};
                    # parse as a simple property if this element has a value
                    if (length $1) {
                        $xmlVal{$tag} = $1 if $tag;
                        next;
                    }
                    # we just closed an element containing other elements, so it is
                    # time to store the fix (except for structures which we expect
                    # inside a fix, like Garmin's 'Position' structure)
                    next if defined $tag and not $tag;
                    # validate and store GPS fix
                    if ($xmlVal{lat} and $xmlVal{lat} =~ /^[+-]?\d+\.?\d*/ and
                        $xmlVal{lon} and $xmlVal{lon} =~ /^[+-]?\d+\.?\d*/ and
                        $xmlVal{'time'} and
                        $xmlVal{'time'} =~ /^(\d{4})-(\d+)-(\d+)T(\d+):(\d+):(\d+)(\.\d+)?/)
                    {
                        $time = Time::Local::timegm($6,$5,$4,$3,$2-1,$1-1900);
                        $time += $7 if $7;  # add fractional seconds
                        $pos[0] = $xmlVal{lat};
                        $pos[1] = $xmlVal{lon};
                        $pos[2] = $xmlVal{ele} if $xmlVal{ele} and
                                  $xmlVal{ele} =~ /^[+-]?\d+\.?\d*/;
                        $isDate = 1;
                        $$points{$time} = \@pos;
                        $time0 = $time unless defined $time0;
                        ++$numPoints;
                    }
                    undef %xmlVal;  # reset accumulated XML values
                }
            }
            next;
#
# Magellan eXplorist NMEA-like PMGNRTK format
#
        } elsif (($format eq 'PMGNTRK' or not $format) and
            # $PMGNTRK,4415.026,N,07631.091,W,00092,M,185031.06,A,,020409*65
            # $PMGNTRK,ddmm.mmm,N/S,dddmm.mmm,E/W,alt,F/M,hhmmss.ss,A/V,trkname,DDMMYY*cs
           /^\$PMGNTRK,(\d{2})(\d+\.\d+),([NS]),(\d{3})(\d+\.\d+),([EW]),(-?\d+),([MF]),(\d{2})(\d{2})(\d+)(\.\d+)?,A,(?:[^,]*,(\d{2})(\d{2})(\d+))?/)
        {
            $format = 'PMGNTRK';
            $pos[0] = ($1 + $2/60) * ($3 eq 'N' ? 1 : -1);
            $pos[1] = ($4 + $5/60) * ($6 eq 'E' ? 1 : -1);
            $pos[2] = $8 eq 'M' ? $7 : $7 * 12 * 0.0254;
            if (defined $15) {
                my $year = $15 + ($15 >= 70 ? 1900 : 2000);
                $time = Time::Local::timegm($11,$10,$9,$13,$14-1,$year-1900);
                $isDate = 1;
            } else {
                # optional date is missing in PMGNTRK
                $time = Time::Local::timegm($11,$10,$9,1,0,70);
                $noDate = 1;
            }
            $time += $12 if $12;    # add fractional seconds
#
# NMEA RMC format
#
        } elsif (($format eq 'GPRMC' or not $format) and
            #  $GPRMC,092204.999,A,4250.5589,S,14718.5084,E,0.00,89.68,211200,,*25
            #  $GPRMC,hhmmss.sss,A/V,ddmm.mmmm,N/S,ddmmm.mmmm,E/W,spd(knots),dir(deg),DDMMYY,,*cs
            /^\$GPRMC,(\d{2})(\d{2})(\d+)(\.\d+)?,A,(\d{2})(\d+\.\d+),([NS]),(\d{3})(\d+\.\d+),([EW]),[^,]*,[^,]*,(\d{2})(\d{2})(\d+)/)
        {
            $format = 'GPRMC';
            $pos[0] = ($5 + $6/60) * ($7 eq 'N' ? 1 : -1);
            $pos[1] = ($8 + $9/60) * ($10 eq 'E' ? 1 : -1);
            my $year = $13 + ($13 >= 70 ? 1900 : 2000);
            $time = Time::Local::timegm($3,$2,$1,$11,$12-1,$year-1900);
            $time += $4 if $4;      # add fractional seconds
            $isDate = 1;
#
# NMEA GGA format (no date)
#
        } elsif (($format eq 'GPGGA' or not $format) and
            #  $GPGGA,092204.999,4250.5589,S,14718.5084,E,1,04,24.4,19.7,M,,,,0000*1F
            #  $GPGGA,hhmmss.sss,ddmm.mmmm,N/S,dddmm.mmmm,E/W,0=invalid,sats,hdop,alt,M,...
            /^\$GPGGA,(\d{2})(\d{2})(\d+)(\.\d+)?,(\d{2})(\d+\.\d+),([NS]),(\d{3})(\d+\.\d+),([EW]),[123],[^,]*,[^,]*,(\d+\.?\d*),M,/)
        {
            $format = 'GPGGA';
            $pos[0] = ($5 + $6/60) * ($7 eq 'N' ? 1 : -1);
            $pos[1] = ($8 + $9/60) * ($10 eq 'E' ? 1 : -1);
            $pos[2] = $11;
            $time = Time::Local::timegm($3,$2,$1,1,0,70);
            $time += $4 if $4;      # add fractional seconds
            $noDate = 1;
#
# NMEA GLL format (no date)
#
        } elsif (($format eq 'GPGLL' or not $format) and
            #  $GPGLL,4250.5589,S,14718.5084,E,092204.999,A*2D
            #  $GPGLL,ddmm.mmmm,N/S,dddmm.mmmm,E/W,hhmmss.sss,A/V*cs
            /^\$GPGLL,(\d{2})(\d+\.\d+),([NS]),(\d{3})(\d+\.\d+),([EW]),(\d{2})(\d{2})(\d+)(\.\d+),A/)
        {
            $format = 'GPGLL';
            $pos[0] = ($1 + $2/60) * ($3 eq 'N' ? 1 : -1);
            $pos[1] = ($4 + $5/60) * ($6 eq 'E' ? 1 : -1);
            $time = Time::Local::timegm($9,$8,$7,1,0,70);
            $time += $10 if $10;    # add fractional seconds
            $noDate = 1;
#
# format not yet determined
#
        } elsif (not $format) {
            if (/^<(\?xml|gpx)\s/) { # look for XML or GPX header
                $format = 'XML';
            } else {
                # search only first 50 lines of file for a valid fix
                last if ++$skipped > 50;
            }
            next;
        } else {
            next;
        }
        $$points{$time} = \@pos;
        $time0 = $time unless defined $time0;
        ++$numPoints;
    }
    $raf->Close();

    # set date flags
    $$geotag{NoDate} = 1 if $noDate;
    $$geotag{IsDate} = 1 if $isDate;
    
    my $verbose = $exifTool->Options('Verbose');
    if ($verbose) {
        my $out = $exifTool->Options('TextOut');
        print $out "Loaded $numPoints points from GPS track log $from\n";
        if ($numPoints and $verbose > 1) {
            print $out '  GPS track start: ' . Image::ExifTool::ConvertUnixTime($time0) . " UTC\n";
            print $out '  GPS track end:   ' . Image::ExifTool::ConvertUnixTime($time) . " UTC\n";
        }
    }
    $/ = $oldSep;   # restore input record separator
    if ($numPoints) {
        # reset timestamp list to force it to be regenerated
        delete $$geotag{Times};
        return $geotag;     # success!
    }
    return "No track points found in GPS $from";
}

#------------------------------------------------------------------------------
# Set new geotagging values according to date/time
# Inputs: 0) ExifTool object ref, 1) date/time value (or undef to delete tags)
#         2) optional write group
# Returns: error string, or '' on success
# Notes: Uses track data stored in ExifTool NEW_VALUE for Geotag tag
sub SetGeoValues($$;$)
{
    local $_;
    my ($exifTool, $val, $writeGroup) = @_;
    my $geotag = $exifTool->GetNewValues('Geotag');
    my ($pos, $time, $fsec, $noDate);

    # remove date if none of our fixes had date information
    $val =~ s/^\S+\s+// if $geotag and not $$geotag{IsDate};

    my $err = '';
    while (defined $val) {
        unless (defined $geotag) {
            $err = 'No GPS track loaded';
            last;
        }
        my $times = $$geotag{Times};
        unless ($times) {
            # generate sorted timestamp list for binary search
            my @times = sort { $a <=> $b } keys %{$$geotag{Points}};
            $times = $$geotag{Times} = \@times;
        }
        unless ($times and @$times) {
            $err = 'GPS track is empty';
            last;
        }
        unless (eval 'require Time::Local') {
            $err = 'Geotag feature requires Time::Local installed';
            last;
        }
        my ($year,$mon,$day,$hr,$min,$sec,$fs,$tz,$t0,$t1,$t2);
        if ($val =~ /^(\d{4}):(\d+):(\d+)\s+(\d+):(\d+):(\d+)(\.\d*)?(Z|([-+])(\d+):(\d+))?/) {
            # valid date/time value
            ($year,$mon,$day,$hr,$min,$sec,$fs,$tz,$t0,$t1,$t2) = ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11);
        } elsif ($val =~ /^(\d{2}):(\d+):(\d+)(\.\d*)?(Z|([-+])(\d+):(\d+))?/) {
            # valid time-only value
            ($hr,$min,$sec,$fs,$tz,$t0,$t1,$t2) = ($1,$2,$3,$4,$5,$6,$7,$8);
            # use Jan. 2 to avoid going negative after tz adjustment
            ($year,$mon,$day) = (1970,1,2);
            $noDate = 1;
        } else {
            $err = 'Invalid date/time (use YYYY:MM:DD HH:MM:SS[.SS][+/-HH:MM|Z])';
            last;
        }
        if ($tz) {
            $time = Time::Local::timegm($sec,$min,$hr,$day,$mon-1,$year-1900);
            # use timezone from date/time value
            if ($tz ne 'Z') {
                my $tzmin = $t1 * 60 + $t2;
                $time -= ($t0 eq '-' ? -$tzmin : $tzmin) * 60;
            }
        } else {
            # assume local timezone
            $time = Time::Local::timelocal($sec,$min,$hr,$day,$mon-1,$year-1900);
        }
        # bring UTC time back to Jan. 1 if no date is given
        while ($noDate and $time >= 24*3600) {
            $time -= 24 * 3600;
        }
        # handle fractional seconds
        if ($fs) {
            $fsec = $fs;    # save fractional seconds string
            $time += $fs;
        } else {
            $fsec = '';
        }
        # convert date/time to UTC
        if ($time < $$times[0]) {
            if ($time < $$times[0] - $fixValidTime) {
                $err or $err = 'Time is too far before track';
            } else {
                $pos = $$geotag{Points}{$$times[0]};
            }
        } elsif ($time > $$times[-1]) {
            if ($time > $$times[-1] + $fixValidTime) {
                $err or $err = 'Time is too far beyond track';
            } else {
                $pos = $$geotag{Points}{$$times[-1]};
            }
        } else {
            # find nearest 2 points in time
            my ($i0, $i1) = (0, scalar(@$times) - 1);
            while ($i1 > $i0 + 1) {
                my $pt = int(($i0 + $i1) / 2);
                if ($time < $$times[$pt]) {
                    $i1 = $pt;
                } else {
                    $i0 = $pt;
                }
            }
            # do linear interpolation for position
            my $t0 = $$times[$i0];
            my $t1 = $$times[$i1];
            if (abs($time - $t0) > $fixValidTime and abs($time - $t1) > $fixValidTime) {
                $err or $err = 'Time is too far from nearest GPS fix';
            } else {
                my $f = ($time - $t0) / ($t1 - $t0);
                my $p0 = $$geotag{Points}{$t0};
                my $p1 = $$geotag{Points}{$t1};
                $pos = [ ];
                # loop through latitude, longitude and altitude if available
                foreach (0..(@$p0-1)) {
                    push @$pos, $$p1[$_] * $f + $$p0[$_] * (1 - $f);
                }
            }
        }
        if ($pos) {
            $err = '';  # success!
        } else {
            # try again with no date since some of our track points are date-less
            next if $$geotag{NoDate} and not $noDate and $val =~ s/^\S+\s+//;
        }
        last;
    }
    if ($exifTool->Options('Verbose') > 1 and defined $time) {
        my $out = $exifTool->Options('TextOut');
        print $out '  Geotime value:   ' . Image::ExifTool::ConvertUnixTime($time) . " UTC\n";
    }
    if ($pos) {
        my ($gpsDate, $gpsAlt, $gpsAltRef);
        my @t = gmtime(int $time);
        my $gpsTime = sprintf('%.2d:%.2d:%.2d', $t[2], $t[1], $t[0]) . $fsec;
        # write GPSDateStamp if date included in track log, otherwise delete it
        $gpsDate = sprintf('%.2d:%.2d:%.2d', $t[5]+1900, $t[4]+1, $t[3]) unless $noDate;
        # write GPSAltitude tags if altitude included in track log, otherwise delete them
        if (@$pos > 2) {
            $gpsAlt = abs $$pos[2];
            $gpsAltRef = ($$pos[2] > 0 ? 0 : 1);
        }
        # set new GPS tag values (EXIF, or XMP if write group is 'xmp')
        my ($xmp, $exif, @r);
        my %opts = ( Type => 'ValueConv' ); # write ValueConv values
        if ($writeGroup) {
            $opts{Group} = $writeGroup;
            $xmp = ($writeGroup =~ /xmp/i);
            $exif = ($writeGroup =~ /^(exif|gps)$/i);
        }
        # (capture error messages by calling SetNewValue in list context)
        @r = $exifTool->SetNewValue(GPSLatitude => $$pos[0], %opts);
        @r = $exifTool->SetNewValue(GPSLongitude => $$pos[1], %opts);
        @r = $exifTool->SetNewValue(GPSAltitude => $gpsAlt, %opts);
        @r = $exifTool->SetNewValue(GPSAltitudeRef => $gpsAltRef, %opts);
        unless ($xmp) {
            @r = $exifTool->SetNewValue(GPSLatitudeRef => ($$pos[0] > 0 ? 'N' : 'S'), %opts);
            @r = $exifTool->SetNewValue(GPSLongitudeRef => ($$pos[1] > 0 ? 'E' : 'W'), %opts);
            @r = $exifTool->SetNewValue(GPSDateStamp => $gpsDate, %opts);
            @r = $exifTool->SetNewValue(GPSTimeStamp => $gpsTime, %opts);
            # set options to edit XMP:GPSDateTime only if it already exists
            $opts{EditOnly} = 1;
            $opts{Group} = 'XMP';
        }
        unless ($exif) {
            @r = $exifTool->SetNewValue(GPSDateTime => "$gpsDate $gpsTime", %opts);
        }
    } else {
        my %opts;
        $opts{Replace} = 2 if defined $val; # remove existing new values
        $opts{Group} = $writeGroup if $writeGroup;
        # reset any GPS values we might have already set
        foreach (qw(GPSLatitude GPSLatitudeRef GPSLongitude GPSLongitudeRef
                    GPSAltitude GPSAltitudeRef GPSDateStamp GPSTimeStamp GPSDateTime))
        {
            my @r = $exifTool->SetNewValue($_, undef, %opts);
        }
    }
    return $err;
}

#------------------------------------------------------------------------------
1;  # end

__END__

=head1 NAME

Image::ExifTool::Geotag - Geotagging utility routines

=head1 SYNOPSIS

This module is used by Image::ExifTool

=head1 DESCRIPTION

This module loads GPS track logs, interpolates to determine position based
on time, and sets new GPS values for geotagging images.  Currently supported
formats are GPX, NMEA RMC/GGA/GLL, Garmin XML and Magellan PMGNRTK.

=head1 AUTHOR

Copyright 2003-2009, Phil Harvey (phil at owl.phy.queensu.ca)

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 REFERENCES

=over 4

=item L<http://www.topografix.com/GPX/1/1/>

=back

=head1 SEE ALSO

L<Image::ExifTool(3pm)|Image::ExifTool>

=cut

