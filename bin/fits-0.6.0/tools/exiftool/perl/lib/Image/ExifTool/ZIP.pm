#------------------------------------------------------------------------------
# File:         ZIP.pm
#
# Description:  Read ZIP archive meta information
#
# Revisions:    10/28/2007 - P. Harvey Created
#
# References:   1) http://www.pkware.com/documents/casestudies/APPNOTE.TXT
#               2) http://www.cpanforum.com/threads/9046
#------------------------------------------------------------------------------

package Image::ExifTool::ZIP;

use strict;
use vars qw($VERSION);
use Image::ExifTool qw(:DataAccess :Utils);

$VERSION = '1.01';

# ZIP metadata blocks
%Image::ExifTool::ZIP::Main = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    GROUPS => { 2 => 'Other' },
    FORMAT => 'int16u',
    NOTES => 'This information is extracted from ZIP archives.',
    2 => 'ZipVersion',
    3 => 'BitFlag',
    4 => {
        Name => 'Compression',
        PrintConv => {
            0 => 'None',
            1 => 'Shrunk',
            2 => 'Reduced with compression factor 1',
            3 => 'Reduced with compression factor 2',
            4 => 'Reduced with compression factor 3',
            5 => 'Reduced with compression factor 4',
            6 => 'Imploded',
            7 => 'Tokenized',
            8 => 'Deflated',
            9 => 'Enhanced Deflate using Deflate64(tm)',
           10 => 'Imploded (old IBM TERSE)',
           12 => 'BZIP2',
           14 => 'LZMA (EFS)',
           18 => 'IBM TERSE (new)',
           19 => 'IBM LZ77 z Architecture (PFS)',
           96 => 'JPEG recompressed', #2
           97 => 'WavPack compressed', #2
           98 => 'PPMd version I, Rev 1',
       },
    },
    5 => {
        Name => 'ModifyDate',
        Format => 'int32u',
        Groups => { 2 => 'Time' },
        ValueConv => sub {
            my $val = shift;
            return sprintf('%.4d:%.2d:%.2d %.2d:%.2d:%.2d',
                ($val >> 25) + 1980, # year
                ($val >> 21) & 0x0f, # month
                ($val >> 16) & 0x1f, # day
                ($val >> 11) & 0x1f, # hour
                ($val >> 5)  & 0x3f, # minute
                 $val        & 0x1f  # second
            );
        },
        PrintConv => '$self->ConvertDateTime($val)',
    },
    7 => { Name => 'CRC', Format => 'int32u', PrintConv => 'sprintf("0x%.8x",$val)' },
    9 => { Name => 'CompressedSize',    Format => 'int32u' },
    11 => { Name => 'UncompressedSize', Format => 'int32u' },
    13 => 'FileNameLength',
    14 => 'ExtraFieldLength',
    15 => { Name => 'ArchivedFileName', Format => 'string[$val{13}]' },
);

#------------------------------------------------------------------------------
# Extract information from an ZIP file
# Inputs: 0) ExifTool object reference, 1) dirInfo reference
# Returns: 1 on success, 0 if this wasn't a valid ZIP file
sub ProcessZIP($$)
{
    my ($exifTool, $dirInfo) = @_;
    my $raf = $$dirInfo{RAF};
    my $rtnVal = 0;
    my ($buff, $buf2, $tagTablePtr);

    #  A.  Local file header:
    #  local file header signature     0) 4 bytes  (0x04034b50)
    #  version needed to extract       4) 2 bytes
    #  general purpose bit flag        6) 2 bytes
    #  compression method              8) 2 bytes
    #  last mod file time             10) 2 bytes
    #  last mod file date             12) 2 bytes
    #  crc-32                         14) 4 bytes
    #  compressed size                18) 4 bytes
    #  uncompressed size              22) 4 bytes
    #  file name length               26) 2 bytes
    #  extra field length             28) 2 bytes
    for (;;) {
        $raf->Read($buff, 30) == 30 and $buff =~ /^PK\x03\x04/ or last;
        unless ($rtnVal) {
            $rtnVal = 1;
            $exifTool->SetFileType();
            SetByteOrder('II');
            $tagTablePtr = GetTagTable('Image::ExifTool::ZIP::Main');
        }
        my $len = Get16u(\$buff, 26) + Get16u(\$buff, 28);
        $raf->Read($buf2, $len) == $len or last;

        $rtnVal = 1;
        $buff .= $buf2;
        my %dirInfo = (
            DataPt => \$buff,
            DataPos => $raf->Tell() - 30 - $len,
            DataLen => 30 + $len,
            DirStart => 0,
            DirLen => 30 + $len,
        );
        $exifTool->ProcessDirectory(\%dirInfo, $tagTablePtr);
        my $flags = Get16u(\$buff, 6);
        $len = Get32u(\$buff, 18);      # file data length
        $len += 12 if $flags & 0x08;    # optional data descriptor
        $raf->Seek($len, 1) or last;    # skip file data
    }
    return $rtnVal;
}

1;  # end

__END__

=head1 NAME

Image::ExifTool::ZIP - Read ZIP archive meta information

=head1 SYNOPSIS

This module is used by Image::ExifTool

=head1 DESCRIPTION

This module contains definitions required by Image::ExifTool to extract meta
information from ZIP archives.

=head1 AUTHOR

Copyright 2003-2009, Phil Harvey (phil at owl.phy.queensu.ca)

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 REFERENCES

=over 4

=item L<http://www.pkware.com/documents/casestudies/APPNOTE.TXT>

=back

=head1 SEE ALSO

L<Image::ExifTool::TagNames/ZIP Tags>,
L<Image::ExifTool(3pm)|Image::ExifTool>

=cut

