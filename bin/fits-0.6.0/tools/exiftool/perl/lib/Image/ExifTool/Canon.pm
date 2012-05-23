#------------------------------------------------------------------------------
# File:         Canon.pm
#
# Description:  Canon EXIF maker notes tags
#
# Revisions:    11/25/2003 - P. Harvey Created
#               12/03/2003 - P. Harvey Decode lots more tags and add CanonAFInfo
#               02/17/2004 - Michael Rommel Added IxusAFPoint
#               01/27/2005 - P. Harvey Disable validation of CanonAFInfo
#               01/30/2005 - P. Harvey Added a few more tags (ref 4)
#               02/10/2006 - P. Harvey Decode a lot of new tags (ref 12)
#
# Notes:        Must check FocalPlaneX/YResolution values for each new model!
#
# References:   1) http://park2.wakwak.com/~tsuruzoh/Computer/Digicams/exif-e.html
#               2) Michael Rommel private communication (Digital Ixus)
#               3) Daniel Pittman private communication (PowerShot S70)
#               4) http://www.wonderland.org/crw/
#               5) Juha Eskelinen private communication (20D)
#               6) Richard S. Smith private communication (20D)
#               7) Denny Priebe private communication (1DmkII)
#               8) Irwin Poche private communication
#               9) Michael Tiemann private communication (1DmkII)
#              10) Volker Gering private communication (1DmkII)
#              11) "cip" private communication
#              12) Rainer Honle private communication (5D)
#              13) http://www.cybercom.net/~dcoffin/dcraw/
#              14) (bozi) http://www.cpanforum.com/threads/2476 and /2563
#              15) http://homepage3.nifty.com/kamisaka/makernote/makernote_canon.htm (2007/11/19)
#                + http://homepage3.nifty.com/kamisaka/makernote/CanonLens.htm (2007/11/19)
#              16) Emil Sit private communication (30D)
#              17) http://www.asahi-net.or.jp/~xp8t-ymzk/s10exif.htm
#              18) Samson Tai private communication (G7)
#              19) Warren Stockton private communication
#              20) Bogdan private communication
#              21) Heiko Hinrichs private communication
#              22) Dave Nicholson private communication (PowerShot S30)
#              23) Magne Nilsen private communication (400D)
#              24) Wolfgang Hoffmann private communication (40D)
#              25) Laurent Clevy private communication (40D)
#              26) Steve Balcombe private communication
#              27) Chris Huebsch private communication (40D)
#              28) Hal Williamson private communication (XTi)
#              29) Ger Vermeulen private communication
#              30) David Pitcher private communication (1DmkIII)
#              31) Darryl Zurn private communication (A590IS)
#              32) Rich Taylor private communication (5D)
#              33) D.J. Cristi private communication
#              34) Andreas Huggel and Pascal de Bruijn private communication
#              35) Jan Boelsma private communication
#              36) Karl-Heinz Klotz private communication (http://www.dslr-forum.de/showthread.php?t=430900)
#              37) Vesa Kivisto private communication (30D)
#              38) Kurt Garloff private communication (5DmkII)
#              39) Irwin Poche private communication (5DmkII)
#------------------------------------------------------------------------------

package Image::ExifTool::Canon;

use strict;
use vars qw($VERSION %canonModelID);
use Image::ExifTool qw(:DataAccess :Utils);
use Image::ExifTool::Exif;

sub WriteCanon($$$);
sub ProcessSerialData($$$);
sub SwapWords($);

$VERSION = '2.18';

# Note: Removed 'USM' from 'L' lenses since it is redundant - PH
# (or is it?  Ref 32 shows 5 non-USM L-type lenses)
my %canonLensTypes = ( #4
     Notes => q{
        Decimal values differentiate lenses which would otherwise have the same
        LensType, and are used by the Composite LensID tag when attempting to
        identify the specific lens model.
     },
     1 => 'Canon EF 50mm f/1.8',
     2 => 'Canon EF 28mm f/2.8',
     # (3 removed in current Kamisaka list)
     3 => 'Canon EF 135mm f/2.8 Soft', #15/32
     4 => 'Canon EF 35-105mm f/3.5-4.5 or Sigma Lens', #28
     4.1 => 'Sigma UC Zoom 35-135mm f/4-5.6',
     5 => 'Canon EF 35-70mm f/3.5-4.5', #32
     6 => 'Canon EF 28-70mm f/3.5-4.5 or Sigma or Tokina Lens', #32
     6.1 => 'Sigma 18-50mm f/3.5-5.6 DC', #23
     6.2 => 'Sigma 18-125mm f/3.5-5.6 DC IF ASP',
     6.3 => 'Tokina AF193-2 19-35mm f/3.5-4.5',
     7 => 'Canon EF 100-300mm f/5.6L', #15
     8 => 'Canon EF 100-300mm f/5.6 or Sigma or Tokina Lens', #32
     8.1 => 'Sigma 70-300mm f/4-5.6 DG Macro', #15
     8.2 => 'Tokina AT-X242AF 24-200mm f/3.5-5.6', #15
     9 => 'Canon EF 70-210mm f/4', #32
     9.1 => 'Sigma 55-200mm f/4-5.6 DC', #34
    10 => 'Canon EF 50mm f/2.5 Macro or Sigma Lens', #10
    10.1 => 'Sigma 50mm f/2.8 EX', #4
    10.2 => 'Sigma 28mm f/1.8',
    10.3 => 'Sigma 105mm f/2.8 Macro EX', #15
    11 => 'Canon EF 35mm f/2', #9
    13 => 'Canon EF 15mm f/2.8 Fisheye', #9
    14 => 'Canon EF 50-200mm f/3.5-4.5L', #32
    15 => 'Canon EF 50-200mm f/3.5-4.5', #32
    16 => 'Canon EF 35-135mm f/3.5-4.5', #32
    17 => 'Canon EF 35-70mm f/3.5-4.5A', #32
    18 => 'Canon EF 28-70mm f/3.5-4.5', #32
    20 => 'Canon EF 100-200mm f/4.5A', #32
    21 => 'Canon EF 80-200mm f/2.8L',
    22 => 'Canon EF 20-35mm f/2.8L or Tokina Lens', #32
    22.1 => 'Tokina AT-X280AF PRO 28-80mm f/2.8 Aspherical', #15
    23 => 'Canon EF 35-105mm f/3.5-4.5', #32
    24 => 'Canon EF 35-80mm f/4-5.6 Power Zoom', #32
    25 => 'Canon EF 35-80mm f/4-5.6 Power Zoom', #32
    26 => 'Canon EF 100mm f/2.8 Macro or Cosina or Tamron Lens',
    26.1 => 'Cosina 100mm f/3.5 Macro AF',
    26.2 => 'Tamron SP AF 90mm f/2.8 Di Macro', #15
    26.3 => 'Tamron SP AF 180mm f/3.5 Di Macro', #15
    27 => 'Canon EF 35-80mm f/4-5.6', #32
    28 => 'Canon EF 80-200mm f/4.5-5.6 or Tamron Lens', #32
    28.1 => 'Tamron SP AF 28-105mm f/2.8 LD Aspherical IF', #15
    28.2 => 'Tamron SP AF 28-75mm f/2.8 XR Di LD Aspherical [IF] Macro', #4
    28.3 => 'Tamron AF 70-300mm f/4.5-5.6 Di LD 1:2 Macro Zoom', #11
    28.4 => 'Tamron AF Aspherical 28-200mm f/3.8-5.6', #14
    29 => 'Canon EF 50mm f/1.8 MkII',
    30 => 'Canon EF 35-105mm f/4.5-5.6', #32
    31 => 'Canon EF 75-300mm f/4-5.6 or Tamron Lens', #32
    31.1 => 'Tamron SP AF 300mm f/2.8 LD IF', #15
    32 => 'Canon EF 24mm f/2.8 or Sigma Lens', #10
    32.1 => 'Sigma 15mm f/2.8 EX Fisheye', #11
    35 => 'Canon EF 35-80mm f/4-5.6', #32
    36 => 'Canon EF 38-76mm f/4.5-5.6', #32
    37 => 'Canon EF 35-80mm f/4-5.6 or Tamron Lens', #32
    37.1 => 'Tamron 70-200mm f/2.8 Di LD IF Macro', #PH
    37.2 => 'Tamron AF 28-300mm f/3.5-6.3 XR Di VC LD Aspherical [IF] Macro Model A20', #38
    38 => 'Canon EF 80-200mm f/4.5-5.6', #32
    39 => 'Canon EF 75-300mm f/4-5.6',
    40 => 'Canon EF 28-80mm f/3.5-5.6',
    41 => 'Canon EF 28-90mm f/4-5.6', #32
    42 => 'Canon EF 28-200mm f/3.5-5.6 or Tamron Lens', #32
    42.1 => 'Tamron AF 28-300mm f/3.5-6.3 XR Di VC LD Aspherical [IF] Macro Model A20', #15
    43 => 'Canon EF 28-105mm f/4-5.6', #10
    44 => 'Canon EF 90-300mm f/4.5-5.6', #32
    45 => 'Canon EF-S 18-55mm f/3.5-5.6', #PH (same ID for mkII version, ref 20)
    46 => 'Canon EF 28-90mm f/4-5.6', #32
    48 => 'Canon EF-S 18-55mm f/3.5-5.6 IS', #20
    49 => 'Canon EF-S 55-250mm f/4-5.6 IS', #23
    50 => 'Canon EF-S 18-200mm f/3.5-5.6 IS', #25
    124 => 'Canon MP-E 65mm f/2.8 1-5x Macro Photo', #9
    125 => 'Canon TS-E 24mm f/3.5L',
    126 => 'Canon TS-E 45mm f/2.8', #15
    127 => 'Canon TS-E 90mm f/2.8', #15
    129 => 'Canon EF 300mm f/2.8L', #32
    130 => 'Canon EF 50mm f/1.0L', #10/15
    131 => 'Canon EF 28-80mm f/2.8-4L or Sigma Lens', #32
    131.1 => 'Sigma 8mm f/3.5 EX DG Circular Fisheye', #15
    131.2 => 'Sigma 17-35mm f/2.8-4 EX DG Aspherical HSM', #15
    131.3 => 'Sigma 17-70mm F2.8-4.5 DC Macro', #PH (NC)
    131.4 => 'Sigma APO 50-150mm f/2.8 EX DC HSM', #15
    131.5 => 'Sigma APO 120-300mm f/2.8 EX DG HSM', #15
           # 'Sigma APO 120-300mm f/2.8 EX DG HSM + 1.4x', #15
           # 'Sigma APO 120-300mm f/2.8 EX DG HSM + 2x', #15
    132 => 'Canon EF 1200mm f/5.6L', #32
    134 => 'Canon EF 600mm f/4L IS', #15
    135 => 'Canon EF 200mm f/1.8L',
    136 => 'Canon EF 300mm f/2.8L',
    137 => 'Canon EF 85mm f/1.2L', #10
    138 => 'Canon EF 28-80mm f/2.8-4L', #32
    139 => 'Canon EF 400mm f/2.8L',
    140 => 'Canon EF 500mm f/4.5L', #32
    141 => 'Canon EF 500mm f/4.5L',
    142 => 'Canon EF 300mm f/2.8L IS', #15
    143 => 'Canon EF 500mm f/4L IS', #15
    144 => 'Canon EF 35-135mm f/4-5.6 USM', #26
    145 => 'Canon EF 100-300mm f/4.5-5.6 USM', #32
    146 => 'Canon EF 70-210mm f/3.5-4.5 USM', #32
    147 => 'Canon EF 35-135mm f/4-5.6 USM', #32
    148 => 'Canon EF 28-80mm f/3.5-5.6 USM', #32
    149 => 'Canon EF 100mm f/2 USM', #9
    150 => 'Canon EF 14mm f/2.8L or Sigma Lens', #10
    150.1 => 'Sigma 20mm EX f/1.8', #4
    150.2 => 'Sigma 30mm f/1.4 DC HSM', #15
    150.3 => 'Sigma 24mm f/1.8 DG Macro EX', #15
    151 => 'Canon EF 200mm f/2.8L',
    152 => 'Canon EF 300mm f/4L IS or Sigma Lens', #15
    152.1 => 'Sigma 12-24mm f/4.5-5.6 EX DG ASPHERICAL HSM', #15
    152.2 => 'Sigma 14mm f/2.8 EX Aspherical HSM', #15
    152.3 => 'Sigma 10-20mm f/4-5.6', #14
    152.4 => 'Sigma 100-300mm f/4', # (ref Bozi)
    153 => 'Canon EF 35-350mm f/3.5-5.6L or Sigma or Tamron Lens', #PH
    153.1 => 'Sigma 50-500mm f/4-6.3 APO HSM EX', #15
    153.2 => 'Tamron AF 28-300mm f/3.5-6.3 XR LD Aspherical [IF] Macro',
    153.3 => 'Tamron AF 18-200mm f/3.5-6.3 XR Di II LD Aspherical [IF] Macro Model A14', #15
    153.4 => 'Tamron 18-250mm f/3.5-6.3 Di II_LD Aspherical [IF] Macro', #PH
    154 => 'Canon EF 20mm f/2.8 USM', #15
    155 => 'Canon EF 85mm f/1.8 USM',
    156 => 'Canon EF 28-105mm f/3.5-4.5 USM',
    160 => 'Canon EF 20-35mm f/3.5-4.5 USM',
    161 => 'Canon EF 28-70mm f/2.8L or Sigma or Tamron Lens',
    161.1 => 'Sigma 24-70mm EX f/2.8',
    161.2 => 'Tamron 90mm f/2.8',
    162 => 'Canon EF 200mm f/2.8L', #32
    163 => 'Canon EF 300mm f/4L', #32
    164 => 'Canon EF 400mm f/5.6L', #32
    165 => 'Canon EF 70-200mm f/2.8 L',
    166 => 'Canon EF 70-200mm f/2.8 L + 1.4x',
    167 => 'Canon EF 70-200mm f/2.8 L + 2x',
    168 => 'Canon EF 28mm f/1.8 USM', #15
    169 => 'Canon EF 17-35mm f/2.8L or Sigma Lens', #15
    169.1 => 'Sigma 18-200mm f/3.5-6.3 DC OS', #23
    169.2 => 'Sigma 15-30mm f/3.5-4.5 EX DG Aspherical', #4
    169.3 => 'Sigma 18-50mm f/2.8 Macro', #26
    170 => 'Canon EF 200mm f/2.8L II', #9
    171 => 'Canon EF 300mm f/4L', #15
    172 => 'Canon EF 400mm f/5.6L', #32
    173 => 'Canon EF 180mm Macro f/3.5L or Sigma Lens', #9
    173.1 => 'Sigma 180mm EX HSM Macro f/3.5', #14
    173.2 => 'Sigma APO Macro 150mm f/3.5 EX DG IF HSM', #14
    174 => 'Canon EF 135mm f/2L', #9
    175 => 'Canon EF 400mm f/2.8L', #32
    176 => 'Canon EF 24-85mm f/3.5-4.5 USM',
    177 => 'Canon EF 300mm f/4L IS', #9
    178 => 'Canon EF 28-135mm f/3.5-5.6 IS',
    179 => 'Canon EF 24mm f/1.4L', #20
    180 => 'Canon EF 35mm f/1.4L', #9
    181 => 'Canon EF 100-400mm f/4.5-5.6L IS + 1.4x', #15
    182 => 'Canon EF 100-400mm f/4.5-5.6L IS + 2x',
    183 => 'Canon EF 100-400mm f/4.5-5.6L IS',
    184 => 'Canon EF 400mm f/2.8L + 2x', #15
    185 => 'Canon EF 600mm f/4L IS', #32
    186 => 'Canon EF 70-200mm f/4L', #9
    187 => 'Canon EF 70-200mm f/4L + 1.4x', #26
    188 => 'Canon EF 70-200mm f/4L + 2x', #PH
    189 => 'Canon EF 70-200mm f/4L + 2.8x', #32
    190 => 'Canon EF 100mm f/2.8 Macro',
    191 => 'Canon EF 400mm f/4 DO IS', #9
    193 => 'Canon EF 35-80mm f/4-5.6 USM', #32
    194 => 'Canon EF 80-200mm f/4.5-5.6 USM', #32
    195 => 'Canon EF 35-105mm f/4.5-5.6 USM', #32
    196 => 'Canon EF 75-300mm f/4-5.6 USM', #15/32
    197 => 'Canon EF 75-300mm f/4-5.6 IS USM',
    198 => 'Canon EF 50mm f/1.4 USM', #9
    199 => 'Canon EF 28-80mm f/3.5-5.6 USM', #32
    200 => 'Canon EF 75-300mm f/4-5.6 USM', #32
    201 => 'Canon EF 28-80mm f/3.5-5.6 USM', #32
    202 => 'Canon EF 28-80mm f/3.5-5.6 USM IV',
    208 => 'Canon EF 22-55mm f/4-5.6 USM', #32
    209 => 'Canon EF 55-200mm f/4.5-5.6', #32
    210 => 'Canon EF 28-90mm f/4-5.6 USM', #32
    211 => 'Canon EF 28-200mm f/3.5-5.6 USM', #15
    212 => 'Canon EF 28-105mm f/4-5.6 USM', #15
    213 => 'Canon EF 90-300mm f/4.5-5.6 USM',
    214 => 'Canon EF-S 18-55mm f/3.5-4.5 USM', #PH
    215 => 'Canon EF 55-200mm f/4.5-5.6 II USM', #25
    224 => 'Canon EF 70-200mm f/2.8L IS', #11
    225 => 'Canon EF 70-200mm f/2.8L IS + 1.4x', #11
    226 => 'Canon EF 70-200mm f/2.8L IS + 2x', #14
    227 => 'Canon EF 70-200mm f/2.8L IS + 2.8x', #32
    228 => 'Canon EF 28-105mm f/3.5-4.5 USM', #32
    229 => 'Canon EF 16-35mm f/2.8L', #PH
    230 => 'Canon EF 24-70mm f/2.8L', #9
    231 => 'Canon EF 17-40mm f/4L',
    232 => 'Canon EF 70-300mm f/4.5-5.6 DO IS USM', #15
    233 => 'Canon EF 28-300mm f/3.5-5.6L IS', #PH
    234 => 'Canon EF-S 17-85mm f4-5.6 IS USM', #19
    235 => 'Canon EF-S 10-22mm f/3.5-4.5 USM', #15
    236 => 'Canon EF-S 60mm f/2.8 Macro USM', #15
    237 => 'Canon EF 24-105mm f/4L IS', #15
    238 => 'Canon EF 70-300mm f/4-5.6 IS USM', #15
    239 => 'Canon EF 85mm f/1.2L II', #15
    240 => 'Canon EF-S 17-55mm f/2.8 IS USM', #15
    241 => 'Canon EF 50mm f/1.2L', #15
    242 => 'Canon EF 70-200mm f/4L IS', #PH
    243 => 'Canon EF 70-200mm f/4L IS + 1.4x', #15
    244 => 'Canon EF 70-200mm f/4L IS + 2x', #PH
    245 => 'Canon EF 70-200mm f/4L IS + 2.8x', #32
    246 => 'Canon EF 16-35mm f/2.8L II', #PH
    247 => 'Canon EF 14mm f/2.8L II USM', #32
    249 => 'Canon EF 800mm f/5.6L IS', #35
);

# Canon model ID numbers (PH)
%canonModelID = (
    0x1010000 => 'PowerShot A30',
    0x1040000 => 'PowerShot S300 / Digital IXUS 300 / IXY Digital 300',
    0x1060000 => 'PowerShot A20',
    0x1080000 => 'PowerShot A10',
    0x1090000 => 'PowerShot S110 / Digital IXUS v / IXY Digital 200',
    0x1100000 => 'PowerShot G2',
    0x1110000 => 'PowerShot S40',
    0x1120000 => 'PowerShot S30',
    0x1130000 => 'PowerShot A40',
    0x1140000 => 'EOS D30',
    0x1150000 => 'PowerShot A100',
    0x1160000 => 'PowerShot S200 / Digital IXUS v2 / IXY Digital 200a',
    0x1170000 => 'PowerShot A200',
    0x1180000 => 'PowerShot S330 / Digital IXUS 330 / IXY Digital 300a',
    0x1190000 => 'PowerShot G3',
    0x1210000 => 'PowerShot S45',
    0x1230000 => 'PowerShot SD100 / Digital IXUS II / IXY Digital 30',
    0x1240000 => 'PowerShot S230 / Digital IXUS v3 / IXY Digital 320',
    0x1250000 => 'PowerShot A70',
    0x1260000 => 'PowerShot A60',
    0x1270000 => 'PowerShot S400 / Digital IXUS 400 / IXY Digital 400',
    0x1290000 => 'PowerShot G5',
    0x1300000 => 'PowerShot A300',
    0x1310000 => 'PowerShot S50',
    0x1340000 => 'PowerShot A80',
    0x1350000 => 'PowerShot SD10 / Digital IXUS i / IXY Digital L',
    0x1360000 => 'PowerShot S1 IS',
    0x1370000 => 'PowerShot Pro1',
    0x1380000 => 'PowerShot S70',
    0x1390000 => 'PowerShot S60',
    0x1400000 => 'PowerShot G6',
    0x1410000 => 'PowerShot S500 / Digital IXUS 500 / IXY Digital 500',
    0x1420000 => 'PowerShot A75',
    0x1440000 => 'PowerShot SD110 / Digital IXUS IIs / IXY Digital 30a',
    0x1450000 => 'PowerShot A400',
    0x1470000 => 'PowerShot A310',
    0x1490000 => 'PowerShot A85',
    0x1520000 => 'PowerShot S410 / Digital IXUS 430 / IXY Digital 450',
    0x1530000 => 'PowerShot A95',
    0x1540000 => 'PowerShot SD300 / Digital IXUS 40 / IXY Digital 50',
    0x1550000 => 'PowerShot SD200 / Digital IXUS 30 / IXY Digital 40',
    0x1560000 => 'PowerShot A520',
    0x1570000 => 'PowerShot A510',
    0x1590000 => 'PowerShot SD20 / Digital IXUS i5 / IXY Digital L2',
    0x1640000 => 'PowerShot S2 IS',
    0x1650000 => 'PowerShot SD430 / IXUS Wireless / IXY Wireless',
    0x1660000 => 'PowerShot SD500 / Digital IXUS 700 / IXY Digital 600',
    0x1668000 => 'EOS D60',
    0x1700000 => 'PowerShot SD30 / Digital IXUS i zoom / IXY Digital L3',
    0x1740000 => 'PowerShot A430',
    0x1750000 => 'PowerShot A410',
    0x1760000 => 'PowerShot S80',
    0x1780000 => 'PowerShot A620',
    0x1790000 => 'PowerShot A610',
    0x1800000 => 'PowerShot SD630 / Digital IXUS 65 / IXY Digital 80',
    0x1810000 => 'PowerShot SD450 / Digital IXUS 55 / IXY Digital 60',
    0x1820000 => 'PowerShot TX1',
    0x1870000 => 'PowerShot SD400 / Digital IXUS 50 / IXY Digital 55',
    0x1880000 => 'PowerShot A420',
    0x1890000 => 'PowerShot SD900 / Digital IXUS 900 Ti / IXY Digital 1000',
    0x1900000 => 'PowerShot SD550 / Digital IXUS 750 / IXY Digital 700',
    0x1920000 => 'PowerShot A700',
    0x1940000 => 'PowerShot SD700 IS / Digital IXUS 800 IS / IXY Digital 800 IS',
    0x1950000 => 'PowerShot S3 IS',
    0x1960000 => 'PowerShot A540',
    0x1970000 => 'PowerShot SD600 / Digital IXUS 60 / IXY Digital 70',
    0x1980000 => 'PowerShot G7',
    0x1990000 => 'PowerShot A530',
    0x2000000 => 'PowerShot SD800 IS / Digital IXUS 850 IS / IXY Digital 900 IS',
    0x2010000 => 'PowerShot SD40 / Digital IXUS i7 / IXY Digital L4',
    0x2020000 => 'PowerShot A710 IS',
    0x2030000 => 'PowerShot A640',
    0x2040000 => 'PowerShot A630',
    0x2090000 => 'PowerShot S5 IS',
    0x2100000 => 'PowerShot A460',
    0x2120000 => 'PowerShot SD850 IS / Digital IXUS 950 IS / IXY Digital 810 IS',
    0x2130000 => 'PowerShot A570 IS',
    0x2140000 => 'PowerShot A560',
    0x2150000 => 'PowerShot SD750 / Digital IXUS 75 / IXY Digital 90',
    0x2160000 => 'PowerShot SD1000 / Digital IXUS 70 / IXY Digital 10',
    0x2180000 => 'PowerShot A550',
    0x2190000 => 'PowerShot A450',
    0x2230000 => 'PowerShot G9',
    0x2240000 => 'PowerShot A650 IS',
    0x2260000 => 'PowerShot A720 IS',
    0x2290000 => 'PowerShot SX100 IS',
    0x2300000 => 'PowerShot SD950 IS / Digital IXUS 960 IS / IXY Digital 2000 IS',
    0x2310000 => 'PowerShot SD870 IS / Digital IXUS 860 IS / IXY Digital 910 IS',
    0x2320000 => 'PowerShot SD890 IS / Digital IXUS 970 IS / IXY Digital 820 IS',
    0x2360000 => 'PowerShot SD790 IS / Digital IXUS 90 IS / IXY Digital 95 IS',
    0x2370000 => 'PowerShot SD770 IS / Digital IXUS 85 IS / IXY Digital 25 IS',
    0x2380000 => 'PowerShot A590 IS',
    0x2390000 => 'PowerShot A580',
    0x2420000 => 'PowerShot A470',
    0x2430000 => 'PowerShot SD1100 IS / Digital IXUS 80 IS / IXY Digital 20 IS',
    0x2460000 => 'PowerShot SX1 IS',
    0x2470000 => 'PowerShot SX10 IS',
    0x2480000 => 'PowerShot A1000 IS',
    0x2490000 => 'PowerShot G10',
    0x2510000 => 'PowerShot A2000 IS',
    0x2520000 => 'PowerShot SX110 IS',
    0x2530000 => 'PowerShot SD990 IS / Digital IXUS 980 IS / IXY Digital 3000 IS',
    0x2540000 => 'PowerShot SD880 IS / Digital IXUS 870 IS / IXY Digital 920 IS',
    0x2550000 => 'PowerShot E1',
    0x2560000 => 'PowerShot D10',
    0x2570000 => 'PowerShot SD960 IS / Digital IXUS 110 IS / IXY Digital 510 IS',
    0x2580000 => 'PowerShot A2100 IS',
    0x2590000 => 'PowerShot A480',
    0x2600000 => 'PowerShot SX200 IS',
    0x2610000 => 'PowerShot SD970 IS / Digital IXUS 990 IS / IXY Digital 830 IS',
    0x2620000 => 'PowerShot SD780 IS / Digital IXUS 100 IS / IXY Digital 210 IS',
    0x2630000 => 'PowerShot A1100 IS',
    0x2640000 => 'PowerShot SD1200 IS / Digital IXUS 95 IS / IXY Digital 110 IS',
    0x3010000 => 'PowerShot Pro90 IS',
    0x4040000 => 'PowerShot G1',
    0x6040000 => 'PowerShot S100 / Digital IXUS / IXY Digital',
    0x4007d675 => 'HV10',
    0x4007d777 => 'iVIS DC50',
    0x4007d778 => 'iVIS HV20',
    0x4007d779 => 'DC211', #29
    0x4007d77b => 'iVIS HR10', #29
    0x4007d87f => 'FS100',
    0x4007d880 => 'iVIS HF10', #29 (VIXIA HF10)
    0x80000001 => 'EOS-1D',
    0x80000167 => 'EOS-1DS',
    0x80000168 => 'EOS 10D',
    0x80000169 => 'EOS-1D Mark III',
    0x80000170 => 'EOS Digital Rebel / 300D / Kiss Digital',
    0x80000174 => 'EOS-1D Mark II',
    0x80000175 => 'EOS 20D',
    0x80000176 => 'EOS Digital Rebel XSi / 450D / Kiss X2',
    0x80000188 => 'EOS-1Ds Mark II',
    0x80000189 => 'EOS Digital Rebel XT / 350D / Kiss Digital N',
    0x80000190 => 'EOS 40D',
    0x80000213 => 'EOS 5D',
    0x80000215 => 'EOS-1Ds Mark III',
    0x80000218 => 'EOS 5D Mark II', #25
    0x80000232 => 'EOS-1D Mark II N',
    0x80000234 => 'EOS 30D',
    0x80000236 => 'EOS Digital Rebel XTi / 400D / Kiss Digital X (and rare K236)',
    0x80000252 => 'EOS Rebel T1i / 500D / Kiss X3', #25
    0x80000254 => 'EOS Rebel XS / 1000D / Kiss F',
    0x80000261 => 'EOS 50D',
);

my %canonQuality = (
    1 => 'Economy',
    2 => 'Normal',
    3 => 'Fine',
    4 => 'RAW',
    5 => 'Superfine',
    130 => 'Normal Movie', #22
);
my %canonImageSize = (
    0 => 'Large',
    1 => 'Medium',
    2 => 'Small',
    5 => 'Medium 1', #PH
    6 => 'Medium 2', #PH
    7 => 'Medium 3', #PH
    8 => 'Postcard', #PH (SD200 1600x1200 with DateStamp option)
    9 => 'Widescreen', #PH (SD900 3648x2048)
    129 => 'Medium Movie', #22
    130 => 'Small Movie', #22
);
my %canonWhiteBalance = (
    # -1='Click", -2='Pasted' ?? - PH
    0 => 'Auto',
    1 => 'Daylight',
    2 => 'Cloudy',
    3 => 'Tungsten',
    4 => 'Fluorescent',
    5 => 'Flash',
    6 => 'Custom',
    7 => 'Black & White',
    8 => 'Shade',
    9 => 'Manual Temperature (Kelvin)',
    10 => 'PC Set1', #PH
    11 => 'PC Set2', #PH
    12 => 'PC Set3', #PH
    14 => 'Daylight Fluorescent', #3
    15 => 'Custom 1', #PH
    16 => 'Custom 2', #PH
    17 => 'Underwater', #3
    18 => 'Custom 3', #PH
    19 => 'Custom 4', #PH
    20 => 'PC Set4', #PH
    21 => 'PC Set5', #PH
);

# picture styles used by the 5D
# (styles 0x4X may be downloaded from Canon)
# (called "ColorMatrix" in 1D owner manual)
my %pictureStyles = ( #12
    0x00 => 'None', #PH
    0x01 => 'Standard', #15
    0x02 => 'Portrait', #15
    0x03 => 'High Saturation', #15
    0x04 => 'Adobe RGB', #15
    0x05 => 'Low Saturation', #15
    0x06 => 'CM Set 1', #PH
    0x07 => 'CM Set 2', #PH
    # "ColorMatrix" values end here
    0x21 => 'User Def. 1',
    0x22 => 'User Def. 2',
    0x23 => 'User Def. 3',
    # "External" styles currently available from Canon are Nostalgia, Clear,
    # Twilight and Emerald.  The "User Def" styles change to these "External"
    # codes when these styles are installed in the camera
    0x41 => 'PC 1', #PH
    0x42 => 'PC 2', #PH
    0x43 => 'PC 3', #PH
    0x81 => 'Standard',
    0x82 => 'Portrait',
    0x83 => 'Landscape',
    0x84 => 'Neutral',
    0x85 => 'Faithful',
    0x86 => 'Monochrome',
);
my %userDefStyles = ( #12
    0x41 => 'Nostalgia',
    0x42 => 'Clear',
    0x43 => 'Twilight',
    0x81 => 'Standard',
    0x82 => 'Portrait',
    0x83 => 'Landscape',
    0x84 => 'Neutral',
    0x85 => 'Faithful',
    0x86 => 'Monochrome',
);

# ValueConv that makes long values binary type
my %longBin = (
    ValueConv => 'length($val) > 64 ? \$val : $val',
    ValueConvInv => '$val',
);

# conversions, etc for CameraColorCalibration tags
my %cameraColorCalibration = (
    Format => 'int16s[4]',
    Unknown => 1,
    PrintConv => 'sprintf("%4d %4d %4d (%dK)", split(" ",$val))',
    PrintConvInv => '$val=~s/\s+/ /g; $val=~tr/()K//d; $val',
);

# conversions, etc for PowerShot CameraColorCalibration tags
my %cameraColorCalibration2 = (
    Format => 'int16s[5]',
    Unknown => 1,
    PrintConv => 'sprintf("%4d %4d %4d %4d (%dK)", split(" ",$val))',
    PrintConvInv => '$val=~s/\s+/ /g; $val=~tr/()K//d; $val',
);

#------------------------------------------------------------------------------
# Canon EXIF Maker Notes
%Image::ExifTool::Canon::Main = (
    WRITE_PROC => \&WriteCanon,
    CHECK_PROC => \&Image::ExifTool::Exif::CheckExif,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    0x1 => {
        Name => 'CanonCameraSettings',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::CameraSettings',
        },
    },
    0x2 => {
        Name => 'CanonFocalLength',
        SubDirectory => {
            TagTable => 'Image::ExifTool::Canon::FocalLength',
        },
    },
    0x3 => {
        Name => 'CanonFlashInfo',
        Unknown => 1,
    },
    0x4 => {
        Name => 'CanonShotInfo',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::ShotInfo',
        },
    },
    0x5 => {
        Name => 'CanonPanorama',
        SubDirectory => {
            TagTable => 'Image::ExifTool::Canon::Panorama',
        },
    },
    0x6 => {
        Name => 'CanonImageType',
        Writable => 'string',
        Groups => { 2 => 'Image' },
    },
    0x7 => {
        Name => 'CanonFirmwareVersion',
        Writable => 'string',
    },
    0x8 => {
        Name => 'FileNumber',
        Writable => 'int32u',
        Groups => { 2 => 'Image' },
        PrintConv => '$_=$val,s/(\d+)(\d{4})/$1-$2/,$_',
        PrintConvInv => '$val=~s/-//g;$val',
    },
    0x9 => {
        Name => 'OwnerName',
        Writable => 'string',
    },
    0xa => {
        Name => 'UnknownD30',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::UnknownD30',
        },
    },
    0xc => [   # square brackets for a conditional list
        {
            # D30
            Name => 'SerialNumber',
            Description => 'Camera Body No.',
            Condition => '$$self{Model} =~ /EOS D30\b/',
            Writable => 'int32u',
            PrintConv => 'sprintf("%x-%.5d",$val>>16,$val&0xffff)',
            PrintConvInv => '$val=~/(.*)-(\d+)/ ? (hex($1)<<16)+$2 : undef',
        },
        {
            # serial number of 1D/1Ds/1D Mark II/1Ds Mark II is usually
            # displayed w/o leeding zeros (ref 7) (1D uses 6 digits - PH)
            Name => 'SerialNumber',
            Description => 'Camera Body No.',
            Condition => '$$self{Model} =~ /EOS-1D/',
            Writable => 'int32u',
            PrintConv => 'sprintf("%.6u",$val)',
            PrintConvInv => '$val',
        },
        {
            # all other models (D60,300D,350D,REBEL,10D,20D,etc)
            Name => 'SerialNumber',
            Description => 'Camera Body No.',
            Writable => 'int32u',
            PrintConv => 'sprintf("%.10u",$val)',
            PrintConvInv => '$val',
        },
    ],
    0xd => [
        {
            Name => 'CanonCameraInfo1D',
            Condition => '$$self{Model} =~ /\b1DS?$/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfo1D',
            },
        },
        {
            Name => 'CanonCameraInfo1DmkII',
            Condition => '$$self{Model} =~ /\b1Ds? Mark II$/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfo1DmkII',
            },
        },
        {
            Name => 'CanonCameraInfo1DmkIIN',
            Condition => '$$self{Model} =~ /\b1Ds? Mark II N$/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfo1DmkIIN',
            },
        },
        {
            Name => 'CanonCameraInfo1DmkIII',
            Condition => '$$self{Model} =~ /\b1Ds? Mark III$/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfo1DmkIII',
            },
        },
        {
            Name => 'CanonCameraInfo5D',
            Condition => '$$self{Model} =~ /EOS 5D$/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfo5D',
            },
        },
        {
            Name => 'CanonCameraInfo5DmkII',
            Condition => '$$self{Model} =~ /EOS 5D Mark II$/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfo5DmkII',
            },
        },
        {
            Name => 'CanonCameraInfo40D',
            Condition => '$$self{Model} =~ /EOS 40D$/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfo40D',
            },
        },
        {
            Name => 'CanonCameraInfo50D',
            Condition => '$$self{Model} =~ /EOS 50D$/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfo50D',
            },
        },
        {
            Name => 'CanonCameraInfo450D',
            Condition => '$$self{Model} =~ /\b(450D|REBEL XSi|Kiss X2)\b/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfo450D',
            },
        },
        {
            Name => 'CanonCameraInfo500D',
            Condition => '$$self{Model} =~ /\b(500D|REBEL T1i|Kiss X3)\b/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfo500D',
            },
        },
        {
            Name => 'CanonCameraInfo1000D',
            Condition => '$$self{Model} =~ /\b(1000D|REBEL XS|Kiss F)\b/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfo1000D',
            },
        },
        {
            Name => 'CanonCameraInfoPowerShot',
            # valid if format is int32u[138] or int32u[148]
            Condition => '$format eq "int32u" and ($count == 138 or $count == 148)',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfoPowerShot',
            },
        },
        {
            Name => 'CanonCameraInfoUnknown32',
            Condition => '$format =~ /^int32/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfoUnknown32',
            },
        },
        {
            Name => 'CanonCameraInfoUnknown16',
            Condition => '$format =~ /^int16/',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfoUnknown16',
            },
        },
        {
            Name => 'CanonCameraInfoUnknown',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::CameraInfoUnknown',
            },
        },
    ],
    0xe => {
        Name => 'CanonFileLength',
        Writable => 'int32u',
        Groups => { 2 => 'Image' },
    },
    0xf => [
        {   # used by 1DmkII, 1DSmkII and 1DmkIIN
            Name => 'CustomFunctions1D',
            Condition => '$$self{Model} =~ /EOS-1D/',
            SubDirectory => {
                Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
                TagTable => 'Image::ExifTool::CanonCustom::Functions1D',
            },
        },
        {
            Name => 'CustomFunctions5D',
            Condition => '$$self{Model} =~ /EOS 5D/',
            SubDirectory => {
                Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
                TagTable => 'Image::ExifTool::CanonCustom::Functions5D',
            },
        },
        {
            Name => 'CustomFunctions10D',
            Condition => '$$self{Model} =~ /EOS 10D/',
            SubDirectory => {
                Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
                TagTable => 'Image::ExifTool::CanonCustom::Functions10D',
            },
        },
        {
            Name => 'CustomFunctions20D',
            Condition => '$$self{Model} =~ /EOS 20D/',
            SubDirectory => {
                Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
                TagTable => 'Image::ExifTool::CanonCustom::Functions20D',
            },
        },
        {
            Name => 'CustomFunctions30D',
            Condition => '$$self{Model} =~ /EOS 30D/',
            SubDirectory => {
                Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
                TagTable => 'Image::ExifTool::CanonCustom::Functions30D',
            },
        },
        {
            Name => 'CustomFunctions350D',
            Condition => '$$self{Model} =~ /\b(350D|REBEL XT|Kiss Digital N)\b/',
            SubDirectory => {
                Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
                TagTable => 'Image::ExifTool::CanonCustom::Functions350D',
            },
        },
        {
            Name => 'CustomFunctions400D',
            Condition => '$$self{Model} =~ /\b(400D|REBEL XTi|Kiss Digital X|K236)\b/',
            SubDirectory => {
                Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
                TagTable => 'Image::ExifTool::CanonCustom::Functions400D',
            },
        },
        {
            Name => 'CustomFunctionsD30',
            Condition => '$$self{Model} =~ /EOS D30\b/',
            SubDirectory => {
                Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
                TagTable => 'Image::ExifTool::CanonCustom::FunctionsD30',
            },
        },
        {
            Name => 'CustomFunctionsD60',
            Condition => '$$self{Model} =~ /EOS D60\b/',
            SubDirectory => {
                # the stored size in the D60 apparently doesn't include the size word:
                Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size-2,$size)',
                # (D60 custom functions are basically the same as D30)
                TagTable => 'Image::ExifTool::CanonCustom::FunctionsD30',
            },
        },
        {
            Name => 'CustomFunctionsUnknown',
            SubDirectory => {
                Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
                TagTable => 'Image::ExifTool::CanonCustom::FuncsUnknown',
            },
        },
    ],
    0x10 => { #PH
        Name => 'CanonModelID',
        Writable => 'int32u',
        PrintHex => 1,
        SeparateTable => 1,
        DataMember => 'CanonModelID',
        RawConv => '$$self{CanonModelID} = $val',
        PrintConv => \%canonModelID,
    },
    0x12 => {
        Name => 'CanonAFInfo',
        # not really a condition -- just need to store the count for later
        Condition => '$$self{AFInfoCount} = $count',
        SubDirectory => {
            # this record does not begin with a length word, so it
            # has to be validated differently
            Validate => 'Image::ExifTool::Canon::ValidateAFInfo($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::AFInfo',
        },
    },
    0x13 => { #PH
        Name => 'ThumbnailImageValidArea',
        # left,right,top,bottom edges of image in thumbnail, or all zeros for full frame
        Notes => 'all zeros for full frame',
        Writable => 'int16u',
        Count => 4,
    },
    0x15 => { #PH
        # display format for serial number
        Name => 'SerialNumberFormat',
        Writable => 'int32u',
        PrintHex => 1,
        PrintConv => {
            0x90000000 => 'Format 1',
            0xa0000000 => 'Format 2',
        },
    },
    0x1a => { #15
        Name => 'SuperMacro',
        Writable => 'int16u',
        PrintConv => {
            0 => 'Off',
            1 => 'On (1)',
            2 => 'On (2)',
        },
    },
    0x1c => { #PH (A570IS)
        Name => 'DateStampMode',
        Writable => 'int16u',
        Notes => 'only used in postcard mode',
        PrintConv => {
            0 => 'Off',
            1 => 'Date',
            2 => 'Date & Time',
        },
    },
    0x1d => { #PH
        Name => 'MyColors',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::MyColors',
        },
    },
    0x1e => { #PH
        Name => 'FirmwareRevision',
        Writable => 'int32u',
        # as a hex number: 0xAVVVRR00, where (a bit of guessing here...)
        #  A = 'a' for alpha, 'b' for beta?
        #  V = version? (100,101 for normal releases, 100,110,120,130,170 for alpha/beta)
        #  R = revision? (01-07, except 00 for alpha/beta releases)
        PrintConv => q{
            my $rev = sprintf("%.8x", $val);
            my ($rel, $v1, $v2, $r1, $r2) = ($rev =~ /^(.)(.)(..)0?(.+)(..)$/);
            my %r = ( a => 'Alpha ', b => 'Beta ', '0' => '' );
            $rel = defined $r{$rel} ? $r{$rel} : "Unknown($rel) ";
            return "$rel$v1.$v2 rev $r1.$r2",
        },
        PrintConvInv => q{
            $_=$val; s/Alpha ?/a/i; s/Beta ?/b/i;
            s/Unknown ?\((.)\)/$1/i; s/ ?rev ?(.)\./0$1/; s/ ?rev ?//;
            tr/a-fA-F0-9//dc; return hex $_;
        },
    },
    # 0x1f - used for red-eye-corrected images - PH (A570IS)
    # 0x22 - values 1 and 2 are 2 and 1 for flash pics, 0 otherwise - PH (A570IS)
    0x23 => { #31
        Name => 'Categories',
        Writable => 'int32u',
        Format => 'int32u', # (necessary to perform conversion for Condition)
        Notes => '2 values: 1. always 8, 2. Categories',
        Count => '2',
        Condition => '$$valPt =~ /^\x08\0\0\0/',
        ValueConv => '$val =~ s/^8 //; $val',
        ValueConvInv => '"8 $val"',
        PrintConv => { BITMASK => {
            0 => 'People',
            1 => 'Scenery',
            2 => 'Events',
            3 => 'User 1',
            4 => 'User 2',
            5 => 'User 3',
            6 => 'To Do',
        } },
    },
    0x24 => { #PH
        Name => 'FaceDetect1',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::FaceDetect1',
        },
    },
    0x25 => { #PH
        Name => 'FaceDetect2',
        SubDirectory => {
            TagTable => 'Image::ExifTool::Canon::FaceDetect2',
        },
    },
    0x26 => { #PH (A570IS,1DmkIII)
        Name => 'CanonAFInfo2',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::AFInfo2',
        },
    },
    # 0x27 - value 1 is 1 for high ISO pictures, 0 otherwise
    #        value 4 is 9 for Flexizone and FaceDetect AF, 1 for Centre AF, 0 otherwise (SX10IS)
    0x28 => { #JD
        # bytes 0-1=sequence number (encrypted), 2-5=date/time (encrypted) (ref JD)
        Name => 'ImageUniqueID',
        Format => 'undef',
        Writable => 'int8u',
        Groups => { 2 => 'Image' },
        RawConv => '$val eq "\0" x 16 ? undef : $val',
        ValueConv => 'unpack("H*", $val)',
        ValueConvInv => 'pack("H*", $val)',
    },
    # 0x2d - changes with categories (ref 31)
    0x81 => { #13
        Name => 'RawDataOffset',
        # (can't yet write 1D raw files)
        # Writable => 'int32u',
        # Protected => 2,
    },
    0x83 => { #PH
        Name => 'OriginalDecisionDataOffset',
        Writable => 'int32u',
        OffsetPair => 1, # (just used as a flag, since this tag has no pair)
        # this is an offset to the original decision data block
        # (offset relative to start of file in JPEG images, but NOT DNG images!)
        IsOffset => '$val and $$exifTool{FILE_TYPE} ne "JPEG"',
        Protected => 2,
        DataTag => 'OriginalDecisionData',
    },
    0x90 => {   # used by 1D and 1Ds
        Name => 'CustomFunctions1D',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::CanonCustom::Functions1D',
        },
    },
    0x91 => { #PH
        Name => 'PersonalFunctions',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::CanonCustom::PersonalFuncs',
        },
    },
    0x92 => { #PH
        Name => 'PersonalFunctionValues',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::CanonCustom::PersonalFuncValues',
        },
    },
    0x93 => {
        Name => 'CanonFileInfo',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::FileInfo',
        },
    },
    0x94 => { #PH
        # AF points for 1D (45 points in 5 rows)
        Name => 'AFPointsInFocus1D',
        Notes => 'EOS 1D -- 5 rows: A1-7, B1-10, C1-11, D1-10, E1-7, center point is C6',
        PrintConv => 'Image::ExifTool::Canon::PrintAFPoints1D($val)',
    },
    0x95 => { #PH (observed in 5D sample image)
        Name => 'LensModel',
        Writable => 'string',
    },
    0x96 => [ #PH
        {
            Name => 'SerialInfo',
            Condition => '$$self{Model} =~ /EOS 5D/',
            SubDirectory => { TagTable => 'Image::ExifTool::Canon::SerialInfo' },
        },
        {
            Name => 'InternalSerialNumber',
            Writable => 'string',
            # remove trailing 0xff's if they exist (Kiss X3)
            ValueConv => '$val=~s/\xff+$//; $val',
            ValueConvInv => '$val',
        },
    ],
    0x97 => { #PH
        Name => 'DustRemovalData',
        # some interesting stuff is stored in here, like LensType and InternalSerialNumber...
        Binary => 1,
    },
    0x99 => { #PH (EOS 1D Mark III, 40D, etc)
        Name => 'CustomFunctions2',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::CanonCustom::Functions2',
        },
    },
    # 0x9a - 5 numbers, the 2nd and 3rd are imagewidth/height (EOS 1DmkIII and 40D)
    #        (for the 5DmkII, this is true for raw and sraw2 images, but not sraw1)
    0xa0 => {
        Name => 'ProcessingInfo',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::Processing',
        },
    },
    0xa1 => { Name => 'ToneCurveTable', %longBin }, #PH
    0xa2 => { Name => 'SharpnessTable', %longBin }, #PH
    0xa3 => { Name => 'SharpnessFreqTable', %longBin }, #PH
    0xa4 => { Name => 'WhiteBalanceTable', %longBin }, #PH
    0xa9 => {
        Name => 'ColorBalance',
        SubDirectory => {
            # this offset is necessary because the table is interpreted as short rationals
            # (4 bytes long) but the first entry is 2 bytes into the table.
            Start => '$valuePtr + 2',
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart-2,$size+2)',
            TagTable => 'Image::ExifTool::Canon::ColorBalance',
        },
    },
    0xaa => {
        Name => 'MeasuredColor',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::MeasuredColor',
        },
    },
    0xae => {
        Name => 'ColorTemperature',
        Writable => 'int16u',
    },
    0xb0 => { #PH
        Name => 'CanonFlags',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::Flags',
        },
    },
    0xb1 => { #PH
        Name => 'ModifiedInfo',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::ModifiedInfo',
        },
    },
    0xb2 => { Name => 'ToneCurveMatching', %longBin }, #PH
    0xb3 => { Name => 'WhiteBalanceMatching', %longBin }, #PH
    0xb4 => { #PH
        Name => 'ColorSpace',
        Writable => 'int16u',
        PrintConv => {
            1 => 'sRGB',
            2 => 'Adobe RGB',
        },
    },
    0xb6 => {
        Name => 'PreviewImageInfo',
        SubDirectory => {
            # Note: the first word of this block gives the correct block size in bytes, but
            # the size is wrong by a factor of 2 in the IFD, so we must account for this
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size/2)',
            TagTable => 'Image::ExifTool::Canon::PreviewImageInfo',
        },
    },
    0xd0 => { #PH
        Name => 'VRDOffset',
        Writable => 'int32u',
        OffsetPair => 1, # (just used as a flag, since this tag has no pair)
        Protected => 2,
        DataTag => 'CanonVRD',
        Notes => 'offset of VRD "recipe data" if it exists',
    },
    0xe0 => { #12
        Name => 'SensorInfo',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::SensorInfo',
        },
    },
    0x4001 => [ #13
        {   # (int16u[582]) - 20D and 350D
            Condition => '$count == 582',
            Name => 'ColorData1',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::ColorData1',
            },
        },
        {   # (int16u[653]) - 1DmkII and 1DSmkII
            Condition => '$count == 653',
            Name => 'ColorData2',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::ColorData2',
            },
        },
        {   # (int16u[796]) - 1DmkIIN, 5D, 30D, 400D
            Condition => '$count == 796',
            Name => 'ColorData3',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::ColorData3',
            },
        },
        {   # (int16u[692|674|702|1227])
            # 40D (692), 1DmkIII (674), 1DSmkIII (702), 450D/1000D (1227)
            # 50D/5DmkII (1250), 500D (1251)
            Condition => q{
                $count == 692  or $count == 674  or $count == 702 or
                $count == 1227 or $count == 1250 or $count == 1251
            },
            Name => 'ColorData4',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::ColorData4',
            },
        },
        {   # (int16u[5120]) - G10
            Condition => '$count == 5120',
            Name => 'ColorData5',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::ColorData5',
            },
        },
        {
            Name => 'ColorDataUnknown',
            SubDirectory => {
                TagTable => 'Image::ExifTool::Canon::ColorDataUnknown',
            },
        },
    ],
    0x4002 => { #PH
        # unknown data block in some JPEG and CR2 images
        # (5kB for most models, but 22kb for 5D and 30D)
        Name => 'UnknownBlock1',
        Format => 'undef',
        Flags => [ 'Unknown', 'Binary' ],
    },
    0x4003 => { #PH
        Name => 'ColorInfo',
        SubDirectory => {
            TagTable => 'Image::ExifTool::Canon::ColorInfo',
        },
    },
    0x4005 => { #PH
        Name => 'UnknownBlock2',
        Notes => 'unknown 49kB block, not copied to JPEG images',
        # 'Drop' because not found in JPEG images (too large for APP1 anyway)
        Flags => [ 'Unknown', 'Binary', 'Drop' ],
    },
    0x4008 => { #PH guess (1DmkIII)
        Name => 'BlackLevel',
        Unknown => 1,
    },
    0x4013 => { #PH
        Name => 'AFMicroAdj',
        SubDirectory => {
            Validate => 'Image::ExifTool::Canon::Validate($dirData,$subdirStart,$size)',
            TagTable => 'Image::ExifTool::Canon::AFMicroAdj',
        },
    },
);

#..............................................................................
# Canon camera settings (MakerNotes tag 0x01)
# BinaryData (keys are indices into the int16s array)
%Image::ExifTool::Canon::CameraSettings = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16s',
    FIRST_ENTRY => 1,
    DATAMEMBER => [ 25 ],   # FocalUnits necessary for writing
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    1 => {
        Name => 'MacroMode',
        PrintConv => {
            1 => 'Macro',
            2 => 'Normal',
        },
    },
    2 => {
        Name => 'SelfTimer',
        # Custom timer mode if bit 0x4000 is set - PH (A570IS)
        PrintConv => q{
            return 'Off' unless $val;
            return (($val&0xfff) / 10) . ' s' . ($val & 0x4000 ? ', Custom' : '');
        },
        PrintConvInv => q{
            return 0 if $val =~ /^Off/i;
            $val =~ s/\s*s(ec)?\b//i;
            $val =~ s/,?\s*Custom$//i ? ($val*10) | 0x4000 : $val*10;
        },
    },
    3 => {
        Name => 'Quality',
        PrintConv => \%canonQuality,
    },
    4 => {
        Name => 'CanonFlashMode',
        PrintConv => {
            0 => 'Off',
            1 => 'Auto',
            2 => 'On',
            3 => 'Red-eye reduction',
            4 => 'Slow-sync',
            5 => 'Red-eye reduction (Auto)',
            6 => 'Red-eye reduction (On)',
            16 => 'External flash', # not set in D30 or 300D
        },
    },
    5 => {
        Name => 'ContinuousDrive',
        PrintConv => {
            0 => 'Single',
            1 => 'Continuous',
            2 => 'Movie', #PH
            3 => 'Continuous, Speed Priority', #PH
            4 => 'Continuous, Low', #PH
            5 => 'Continuous, High', #PH
        },
    },
    7 => {
        Name => 'FocusMode',
        PrintConv => {
            0 => 'One-shot AF',
            1 => 'AI Servo AF',
            2 => 'AI Focus AF',
            3 => 'Manual Focus (3)',
            4 => 'Single',
            5 => 'Continuous',
            6 => 'Manual Focus (6)',
           16 => 'Pan Focus', #PH
        },
    },
    9 => { #PH
        Name => 'RecordMode',
        RawConv => '$val==-1 ? undef : $val', #22
        PrintConv => {
            1 => 'JPEG',
            2 => 'CRW+THM', # (300D,etc)
            3 => 'AVI+THM', # (30D)
            4 => 'TIF', # +THM? (1Ds) (unconfirmed)
            5 => 'TIF+JPEG', # (1D) (unconfirmed)
            6 => 'CR2', # +THM? (1D,30D,350D)
            7 => 'CR2+JPEG', # (S30)
        },
    },
    10 => {
        Name => 'CanonImageSize',
        PrintConv => \%canonImageSize,
    },
    11 => {
        Name => 'EasyMode',
        PrintConv => {
            0 => 'Full auto',
            1 => 'Manual',
            2 => 'Landscape',
            3 => 'Fast shutter',
            4 => 'Slow shutter',
            5 => 'Night',
            6 => 'Gray Scale', #PH
            7 => 'Sepia',
            8 => 'Portrait',
            9 => 'Sports',
            10 => 'Macro',
            11 => 'Black & White', #PH
            12 => 'Pan focus',
            13 => 'Vivid', #PH
            14 => 'Neutral', #PH
            15 => 'Flash Off',  #8
            16 => 'Long Shutter', #PH
            17 => 'Super Macro', #PH
            18 => 'Foliage', #PH
            19 => 'Indoor', #PH
            20 => 'Fireworks', #PH
            21 => 'Beach', #PH
            22 => 'Underwater', #PH
            23 => 'Snow', #PH
            24 => 'Kids & Pets', #PH
            25 => 'Night Snapshot', #PH
            26 => 'Digital Macro', #PH
            27 => 'My Colors', #PH
            28 => 'Still Image', #15 (animation frame?)
            30 => 'Color Accent', #18
            31 => 'Color Swap', #18
            32 => 'Aquarium', #18
            33 => 'ISO 3200', #18
            # 35 => 'Star Fantasy?', #15
            38 => 'Creative Auto', #39
            261 => 'Sunset', #PH (SX10IS)
        },
    },
    12 => {
        Name => 'DigitalZoom',
        PrintConv => {
            0 => 'None',
            1 => '2x',
            2 => '4x',
            3 => 'Other',  # value obtained from 2*$val[37]/$val[36]
        },
    },
    13 => {
        Name => 'Contrast',
        RawConv => '$val == 0x7fff ? undef : $val',
        %Image::ExifTool::Exif::printParameter,
    },
    14 => {
        Name => 'Saturation',
        RawConv => '$val == 0x7fff ? undef : $val',
        %Image::ExifTool::Exif::printParameter,
    },
    15 => {
        Name => 'Sharpness',
        RawConv => '$val == 0x7fff ? undef : $val',
        Notes => q{
            some models use a range of -2 to +2 where 0 is normal sharpening, and
            others use a range of 0 to 7 where 0 is no sharpening
        },
        PrintConv => '$val > 0 ? "+$val" : $val',
        PrintConvInv => '$val',
    },
    16 => {
        Name => 'CameraISO',
        RawConv => '$val != 0x7fff ? $val : undef',
        ValueConv => 'Image::ExifTool::Canon::CameraISO($val)',
        ValueConvInv => 'Image::ExifTool::Canon::CameraISO($val,1)',
    },
    17 => {
        Name => 'MeteringMode',
        PrintConv => {
            0 => 'Default', # older Ixus
            1 => 'Spot',
            2 => 'Average', #PH
            3 => 'Evaluative',
            4 => 'Partial',
            5 => 'Center-weighted average',
        },
    },
    18 => {
        # this is always 2 for the 300D - PH
        Name => 'FocusRange',
        PrintConv => {
            0 => 'Manual',
            1 => 'Auto',
            2 => 'Not Known',
            3 => 'Macro',
            4 => 'Very Close', #PH
            5 => 'Close', #PH
            6 => 'Middle Range', #PH
            7 => 'Far Range',
            8 => 'Pan Focus',
            9 => 'Super Macro', #PH
            10=> 'Infinity', #PH
        },
    },
    19 => {
        Name => 'AFPoint',
        Flags => 'PrintHex',
        RawConv => '$val==0 ? undef : $val',
        PrintConv => {
            0x2005 => 'Manual AF point selection',
            0x3000 => 'None (MF)',
            0x3001 => 'Auto AF point selection',
            0x3002 => 'Right',
            0x3003 => 'Center',
            0x3004 => 'Left',
            0x4001 => 'Auto AF point selection',
            0x4006 => 'Face Detect', #PH (A570IS)
        },
    },
    20 => {
        Name => 'CanonExposureMode',
        PrintConv => {
            0 => 'Easy',
            1 => 'Program AE',
            2 => 'Shutter speed priority AE',
            3 => 'Aperture-priority AE',
            4 => 'Manual',
            5 => 'Depth-of-field AE',
            6 => 'M-Dep', #PH
            7 => 'Bulb', #30
        },
    },
    22 => { #4
        Name => 'LensType',
        RawConv => '$val ? $val : undef', # don't use if value is zero
        SeparateTable => 1,
        PrintConv => \%canonLensTypes,
    },
    23 => {
        Name => 'LongFocal',
        Format => 'int16u',
        # this is a bit tricky, but we need the FocalUnits to convert this to mm
        RawConvInv => '$val * ($$self{FocalUnits} || 1)',
        ValueConv => '$val / ($$self{FocalUnits} || 1)',
        ValueConvInv => '$val',
        PrintConv => '"$val mm"',
        PrintConvInv => '$val=~s/\s*mm//;$val',
    },
    24 => {
        Name => 'ShortFocal',
        Format => 'int16u',
        RawConvInv => '$val * ($$self{FocalUnits} || 1)',
        ValueConv => '$val / ($$self{FocalUnits} || 1)',
        ValueConvInv => '$val',
        PrintConv => '"$val mm"',
        PrintConvInv => '$val=~s/\s*mm//;$val',
    },
    25 => {
        Name => 'FocalUnits',
        # conversion from raw focal length values to mm
        DataMember => 'FocalUnits',
        RawConv => '$$self{FocalUnits} = $val',
        PrintConv => '"$val/mm"',
        PrintConvInv => '$val=~s/\s*\/?\s*mm//;$val',
    },
    26 => { #9
        Name => 'MaxAperture',
        RawConv => '$val > 0 ? $val : undef',
        ValueConv => 'exp(Image::ExifTool::Canon::CanonEv($val)*log(2)/2)',
        ValueConvInv => 'Image::ExifTool::Canon::CanonEvInv(log($val)*2/log(2))',
        PrintConv => 'sprintf("%.2g",$val)',
        PrintConvInv => '$val',
    },
    27 => { #PH
        Name => 'MinAperture',
        RawConv => '$val > 0 ? $val : undef',
        ValueConv => 'exp(Image::ExifTool::Canon::CanonEv($val)*log(2)/2)',
        ValueConvInv => 'Image::ExifTool::Canon::CanonEvInv(log($val)*2/log(2))',
        PrintConv => 'sprintf("%.2g",$val)',
        PrintConvInv => '$val',
    },
    28 => {
        Name => 'FlashActivity',
        RawConv => '$val==-1 ? undef : $val',
    },
    29 => {
        Name => 'FlashBits',
        PrintConv => { BITMASK => {
            0 => 'Manual', #PH
            1 => 'TTL', #PH
            2 => 'A-TTL', #PH
            3 => 'E-TTL', #PH
            4 => 'FP sync enabled',
            7 => '2nd-curtain sync used',
            11 => 'FP sync used',
            13 => 'Built-in',
            14 => 'External', #(may not be set in manual mode - ref 37)
        } },
    },
    32 => {
        Name => 'FocusContinuous',
        RawConv => '$val==-1 ? undef : $val',
        PrintConv => {
            0 => 'Single',
            1 => 'Continuous',
            8 => 'Manual', #22
        },
    },
    33 => { #PH
        Name => 'AESetting',
        RawConv => '$val==-1 ? undef : $val',
        PrintConv => {
            0 => 'Normal AE',
            1 => 'Exposure Compensation',
            2 => 'AE Lock',
            3 => 'AE Lock + Exposure Comp.',
            4 => 'No AE',
        },
    },
    34 => { #PH
        Name => 'ImageStabilization',
        RawConv => '$val==-1 ? undef : $val',
        PrintConv => {
            0 => 'Off',
            1 => 'On',
            2 => 'On, Shot Only', #15 (panning for SX10IS)
            3 => 'On, Panning', #PH (A570IS)
        },
    },
    35 => { #PH
        Name => 'DisplayAperture',
        RawConv => '$val ? $val : undef',
        ValueConv => '$val / 10',
        ValueConvInv => '$val * 10',
    },
    36 => 'ZoomSourceWidth', #PH
    37 => 'ZoomTargetWidth', #PH
    39 => { #22
        Name => 'SpotMeteringMode',
        RawConv => '$val==-1 ? undef : $val',
        PrintConv => {
            0 => 'Center',
            1 => 'AF Point',
        },
    },
    40 => { #PH
        Name => 'PhotoEffect',
        RawConv => '$val==-1 ? undef : $val',
        PrintConv => {
            0 => 'Off',
            1 => 'Vivid',
            2 => 'Neutral',
            3 => 'Smooth',
            4 => 'Sepia',
            5 => 'B&W',
            6 => 'Custom',
            100 => 'My Color Data',
        },
    },
    41 => { #PH (A570IS)
        Name => 'ManualFlashOutput',
        PrintHex => 1,
        PrintConv => {
            0 => 'n/a',
            0x500 => 'Full',
            0x502 => 'Medium',
            0x504 => 'Low',
            0x7fff => 'n/a', # (EOS models)
        },
    },
    # 41 => non-zero for manual flash intensity - PH (A570IS)
    42 => {
        Name => 'ColorTone',
        RawConv => '$val == 0x7fff ? undef : $val',
        %Image::ExifTool::Exif::printParameter,
    },
    46 => { #PH
        Name => 'SRAWQuality',
        RawConv => '$val==-1 ? undef : $val',
        PrintConv => {
            0 => 'n/a',
            1 => 'sRAW1',
            2 => 'sRAW2',
        },
    },
);

# focal length information (MakerNotes tag 0x02)
%Image::ExifTool::Canon::FocalLength = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Image' },
    0 => { #9
        Name => 'FocalType',
        RawConv => '$val ? $val : undef', # don't use if value is zero
        PrintConv => {
            1 => 'Fixed',
            2 => 'Zoom',
        },
    },
    1 => {
        Name => 'FocalLength',
        # the EXIF FocalLength is more reliable, so set this priority to zero
        Priority => 0,
        RawConv => '$val ? $val : undef', # don't use if value is zero
        RawConvInv => q{
            my $focalUnits = $$self{FocalUnits};
            unless ($focalUnits) {
                $focalUnits = 1;
                # (this happens when writing FocalLength to CRW images)
                $self->Warn("FocalUnits not available for FocalLength conversion (1 assumed)");
            }
            return $val * $focalUnits;
        },
        ValueConv => '$val / ($$self{FocalUnits} || 1)',
        ValueConvInv => '$val',
        PrintConv => '"$val mm"',
        PrintConvInv => '$val=~s/\s*mm//;$val',
    },
    2 => [ #4
        {
            Name => 'FocalPlaneXSize',
            Notes => q{
                these focal plane sizes are only valid for some models, and are affected by
                digital zoom if applied
            },
            # this conversion is not valid for the 1DmkIII, 1DSmkIII, 5DmkII, 40D, 50D, 450D, 1000D
            Condition => '$$self{Model} !~ /\b(III|5D Mark II|40D|50D|450D|1000D|REBEL XSi?|Kiss (X2|F))\b/',
            # focal plane image dimensions in 1/1000 inch -- convert to mm
            RawConv => '$val < 40 ? undef : $val',  # must be reasonable
            ValueConv => '$val * 25.4 / 1000',
            ValueConvInv => 'int($val * 1000 / 25.4 + 0.5)',
            PrintConv => 'sprintf("%.2f mm",$val)',
            PrintConvInv => '$val=~s/\s*mm$//;$val',
        },{
            Name => 'FocalPlaneXUnknown',
            Unknown => 1,
        },
    ],
    3 => [ #4
        {
            Name => 'FocalPlaneYSize',
            Condition => '$$self{Model} !~ /\b(III|5D Mark II|40D|50D|450D|1000D|REBEL XSi?|Kiss (X2|F))\b/',
            RawConv => '$val < 40 ? undef : $val',  # must be reasonable
            ValueConv => '$val * 25.4 / 1000',
            ValueConvInv => 'int($val * 1000 / 25.4 + 0.5)',
            PrintConv => 'sprintf("%.2f mm",$val)',
            PrintConvInv => '$val=~s/\s*mm$//;$val',
        },{
            Name => 'FocalPlaneYUnknown',
            Unknown => 1,
        },
    ],
);

# Canon shot information (MakerNotes tag 0x04)
# BinaryData (keys are indices into the int16s array)
%Image::ExifTool::Canon::ShotInfo = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16s',
    FIRST_ENTRY => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Image' },
    DATAMEMBER => [ 19 ],
    1 => { #PH
        Name => 'AutoISO',
        Notes => 'actual ISO used = BaseISO * AutoISO / 100',
        ValueConv => 'exp($val/32*log(2))*100',
        ValueConvInv => '32*log($val/100)/log(2)',
        PrintConv => 'sprintf("%.0f",$val)',
        PrintConvInv => '$val',
    },
    2 => {
        Name => 'BaseISO',
        Priority => 0,
        RawConv => '$val ? $val : undef',
        ValueConv => 'exp($val/32*log(2))*100/32',
        ValueConvInv => '32*log($val*32/100)/log(2)',
        PrintConv => 'sprintf("%.0f",$val)',
        PrintConvInv => '$val',
    },
    3 => { #9/PH
        Name => 'MeasuredEV',
        Notes => q{
            this the Canon name for what could better be called MeasuredLV, and is
            offset by about -5 EV from the calculated LV for most models
        },
        ValueConv => '$val / 32',
        ValueConvInv => '$val * 32',
        PrintConv => 'sprintf("%.2f",$val)',
        PrintConvInv => '$val',
    },
    4 => { #2, 9
        Name => 'TargetAperture',
        RawConv => '$val > 0 ? $val : undef',
        ValueConv => 'exp(Image::ExifTool::Canon::CanonEv($val)*log(2)/2)',
        ValueConvInv => 'Image::ExifTool::Canon::CanonEvInv(log($val)*2/log(2))',
        PrintConv => 'sprintf("%.2g",$val)',
        PrintConvInv => '$val',
    },
    5 => { #2
        Name => 'TargetExposureTime',
        # ignore obviously bad values (also, -32768 may be used for n/a)
        # (note that a few models always write 0: DC211, and video models)
        RawConv => '($val > -1000 and ($val or $$self{Model}=~/(EOS|PowerShot|IXUS|IXY)/))? $val : undef',
        ValueConv => 'exp(-Image::ExifTool::Canon::CanonEv($val)*log(2))',
        ValueConvInv => 'Image::ExifTool::Canon::CanonEvInv(-log($val)/log(2))',
        PrintConv => 'Image::ExifTool::Exif::PrintExposureTime($val)',
        PrintConvInv => 'eval $val',
    },
    6 => {
        Name => 'ExposureCompensation',
        ValueConv => 'Image::ExifTool::Canon::CanonEv($val)',
        ValueConvInv => 'Image::ExifTool::Canon::CanonEvInv($val)',
        PrintConv => 'Image::ExifTool::Exif::ConvertFraction($val)',
        PrintConvInv => 'eval $val',
    },
    7 => {
        Name => 'WhiteBalance',
        PrintConv => \%canonWhiteBalance,
        SeparateTable => 1,
    },
    8 => { #PH
        Name => 'SlowShutter',
        PrintConv => {
            0 => 'Off',
            1 => 'Night Scene',
            2 => 'On',
            3 => 'None',
        },
    },
    9 => {
        Name => 'SequenceNumber',
        Description => 'Shot Number In Continuous Burst',
    },
    10 => { #PH/17
        Name => 'OpticalZoomCode',
        Groups => { 2 => 'Camera' },
        Notes => 'for many PowerShot models, a this is 0-6 for wide-tele zoom',
        # (for many models, 0-6 represent 0-100% zoom, but it is always 8 for
        #  EOS models, and I have seen values of 16,20,28,32 and 39 too...)
        # - set to 8 for "n/a" by Canon software (ref 22)
        PrintConv => '$val == 8 ? "n/a" : $val',
        PrintConvInv => '$val =~ /[a-z]/i ? 8 : $val',
    },
    # 11 - (8 for all EOS samples, [0,8] for other models - PH)
    13 => { #PH
        Name => 'FlashGuideNumber',
        RawConv => '$val==-1 ? undef : $val',
        ValueConv => '$val / 32',
        ValueConvInv => '$val * 32',
    },
    # AF points for Ixus and IxusV cameras - 02/17/04 M. Rommel (also D30/D60 - PH)
    14 => { #2
        Name => 'AFPointsInFocus',
        Notes => 'used by D30, D60 and some PowerShot/Ixus models',
        Groups => { 2 => 'Camera' },
        Flags => 'PrintHex',
        RawConv => '$val==0 ? undef : $val',
        PrintConv => {
            0x3000 => 'None (MF)',
            0x3001 => 'Right',
            0x3002 => 'Center',
            0x3003 => 'Center+Right',
            0x3004 => 'Left',
            0x3005 => 'Left+Right',
            0x3006 => 'Left+Center',
            0x3007 => 'All',
        },
    },
    15 => {
        Name => 'FlashExposureComp',
        Description => 'Flash Exposure Compensation',
        ValueConv => 'Image::ExifTool::Canon::CanonEv($val)',
        ValueConvInv => 'Image::ExifTool::Canon::CanonEvInv($val)',
        PrintConv => 'Image::ExifTool::Exif::ConvertFraction($val)',
        PrintConvInv => 'eval $val',
    },
    16 => {
        Name => 'AutoExposureBracketing',
        PrintConv => {
            -1 => 'On',
            0 => 'Off',
            1 => 'On (shot 1)',
            2 => 'On (shot 2)',
            3 => 'On (shot 3)',
        },
    },
    17 => {
        Name => 'AEBBracketValue',
        ValueConv => 'Image::ExifTool::Canon::CanonEv($val)',
        ValueConvInv => 'Image::ExifTool::Canon::CanonEvInv($val)',
        PrintConv => 'Image::ExifTool::Exif::ConvertFraction($val)',
        PrintConvInv => 'eval $val',
    },
    18 => { #22
        Name => 'ControlMode',
        PrintConv => {
            0 => 'n/a',
            1 => 'Camera Local Control',
            3 => 'Computer Remote Control',
        },
    },
    19 => {
        Name => 'FocusDistanceUpper',
        DataMember => 'FocusDistanceUpper',
        Notes => q{
            FocusDistance tags are only extracted if FocusDistanceUpper is non-zero
            since they are not used by some newer models such as 450D and 1000D
        },
        RawConv => '($$self{FocusDistanceUpper} = $val) || undef',
        ValueConv => '$val * 0.01',
        ValueConvInv => '$val / 0.01',
    },
    20 => {
        Name => 'FocusDistanceLower',
        Condition => '$$self{FocusDistanceUpper}',
        ValueConv => '$val * 0.01',
        ValueConvInv => '$val / 0.01',
    },
    21 => {
        Name => 'FNumber',
        Priority => 0,
        RawConv => '$val ? $val : undef',
        # approximate big translation table by simple calculation - PH
        ValueConv => 'exp(Image::ExifTool::Canon::CanonEv($val)*log(2)/2)',
        ValueConvInv => 'Image::ExifTool::Canon::CanonEvInv(log($val)*2/log(2))',
        PrintConv => 'sprintf("%.2g",$val)',
        PrintConvInv => '$val',
    },
    22 => [
        {
            Name => 'ExposureTime',
            # encoding is different for 20D and 350D (darn!)
            # (but note that encoding is the same for TargetExposureTime - PH)
            Condition => '$$self{Model} =~ /\b(20D|350D|REBEL XT|Kiss Digital N)\b/',
            Priority => 0,
            # apparently a value of 0 is valid in a CRW image (=1s, D60 sample)
            RawConv => '($val or $$self{FILE_TYPE} eq "CRW") ? $val : undef',
            # approximate big translation table by simple calculation - PH
            ValueConv => 'exp(-Image::ExifTool::Canon::CanonEv($val)*log(2))*1000/32',
            ValueConvInv => 'Image::ExifTool::Canon::CanonEvInv(-log($val*32/1000)/log(2))',
            PrintConv => 'Image::ExifTool::Exif::PrintExposureTime($val)',
            PrintConvInv => 'eval $val',
        },
        {
            Name => 'ExposureTime',
            Priority => 0,
            # apparently a value of 0 is valid in a CRW image (=1s, D60 sample)
            RawConv => '($val or $$self{FILE_TYPE} eq "CRW") ? $val : undef',
            # approximate big translation table by simple calculation - PH
            ValueConv => 'exp(-Image::ExifTool::Canon::CanonEv($val)*log(2))',
            ValueConvInv => 'Image::ExifTool::Canon::CanonEvInv(-log($val)/log(2))',
            PrintConv => 'Image::ExifTool::Exif::PrintExposureTime($val)',
            PrintConvInv => 'eval $val',
        },
    ],
    23 => { #37
        Name => 'MeasuredEV2',
        Description => 'Measured EV 2',
        RawConv => '$val ? $val : undef',
        ValueConv => '$val / 8 - 11',
        ValueConvInv => 'int(($val + 11) * 8 + 0.5)',
    },
    24 => {
        Name => 'BulbDuration',
        ValueConv => '$val / 10',
        ValueConvInv => '$val * 10',
    },
    # 25 - (usually 0, but 1 for 2s timer?, 19 for small AVI, 14 for large
    #       AVI, and -6 and -10 for shots 1 and 2 with stitch assist - PH)
    26 => { #15
        Name => 'CameraType',
        Groups => { 2 => 'Camera' },
        PrintConv => {
            248 => 'EOS High-end',
            250 => 'Compact',
            252 => 'EOS Mid-range',
            255 => 'DV Camera', #PH
        },
    },
    27 => {
        Name => 'AutoRotate',
        RawConv => '$val >= 0 ? $val : undef',
        PrintConv => {
           -1 => 'Unknown', # (set to -1 when rotated by Canon software)
            0 => 'None',
            1 => 'Rotate 90 CW',
            2 => 'Rotate 180',
            3 => 'Rotate 270 CW',
        },
    },
    28 => { #15
        Name => 'NDFilter',
        PrintConv => { 0 => 'Off', 1 => 'On' },
    },
    29 => {
        Name => 'SelfTimer2',
        RawConv => '$val >= 0 ? $val : undef',
        ValueConv => '$val / 10',
        ValueConvInv => '$val * 10',
    },
    33 => { #PH (A570IS)
        Name => 'FlashOutput',
        RawConv => '($$self{Model}=~/(PowerShot|IXUS|IXY)/ or $val) ? $val : undef',
        Notes => q{
            used only for PowerShot models, this has a maximum value of 500 for models
            like the A570IS
        },
    },
);

#..............................................................................
# common CameraInfo tag definitions
my %ciFNumber = (
    Name => 'FNumber',
    Format => 'int8u',
    Groups => { 2 => 'Image' },
    Priority => 0,
    RawConv => '$val ? $val : undef',
    ValueConv => 'exp(($val-8)/16*log(2))',
    ValueConvInv => 'log($val)*16/log(2)+8',
    PrintConv => 'sprintf("%.2g",$val)',
    PrintConvInv => '$val',
);
my %ciExposureTime = (
    Name => 'ExposureTime',
    Format => 'int8u',
    Groups => { 2 => 'Image' },
    Priority => 0,
    RawConv => '$val ? $val : undef',
    ValueConv => 'exp(4*log(2)*(1-Image::ExifTool::Canon::CanonEv($val-24)))',
    ValueConvInv => 'Image::ExifTool::Canon::CanonEvInv(1-log($val)/(4*log(2)))+24',
    PrintConv => 'Image::ExifTool::Exif::PrintExposureTime($val)',
    PrintConvInv => 'eval $val',
);
my %ciISO = (
    Name => 'ISO',
    Format => 'int8u',
    Groups => { 2 => 'Image' },
    Priority => 0,
    ValueConv => '100*exp(($val/8-9)*log(2))',
    ValueConvInv => '(log($val/100)/log(2)+9)*8',
    PrintConv => 'sprintf("%.0f",$val)',
    PrintConvInv => '$val',
);
my %ciCameraTemperature = (
    Name => 'CameraTemperature',
    Format => 'int8u',
    ValueConv => '$val - 128',
    ValueConvInv => '$val + 128',
    PrintConv => '"$val C"',
    PrintConvInv => '$val=~s/ ?C//',
);
my %ciFocalLength = (
    Name => 'FocalLength',
    Format => 'int16u',
    # the EXIF FocalLength is more reliable, so set this priority to zero
    Priority => 0,
    # ignore if zero
    RawConv => '$val ? $val : undef',
    # (just to make things confusing, the focal lengths are big-endian)
    ValueConv => 'unpack("n",pack("v",$val))',
    ValueConvInv => 'unpack("v",pack("n",$val))',
    PrintConv => '"$val mm"',
    PrintConvInv => '$val=~s/\s*mm//;$val',
);
my %ciShortFocal = (
    Name => 'ShortFocal',
    Format => 'int16u',
    # the other ShortFocal is more reliable, so set this priority to zero
    Priority => 0,
    # byte order is big-endian
    ValueConv => 'unpack("n",pack("v",$val))',
    ValueConvInv => 'unpack("v",pack("n",$val))',
    PrintConv => '"$val mm"',
    PrintConvInv => '$val=~s/\s*mm//;$val',
);
my %ciLongFocal = (
    Name => 'LongFocal',
    Format => 'int16u',
    # the other LongFocal is more reliable, so set this priority to zero
    Priority => 0,
    # byte order is big-endian
    ValueConv => 'unpack("n",pack("v",$val))',
    ValueConvInv => 'unpack("v",pack("n",$val))',
    PrintConv => '"$val mm"',
    PrintConvInv => '$val=~s/\s*mm//;$val',
);

#..............................................................................
# Camera information for 1D and 1DS (MakerNotes tag 0x0d)
# (ref 15 unless otherwise noted)
%Image::ExifTool::Canon::CameraInfo1D = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => q{
        Information in the "CameraInfo" records is tricky to decode because the
        encodings are very different than in other Canon records (even sometimes
        switching endianness between values within a single camera), plus there is
        considerable variation in format from model to model. The first table below
        lists CameraInfo tags for the 1D and 1DS.
    },
    0x04 => { %ciExposureTime }, #9
    0x0a => {
        Name => 'FocalLength',
        Format => 'int16u',
        # the EXIF FocalLength is more reliable, so set this priority to zero
        Priority => 0,
        # ignore if zero
        RawConv => '$val ? $val : undef',
        PrintConv => '"$val mm"',
        PrintConvInv => '$val=~s/\s*mm//;$val',
    },
    0x0d => { #9
        Name => 'LensType',
        SeparateTable => 1,
        RawConv => '$val ? $val : undef', # don't use if value is zero
        PrintConv => \%canonLensTypes,
    },
    0x0e => {
        Name => 'ShortFocal',
        Format => 'int16u',
        # the other ShortFocal is more reliable, so set this priority to zero
        Priority => 0,
        PrintConv => '"$val mm"',
        PrintConvInv => '$val=~s/\s*mm//;$val',
    },
    0x10 => {
        Name => 'LongFocal',
        Format => 'int16u',
        # the other LongFocal is more reliable, so set this priority to zero
        Priority => 0,
        PrintConv => '"$val mm"',
        PrintConvInv => '$val=~s/\s*mm//;$val',
    },
    0x41 => {
        Name => 'SharpnessFrequency',
        Condition => '$$self{Model} =~ /\b1D$/',
        Notes => '1D only',
        PrintConv => {
            0 => 'n/a',
            1 => 'Lowest',
            2 => 'Low',
            3 => 'Standard',
            4 => 'High',
            5 => 'Highest',
        },
    },
    0x42 => {
        Name => 'Sharpness',
        Format => 'int8s',
        Condition => '$$self{Model} =~ /\b1D$/',
        Notes => '1D only',
    },
    0x44 => {
        Name => 'WhiteBalance',
        Condition => '$$self{Model} =~ /\b1D$/',
        Notes => '1D only',
        SeparateTable => 1,
        PrintConv => \%canonWhiteBalance,
    },
    0x47 => {
        Name => 'SharpnessFrequency',
        Condition => '$$self{Model} =~ /\b1DS$/',
        Notes => '1DS only',
        PrintConv => {
            0 => 'n/a',
            1 => 'Lowest',
            2 => 'Low',
            3 => 'Standard',
            4 => 'High',
            5 => 'Highest',
        },
    },
    0x48 => [
        {
            Name => 'ColorTemperature',
            Format => 'int16u',
            Condition => '$$self{Model} =~ /\b1D$/',
            Notes => '1D only',
        },
        {
            Name => 'Sharpness',
            Format => 'int8s',
            Condition => '$$self{Model} =~ /\b1DS$/',
            Notes => '1DS only',
        },
    ],
    0x4a => {
        Name => 'WhiteBalance',
        Condition => '$$self{Model} =~ /\b1DS$/',
        Notes => '1DS only',
        SeparateTable => 1,
        PrintConv => \%canonWhiteBalance,
    },
    0x4b => {
        Name => 'PictureStyle',
        Condition => '$$self{Model} =~ /\b1D$/',
        Notes => "1D only, called 'Color Matrix' in owner's manual",
        Flags => ['PrintHex','SeparateTable'],
        PrintConv => \%pictureStyles,
    },
    0x4e => {
        Name => 'ColorTemperature',
        Format => 'int16u',
        Condition => '$$self{Model} =~ /\b1DS$/',
        Notes => '1DS only',
    },
    0x51 => {
        Name => 'PictureStyle',
        Condition => '$$self{Model} =~ /\b1DS$/',
        Notes => '1DS only',
        Flags => ['PrintHex','SeparateTable'],
        PrintConv => \%pictureStyles,
    },
);

# Camera information for 1DmkII and 1DSmkII (MakerNotes tag 0x0d)
# (ref 15 unless otherwise noted)
%Image::ExifTool::Canon::CameraInfo1DmkII = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'CameraInfo tags for the 1DmkII and 1DSmkII.',
    0x04 => { %ciExposureTime }, #9
    0x09 => { %ciFocalLength }, #9
    0x0d => { #9
        Name => 'LensType',
        SeparateTable => 1,
        RawConv => '$val ? $val : undef', # don't use if value is zero
        PrintConv => \%canonLensTypes,
    },
    0x11 => { %ciShortFocal }, #9
    0x13 => { %ciLongFocal }, #9
    0x2d => { #9
        Name => 'FocalType',
        Priority => 0,
        PrintConv => {
           0 => 'Fixed',
           2 => 'Zoom',
        },
    },
    0x36 => {
        Name => 'WhiteBalance',
        SeparateTable => 1,
        PrintConv => \%canonWhiteBalance,
    },
    0x37 => {
        Name => 'ColorTemperature',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val))',
        ValueConvInv => 'unpack("v",pack("n",$val))',
    },
    0x39 => {
        Name => 'CanonImageSize',
        Format => 'int16u',
        PrintConv => \%canonImageSize,
    },
    0x66 => {
        Name => 'JPEGQuality',
        Notes => 'a number from 1 to 10',
    },
    0x6c => { #12
        Name => 'PictureStyle',
        Flags => ['PrintHex','SeparateTable'],
        PrintConv => \%pictureStyles,
    },
    0x6e => {
        Name => 'Saturation',
        Format => 'int8s',
        %Image::ExifTool::Exif::printParameter,
    },
    0x6f => {
        Name => 'ColorTone',
        Format => 'int8s',
        %Image::ExifTool::Exif::printParameter,
    },
    0x72 => {
        Name => 'Sharpness',
        Format => 'int8s',
    },
    0x73 => {
        Name => 'Contrast',
        Format => 'int8s',
        %Image::ExifTool::Exif::printParameter,
    },
    0x75 => {
        Name => 'ISO',
        Format => 'string[5]',
    },
);

# Camera information for the 1DmkIIN (MakerNotes tag 0x0d)
# (ref 9 unless otherwise noted)
%Image::ExifTool::Canon::CameraInfo1DmkIIN = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'CameraInfo tags for the 1DmkIIN.',
    0x04 => { %ciExposureTime },
    0x09 => { %ciFocalLength },
    0x0d => {
        Name => 'LensType',
        SeparateTable => 1,
        RawConv => '$val ? $val : undef', # don't use if value is zero
        PrintConv => \%canonLensTypes,
    },
    0x11 => { %ciShortFocal },
    0x13 => { %ciLongFocal },
    0x36 => { #15
        Name => 'WhiteBalance',
        SeparateTable => 1,
        PrintConv => \%canonWhiteBalance,
    },
    0x37 => { #15
        Name => 'ColorTemperature',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val))',
        ValueConvInv => 'unpack("v",pack("n",$val))',
    },
    0x73 => { #15
        Name => 'PictureStyle',
        Flags => ['PrintHex','SeparateTable'],
        PrintConv => \%pictureStyles,
    },
    0x74 => { #15
        Name => 'Sharpness',
        Format => 'int8s',
    },
    0x75 => { #15
        Name => 'Contrast',
        Format => 'int8s',
        %Image::ExifTool::Exif::printParameter,
    },
    0x76 => { #15
        Name => 'Saturation',
        Format => 'int8s',
        %Image::ExifTool::Exif::printParameter,
    },
    0x77 => { #15
        Name => 'ColorTone',
        Format => 'int8s',
        %Image::ExifTool::Exif::printParameter,
    },
    0x79 => { #15
        Name => 'ISO',
        Format => 'string[5]',
    },
);

# Canon camera information for 1DmkIII and 1DSmkIII (MakerNotes tag 0x0d)
# (ref PH unless otherwise noted)
%Image::ExifTool::Canon::CameraInfo1DmkIII = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'CameraInfo tags for the 1DmkIII and 1DSmkIII.',
    0x03 => { %ciFNumber },
    0x04 => { %ciExposureTime }, #9
    0x06 => { %ciISO },
    0x18 => { %ciCameraTemperature }, #36
    0x1d => { %ciFocalLength },
    0x43 => { #21/24
        Name => 'FocusDistanceUpper',
        Format => 'int16u',
        # (it looks like the focus distances are also odd-byte big-endian)
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x45 => { #21/24
        Name => 'FocusDistanceLower',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x5e => { #15
        Name => 'WhiteBalance',
        Format => 'int16u',
        PrintConv => \%canonWhiteBalance,
        SeparateTable => 1,
    },
    0x62 => { #15
        Name => 'ColorTemperature',
        Format => 'int16u',
    },
    0x86 => {
        Name => 'PictureStyle',
        Flags => ['PrintHex','SeparateTable'],
        PrintConv => \%pictureStyles,
    },
    0x112 => { #15
        Name => 'LensType',
        SeparateTable => 1,
        PrintConv => \%canonLensTypes,
    },
    0x113 => { %ciShortFocal },
    0x115 => { %ciLongFocal },
    0x136 => { #15
        Name => 'FirmwareVersion',
        Format => 'string[6]',
    },
    0x172 => {
        Name => 'FileIndex',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val + 1',
        ValueConvInv => '$val - 1',
    },
    0x176 => {
        Name => 'ShutterCount',
        Notes => 'may be valid only for some 1DmkIII copies, even running the same firmware',
        Format => 'int32u',
        ValueConv => '$val + 1',
        ValueConvInv => '$val - 1',
    },
    0x17e => { #(NC)
        Name => 'DirectoryIndex',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val - 1',
        ValueConvInv => '$val + 1',
    },
    0x45a => { #29
        Name => 'TimeStamp1',
        Condition => '$$self{Model} =~ /\b1D Mark III$/',
        Format => 'int32u',
        Groups => { 2 => 'Time' },
        # observed in 1DmkIII firmware 5.3.1 (pre-production), 1.0.3, 1.0.8
        Notes => 'only valid for some versions of the 1DmkIII firmware',
        Shift => 'Time',
        RawConv => '$val ? $val : undef',
        ValueConv => 'ConvertUnixTime($val)',
        ValueConvInv => 'GetUnixTime($val)',
        PrintConv => '$self->ConvertDateTime($val)',
        PrintConvInv => '$self->InverseDateTime($val)',
    },
    0x45e => {
        Name => 'TimeStamp',
        Format => 'int32u',
        Groups => { 2 => 'Time' },
        # observed in 1DmkIII firmware 1.1.0, 1.1.3 and
        # 1DSmkIII firmware 1.0.0, 1.0.4, 2.1.2, 2.7.1
        Notes => 'valid for the 1DSmkIII and some versions of the 1DmkIII firmware',
        Shift => 'Time',
        RawConv => '$val ? $val : undef',
        ValueConv => 'ConvertUnixTime($val)',
        ValueConvInv => 'GetUnixTime($val)',
        PrintConv => '$self->ConvertDateTime($val)',
        PrintConvInv => '$self->InverseDateTime($val)',
    },
);

# Camera information for 5D (MakerNotes tag 0x0d)
# (ref 12 unless otherwise noted)
%Image::ExifTool::Canon::CameraInfo5D = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8s',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'CameraInfo tags for the EOS 5D.',
    0x03 => { %ciFNumber }, #PH
    0x04 => { %ciExposureTime }, #9
    0x06 => { %ciISO }, #PH
    0x0d => { #9
        Name => 'LensType',
        Format => 'int8u',
        SeparateTable => 1,
        RawConv => '$val ? $val : undef', # don't use if value is zero
        PrintConv => \%canonLensTypes,
    },
    0x27 => { #PH
        Name => 'CameraOrientation',
        PrintConv => {
            0 => 'Horizontal (normal)',
            1 => 'Rotate 90 CW',
            2 => 'Rotate 270 CW',
        },
    },
    0x28 => { %ciFocalLength }, #15
    0x38 => {
        Name => 'AFPointsInFocus5D',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val))',
        ValueConvInv => 'unpack("v",pack("n",$val))',
        PrintConv => { BITMASK => {
            0 => 'Center',
            1 => 'Top',
            2 => 'Bottom',
            3 => 'Upper-left',
            4 => 'Upper-right',
            5 => 'Lower-left',
            6 => 'Lower-right',
            7 => 'Left',
            8 => 'Right',
            9 => 'AI Servo1',
           10 => 'AI Servo2',
           11 => 'AI Servo3',
           12 => 'AI Servo4',
           13 => 'AI Servo5',
           14 => 'AI Servo6',
        } },
    },
    0x54 => { #15
        Name => 'WhiteBalance',
        Format => 'int16u',
        SeparateTable => 1,
        PrintConv => \%canonWhiteBalance,
    },
    0x58 => { #15
        Name => 'ColorTemperature',
        Format => 'int16u',
    },
    0x6c => {
        Name => 'PictureStyle',
        Format => 'int8u',
        Flags => ['PrintHex','SeparateTable'],
        PrintConv => \%pictureStyles,
    },
    0x93 => { %ciShortFocal }, #15
    0x95 => { %ciLongFocal }, #15
    0x98 => { #15
        Name => 'LensType',
        Format => 'int8u',
        SeparateTable => 1,
        PrintConv => \%canonLensTypes,
    },
    0xa4 => { #PH
        Name => 'FirmwareRevision',
        Format => 'string[8]',
    },
    0xac => { #PH
        Name => 'ShortOwnerName',
        Format => 'string[16]',
    },
    0xd0 => {
        Name => 'ImageNumber',
        Format => 'int16u',
        Groups => { 2 => 'Image' },
        ValueConv => '$val + 1',
        ValueConvInv => '$val - 1',
    },
    0xe8 => 'ContrastStandard',
    0xe9 => 'ContrastPortrait',
    0xea => 'ContrastLandscape',
    0xeb => 'ContrastNeutral',
    0xec => 'ContrastFaithful',
    0xed => 'ContrastMonochrome',
    0xee => 'ContrastUserDef1',
    0xef => 'ContrastUserDef2',
    0xf0 => 'ContrastUserDef3',
    # sharpness values are 0-7
    0xf1 => 'SharpnessStandard',
    0xf2 => 'SharpnessPortrait',
    0xf3 => 'SharpnessLandscape',
    0xf4 => 'SharpnessNeutral',
    0xf5 => 'SharpnessFaithful',
    0xf6 => 'SharpnessMonochrome',
    0xf7 => 'SharpnessUserDef1',
    0xf8 => 'SharpnessUserDef2',
    0xf9 => 'SharpnessUserDef3',
    0xfa => 'SaturationStandard',
    0xfb => 'SaturationPortrait',
    0xfc => 'SaturationLandscape',
    0xfd => 'SaturationNeutral',
    0xfe => 'SaturationFaithful',
    0xff => {
        Name => 'FilterEffectMonochrome',
        PrintConv => {
            0 => 'None',
            1 => 'Yellow',
            2 => 'Orange',
            3 => 'Red',
            4 => 'Green',
        },
    },
    0x100 => 'SaturationUserDef1',
    0x101 => 'SaturationUserDef2',
    0x102 => 'SaturationUserDef3',
    0x103 => 'ColorToneStandard',
    0x104 => 'ColorTonePortrait',
    0x105 => 'ColorToneLandscape',
    0x106 => 'ColorToneNeutral',
    0x107 => 'ColorToneFaithful',
    0x108 => {
        Name => 'ToningEffectMonochrome',
        PrintConv => {
            0 => 'None',
            1 => 'Sepia',
            2 => 'Blue',
            3 => 'Purple',
            4 => 'Green',
        },
    },
    0x109 => 'ColorToneUserDef1',
    0x10a => 'ColorToneUserDef2',
    0x10b => 'ColorToneUserDef3',
    0x10c => {
        Name => 'UserDef1PictureStyle',
        Format => 'int16u',
        PrintHex => 1,
        PrintConv => \%userDefStyles,
    },
    0x10e => {
        Name => 'UserDef2PictureStyle',
        Format => 'int16u',
        PrintHex => 1,
        PrintConv => \%userDefStyles,
    },
    0x110 => {
        Name => 'UserDef3PictureStyle',
        Format => 'int16u',
        PrintHex => 1,
        PrintConv => \%userDefStyles,
    },
    0x11c => {
        Name => 'TimeStamp',
        Format => 'int32u',
        Groups => { 2 => 'Time' },
        Shift => 'Time',
        RawConv => '$val ? $val : undef',
        ValueConv => 'ConvertUnixTime($val)',
        ValueConvInv => 'GetUnixTime($val)',
        PrintConv => '$self->ConvertDateTime($val)',
        PrintConvInv => '$self->InverseDateTime($val)',
    },
);

# Camera information for 5D Mark II (MakerNotes tag 0x0d)
# (ref PH unless otherwise noted)
%Image::ExifTool::Canon::CameraInfo5DmkII = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'CameraInfo tags for the EOS 5D Mark II.',
    0x03 => { %ciFNumber },
    0x04 => { %ciExposureTime },
    0x06 => { %ciISO },
    0x07 => {
        Name => 'HighlightTonePriority',
        PrintConv => { 0 => 'Off', 1 => 'On' },
    },
    0x19 => { %ciCameraTemperature }, #36
    0x1e => { %ciFocalLength },
    0x31 => {
        Name => 'CameraOrientation',
        PrintConv => {
            0 => 'Horizontal (normal)',
            1 => 'Rotate 90 CW',
            2 => 'Rotate 270 CW',
        },
    },
    0x50 => {
        Name => 'FocusDistanceUpper',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x52 => {
        Name => 'FocusDistanceLower',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x6f => {
        Name => 'WhiteBalance',
        Format => 'int16u',
        SeparateTable => 1,
        PrintConv => \%canonWhiteBalance,
    },
    0x73 => {
        Name => 'ColorTemperature',
        Format => 'int16u',
    },
    0xa7 => {
        Name => 'PictureStyle',
        Format => 'int8u',
        Flags => ['PrintHex','SeparateTable'],
        PrintConv => \%pictureStyles,
    },
    0xbd => {
        Name => 'HighISONoiseReduction',
        PrintConv => {
            0 => 'Standard',
            1 => 'Low',
            2 => 'Strong',
            3 => 'Off',
        },
    },
    0xbf => {
        Name => 'AutoLightingOptimizer',
        PrintConv => {
            0 => 'Standard',
            1 => 'Low',
            2 => 'Strong',
            3 => 'Off',
        },
    },
    0xe7 => {
        Name => 'LensType',
        Priority => 0, # (in case offset changes with firmware version)
        SeparateTable => 1,
        PrintConv => \%canonLensTypes,
    },
    0xe8 => { %ciShortFocal },
    0xea => { %ciLongFocal },
    0x15a => {
        Name => 'FirmwareVersion',
        Format => 'string[6]',
        Notes => 'at this location for firmware 3.4.6 and 3.6.1',
        Writable => 0, # not writable for logic reasons
        # some firmwares have a null instead of a space after the version number
        RawConv => '$val=~/^\d+\.\d+\.\d+\s*$/ ? $$self{CanonFirmA}=$val : undef',
    },
    0x17e => {
        Name => 'FirmwareVersion',
        Format => 'string[6]',
        Notes => 'at this location for firmware 1.0.6 and 4.1.1',
        Writable => 0, # not writable for logic reasons
        RawConv => '$val=~/^\d+\.\d+\.\d+\s*$/ ? $$self{CanonFirmB}=$val : undef',
    },
#    # here for firmware 1.0.6
#    0x2f7 => {
#        Name => 'Contrast',
#        Format => 'int32s',
#        Priority => 0,
#    }
    0x197 => {
        Name => 'FileIndex',
        Condition => '$$self{CanonFirmA}',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val + 1',
        ValueConvInv => '$val - 1',
    },
    0x1a3 => { #(NC)
        Name => 'DirectoryIndex',
        Condition => '$$self{CanonFirmA}',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val - 1',
        ValueConvInv => '$val + 1',
    },
    0x1bb => {
        Name => 'FileIndex',
        Condition => '$$self{CanonFirmB}',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val + 1',
        ValueConvInv => '$val - 1',
    },
    0x1c7 => { #(NC)
        Name => 'DirectoryIndex',
        Condition => '$$self{CanonFirmB}',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val - 1',
        ValueConvInv => '$val + 1',
    },
);

# Canon camera information for 40D (MakerNotes tag 0x0d)
%Image::ExifTool::Canon::CameraInfo40D = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'CameraInfo tags for the EOS 40D.',
    0x03 => { %ciFNumber }, #PH
    0x04 => { %ciExposureTime }, #PH
    0x06 => { %ciISO }, #PH
    0x18 => { %ciCameraTemperature }, #36
    0x1d => { %ciFocalLength }, #PH
    0x30 => { #20
        Name => 'CameraOrientation',
        PrintConv => {
            0 => 'Horizontal (normal)',
            1 => 'Rotate 90 CW',
            2 => 'Rotate 270 CW',
        },
    },
    0x43 => { #21/24
        Name => 'FocusDistanceUpper',
        Format => 'int16u',
        # this is very odd (little-endian number on odd boundary),
        # but it does seem to work better with my sample images - PH
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x45 => { #21/24
        Name => 'FocusDistanceLower',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x6f => { #15
        Name => 'WhiteBalance',
        Format => 'int16u',
        PrintConv => \%canonWhiteBalance,
        SeparateTable => 1,
    },
    0x73 => { #15
        Name => 'ColorTemperature',
        Format => 'int16u',
    },
    0xd7 => { #15
        Name => 'LensType',
        SeparateTable => 1,
        PrintConv => \%canonLensTypes,
    },
    0xd8 => { %ciShortFocal }, #15
    0xda => { %ciLongFocal }, #15
    0xff => { #15
        Name => 'FirmwareVersion',
        Format => 'string[6]',
    },
    0x133 => { #27
        Name => 'FileIndex',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        Notes => 'combined with DirectoryIndex to give the Composite FileNumber tag',
        ValueConv => '$val + 1',
        ValueConvInv => '$val - 1',
    },
    0x13f => { #27
        Name => 'DirectoryIndex',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val - 1', # yes, minus (opposite to FileIndex)
        ValueConvInv => '$val + 1',
    },
    0x92b => { #33
        Name => 'LensModel',
        Format => 'string[64]',
    },
);

# Canon camera information for 50D (MakerNotes tag 0x0d)
# (ref PH unless otherwise noted)
%Image::ExifTool::Canon::CameraInfo50D = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'CameraInfo tags for the EOS 50D.',
    0x03 => { %ciFNumber },
    0x04 => { %ciExposureTime },
    0x06 => { %ciISO },
    0x07 => {
        Name => 'HighlightTonePriority',
        PrintConv => { 0 => 'Off', 1 => 'On' },
    },
    0x19 => { %ciCameraTemperature }, #36
    0x1e => { %ciFocalLength },
    0x31 => {
        Name => 'CameraOrientation',
        PrintConv => {
            0 => 'Horizontal (normal)',
            1 => 'Rotate 90 CW',
            2 => 'Rotate 270 CW',
        },
    },
    0x50 => { #33
        Name => 'FocusDistanceUpper',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x52 => { #33
        Name => 'FocusDistanceLower',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x6f => {
        Name => 'WhiteBalance',
        Format => 'int16u',
        SeparateTable => 1,
        PrintConv => \%canonWhiteBalance,
    },
    0x73 => { #33
        Name => 'ColorTemperature',
        Format => 'int16u',
    },
    0xa7 => {
        Name => 'PictureStyle',
        Format => 'int8u',
        Flags => ['PrintHex','SeparateTable'],
        PrintConv => \%pictureStyles,
    },
    0xbd => {
        Name => 'HighISONoiseReduction',
        PrintConv => {
            0 => 'Standard',
            1 => 'Low',
            2 => 'Strong',
            3 => 'Off',
        },
    },
    0xbf => {
        Name => 'AutoLightingOptimizer',
        PrintConv => {
            0 => 'Standard',
            1 => 'Low',
            2 => 'Strong',
            3 => 'Off',
        },
    },
    0xeb => { #33
        Name => 'LensType',
        SeparateTable => 1,
        Priority => 0,
        PrintConv => \%canonLensTypes,
    },
    0xec => { %ciShortFocal },
    0xee => { %ciLongFocal },
    0x15a => {
        Name => 'FirmwareVersion',
        Format => 'string[6]',
        Notes => 'at this location for firmware 2.6.1',
        Writable => 0,
        RawConv => '$val=~/^\d+\.\d+\.\d+\s*$/ ? $$self{CanonFirmA}=$val : undef',
    },
    0x15e => { #33
        Name => 'FirmwareVersion',
        Format => 'string[6]',
        Notes => 'at this location for firmware 1.0.2, 1.0.3, 2.9.1 and 3.1.1',
        Writable => 0,
        RawConv => '$val=~/^\d+\.\d+\.\d+\s*$/ ? $$self{CanonFirmB}=$val : undef',
    },
    0x197 => {
        Name => 'FileIndex',
        Condition => '$$self{CanonFirmA}',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val + 1',
        ValueConvInv => '$val - 1',
    },
    0x19b => {
        Name => 'FileIndex',
        Condition => '$$self{CanonFirmB}',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val + 1',
        ValueConvInv => '$val - 1',
    },
    0x1a3 => { # (NC)
        Name => 'DirectoryIndex',
        Condition => '$$self{CanonFirmA}',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val - 1',
        ValueConvInv => '$val + 1',
    },
    0x1a7 => { # (NC)
        Name => 'DirectoryIndex',
        Condition => '$$self{CanonFirmB}',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val - 1',
        ValueConvInv => '$val + 1',
    },
    # This is definitely sharpness for firmware 1.0.3, but it doesn't always agree
    # with the other Sharpness tag for firmware 2.6.1 and 2.9.1
    # 0x036b => {
    #     Name => 'Sharpness',
    #     Format => 'int16u',
    # },
);

# Canon camera information for 450D (MakerNotes tag 0x0d)
%Image::ExifTool::Canon::CameraInfo450D = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'CameraInfo tags for the EOS 450D.',
    0x03 => { %ciFNumber }, #PH
    0x04 => { %ciExposureTime }, #PH
    0x06 => { %ciISO }, #PH
    0x1d => { %ciFocalLength }, #PH
    0x18 => { %ciCameraTemperature }, #36
    0x30 => { #20
        Name => 'CameraOrientation',
        PrintConv => {
            0 => 'Horizontal (normal)',
            1 => 'Rotate 90 CW',
            2 => 'Rotate 270 CW',
        },
    },
    0x43 => { #20
        Name => 'FocusDistanceUpper',
        Format => 'int16u',
        # this is very odd (little-endian number on odd boundary),
        # but it does seem to work better with my sample images - PH
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x45 => { #20
        Name => 'FocusDistanceLower',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x6f => { #PH
        Name => 'WhiteBalance',
        Format => 'int16u',
        PrintConv => \%canonWhiteBalance,
        SeparateTable => 1,
    },
    0x73 => { #PH
        Name => 'ColorTemperature',
        Format => 'int16u',
    },
    0xdf => { #33
        Name => 'LensType',
        SeparateTable => 1,
        Priority => 0,
        PrintConv => \%canonLensTypes,
    },
    0x107 => { #PH
        Name => 'FirmwareVersion',
        Format => 'string[6]',
    },
    0x133 => { #20
        Name => 'DirectoryIndex',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
    },
    0x13f => { #20
        Name => 'FileIndex',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val + 1',
        ValueConvInv => '$val - 1',
    },
    0x933 => { #33
        Name => 'LensModel',
        Format => 'string[64]',
    },
);

# Canon camera information for 500D (MakerNotes tag 0x0d)
%Image::ExifTool::Canon::CameraInfo500D = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'CameraInfo tags for the EOS 50D.',
    0x03 => { %ciFNumber },
    0x04 => { %ciExposureTime },
    0x06 => { %ciISO },
    0x07 => {
        Name => 'HighlightTonePriority',
        PrintConv => { 0 => 'Off', 1 => 'On' },
    },
    0x19 => { %ciCameraTemperature },
    0x1e => { %ciFocalLength },
    0x31 => {
        Name => 'CameraOrientation',
        PrintConv => {
            0 => 'Horizontal (normal)',
            1 => 'Rotate 90 CW',
            2 => 'Rotate 270 CW',
        },
    },
    0x50 => {
        Name => 'FocusDistanceUpper',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x52 => {
        Name => 'FocusDistanceLower',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x73 => { # (50D + 4)
        Name => 'WhiteBalance',
        Format => 'int16u',
        SeparateTable => 1,
        PrintConv => \%canonWhiteBalance,
    },
    0x77 => { # (50D + 4)
        Name => 'ColorTemperature',
        Format => 'int16u',
    },
    0xab => { # (50D + 4)
        Name => 'PictureStyle',
        Format => 'int8u',
        Flags => ['PrintHex','SeparateTable'],
        PrintConv => \%pictureStyles,
    },
    0xbb => {
        Name => 'HighISONoiseReduction',
        PrintConv => {
            0 => 'Standard',
            1 => 'Low',
            2 => 'Strong',
            3 => 'Off',
        },
    },
    0xbe => {
        Name => 'AutoLightingOptimizer',
        PrintConv => {
            0 => 'Standard',
            1 => 'Low',
            2 => 'Strong',
            3 => 'Off',
        },
    },
    0xf7 => {
        Name => 'LensType',
        SeparateTable => 1,
        Priority => 0,
        PrintConv => \%canonLensTypes,
    },
    0xf8 => { %ciShortFocal },
    0xfa => { %ciLongFocal },
    0x190 => {
        Name => 'FirmwareVersion',
        Format => 'string[6]',
        Writable => 0,
        RawConv => '$val=~/^\d+\.\d+\.\d+\s*$/ ? $val : undef',
    },
    0x1d3 => {
        Name => 'FileIndex',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val + 1',
        ValueConvInv => '$val - 1',
    },
    0x1df => { # (NC)
        Name => 'DirectoryIndex',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val - 1',
        ValueConvInv => '$val + 1',
    },
);

# Canon camera information for 1000D (MakerNotes tag 0x0d)
%Image::ExifTool::Canon::CameraInfo1000D = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'CameraInfo tags for the EOS 1000D.',
    0x03 => { %ciFNumber }, #PH
    0x04 => { %ciExposureTime }, #PH
    0x06 => { %ciISO }, #PH
    0x18 => { %ciCameraTemperature }, #36
    0x1d => { %ciFocalLength }, #PH
    0x30 => { #20
        Name => 'CameraOrientation',
        PrintConv => {
            0 => 'Horizontal (normal)',
            1 => 'Rotate 90 CW',
            2 => 'Rotate 270 CW',
        },
    },
    0x43 => { #20
        Name => 'FocusDistanceUpper',
        Format => 'int16u',
        # this is very odd (little-endian number on odd boundary),
        # but it does seem to work better with my sample images - PH
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x45 => { #20
        Name => 'FocusDistanceLower',
        Format => 'int16u',
        ValueConv => 'unpack("n",pack("v",$val)) * 0.01',
        ValueConvInv => 'unpack("v",pack("n",$val / 0.01))',
    },
    0x6f => { #PH
        Name => 'WhiteBalance',
        Format => 'int16u',
        PrintConv => \%canonWhiteBalance,
        SeparateTable => 1,
    },
    0x73 => { #PH
        Name => 'ColorTemperature',
        Format => 'int16u',
    },
    0xe3 => { #PH
        Name => 'LensType',
        SeparateTable => 1,
        Priority => 0,
        PrintConv => \%canonLensTypes,
    },
    0x10b => { #PH
        Name => 'FirmwareVersion',
        Format => 'string[6]',
    },
    0x137 => { #PH (NC)
        Name => 'DirectoryIndex',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
    },
    0x143 => { #PH
        Name => 'FileIndex',
        Groups => { 2 => 'Image' },
        Format => 'int32u',
        ValueConv => '$val + 1',
        ValueConvInv => '$val - 1',
    },
    0x937 => { #PH
        Name => 'LensModel',
        Format => 'string[64]',
    },
);

# Canon camera information for PowerShot models (MakerNotes tag 0x0d) - PH
%Image::ExifTool::Canon::CameraInfoPowerShot = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int32s',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'CameraInfo tags for PowerShot models.',
    0x00 => {
        Name => 'ISO',
        Groups => { 2 => 'Image' },
        Priority => 0,
        ValueConv => '100*exp(($val/100-4)*log(2))',
        ValueConvInv => '(log($val/100)/log(2)+4)*100',
        PrintConv => 'sprintf("%.0f",$val)',
        PrintConvInv => '$val',
    },
    0x05 => {
        Name => 'FNumber',
        Groups => { 2 => 'Image' },
        Priority => 0,
        ValueConv => 'exp(($val+16)/200*log(2))',
        ValueConvInv => 'log($val)*200/log(2)-16',
        PrintConv => 'sprintf("%.2g",$val)',
        PrintConvInv => '$val',
    },
    0x06 => {
        Name => 'ExposureTime',
        Groups => { 2 => 'Image' },
        Priority => 0,
        RawConv => '$val ? $val : undef',
        ValueConv => 'exp(-($val+24)/100*log(2))',
        ValueConvInv => '-log($val)*100/log(2)-24',
        PrintConv => 'Image::ExifTool::Exif::PrintExposureTime($val)',
        PrintConvInv => 'eval $val',
    },
    0x17 => 'Rotation', # usually the same as Orientation (but not always! why?)
);

# unknown Canon camera information (MakerNotes tag 0x0d) - PH
%Image::ExifTool::Canon::CameraInfoUnknown32 = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int32s',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => 'Unknown CameraInfo tags are divided into 3 tables based on format size.',
);

# unknown Canon camera information (MakerNotes tag 0x0d) - PH
%Image::ExifTool::Canon::CameraInfoUnknown16 = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16s',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
);

# unknown Canon camera information (MakerNotes tag 0x0d) - PH
%Image::ExifTool::Canon::CameraInfoUnknown = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8s',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
);

# Canon panorama information (MakerNotes tag 0x05)
%Image::ExifTool::Canon::Panorama = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16s',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Image' },
    # 0 - values: always 1
    # 1 - values: 0,256,512(3 sequential L->R images); 0,-256(2 R->L images)
    2 => 'PanoramaFrameNumber', #(some models this is always 0)
    # 3 - values: 160(SX10IS,A570IS); 871(S30)
    # 4 - values: always 0
    5 => {
        Name => 'PanoramaDirection',
        PrintConv => {
            0 => 'Left to Right',
            1 => 'Right to Left',
            2 => 'Bottom to Top',
            3 => 'Top to Bottom',
            4 => '2x2 Matrix (Clockwise)',
        },
     },
);

# AF information (MakerNotes tag 0x12) - PH
%Image::ExifTool::Canon::AFInfo = (
    PROCESS_PROC => \&ProcessSerialData,
    VARS => { ID_LABEL => 'Sequence' },
    FORMAT => 'int16u',
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => q{
        Auto-focus information used by many older Canon models.  The values in this
        record are sequential, and some have variable sizes based on the value of
        NumAFPoints (which may be 1,5,7,9,15,45 or 53).  The AFArea coordinates are
        given in a system where the image has dimensions given by AFImageWidth and
        AFImageHeight, and 0,0 is the image center. The direction of the Y axis
        depends on the camera model, with positive Y upwards for EOS models, but
        apparently downwards for PowerShot models.
    },
    0 => {
        Name => 'NumAFPoints',
    },
    1 => {
        Name => 'ValidAFPoints',
        Notes => 'number of AF points valid in the following information',
    },
    2 => {
        Name => 'CanonImageWidth',
        Groups => { 2 => 'Image' },
    },
    3 => {
        Name => 'CanonImageHeight',
        Groups => { 2 => 'Image' },
    },
    4 => {
        Name => 'AFImageWidth',
        Notes => 'size of image in AF coordinates',
    },
    5 => 'AFImageHeight',
    6 => 'AFAreaWidth',
    7 => 'AFAreaHeight',
    8 => {
        Name => 'AFAreaXPositions',
        Format => 'int16s[$val{0}]',
    },
    9 => {
        Name => 'AFAreaYPositions',
        Format => 'int16s[$val{0}]',
    },
    10 => {
        Name => 'AFPointsInFocus',
        Format => 'int16s[int(($val{0}+15)/16)]',
        PrintConv => 'Image::ExifTool::DecodeBits($val, undef, 16)',
    },
    11 => [
        {
            Name => 'PrimaryAFPoint',
            Condition => q{
                $$self{Model} !~ /EOS/ and
                (not $$self{AFInfoCount} or $$self{AFInfoCount} != 36)
            },
        },
        {
            # (some PowerShot 9-point systems put PrimaryAFPoint after 8 unknown values)
            Name => 'Canon_AFInfo_0x000b',
            Condition => '$$self{Model} !~ /EOS/',
            Format => 'int16u[8]',
            Unknown => 1,
        },
        # (serial processing stops here for EOS cameras)
    ],
    12 => 'PrimaryAFPoint',
);

# newer AF information (MakerNotes tag 0x26) - PH (A570IS,1DmkIII,40D)
# (Note: this tag is out of sequence in A570IS maker notes)
%Image::ExifTool::Canon::AFInfo2 = (
    PROCESS_PROC => \&ProcessSerialData,
    VARS => { ID_LABEL => 'Sequence' },
    FORMAT => 'int16u',
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    NOTES => q{
        Newer version of the AFInfo record containing much of the same information
        (and coordinate confusion) as the older version.  In this record, values of
        9 and 45 have been observed for NumAFPoints.
    },
    0 => {
        Name => 'AFInfoSize',
        Unknown => 1, # normally don't print this out
    },
    1 => {
        Name => 'AFMode',
        PrintConv => {
            0 => 'Off (Manual Focus)',
            2 => 'Single-point AF',
            4 => 'Multi-point AF', # AiAF on A570IS
            5 => 'Face Detect AF',
        },
    },
    2 => {
        Name => 'NumAFPoints',
        RawConv => '$$self{NumAFPoints} = $val', # save for later
    },
    3 => {
        Name => 'ValidAFPoints',
        Notes => 'number of AF points valid in the following information',
    },
    4 => {
        Name => 'CanonImageWidth',
        Groups => { 2 => 'Image' },
    },
    5 => {
        Name => 'CanonImageHeight',
        Groups => { 2 => 'Image' },
    },
    6 => {
        Name => 'AFImageWidth',
        Notes => 'size of image in AF coordinates',
    },
    7 => 'AFImageHeight',
    8 => {
        Name => 'AFAreaWidths',
        Format => 'int16s[$val{2}]',
    },
    9 => {
        Name => 'AFAreaHeights',
        Format => 'int16s[$val{2}]',
    },
    10 => {
        Name => 'AFAreaXPositions',
        Format => 'int16s[$val{2}]',
    },
    11 => {
        Name => 'AFAreaYPositions',
        Format => 'int16s[$val{2}]',
    },
    12 => {
        Name => 'AFPointsInFocus',
        Format => 'int16s[int(($val{2}+15)/16)]',
        PrintConv => 'Image::ExifTool::DecodeBits($val, undef, 16)',
    },
    13 => [
        {
            Name => 'AFPointsSelected',
            Condition => '$$self{Model} =~ /EOS/',
            Format => 'int16s[int(($val{2}+15)/16)]',
            PrintConv => 'Image::ExifTool::DecodeBits($val, undef, 16)',
        },
        {
            Name => 'Canon_AFInfo2_0x000d',
            Format => 'int16s[int(($val{2}+15)/16)+1]',
            Unknown => 1,
        },
    ],
    14 => {
        # usually, but not always, the lowest number AF point in focus
        Name => 'PrimaryAFPoint',
        Condition => '$$self{Model} !~ /EOS/',
    },
);

# my color mode information (MakerNotes tag 0x1d) - PH (A570IS)
%Image::ExifTool::Canon::MyColors = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Image' },
    0x02 => {
        Name => 'MyColorMode',
        PrintConv => {
            0 => 'Off',
            1 => 'Positive Film', #15 (SD600)
            2 => 'Light Skin Tone', #15
            3 => 'Dark Skin Tone', #15
            4 => 'Vivid Blue', #15
            5 => 'Vivid Green', #15
            6 => 'Vivid Red', #15
            7 => 'Color Accent', #15 (A610) (NC)
            8 => 'Color Swap', #15 (A610)
            9 => 'Custom',
            12 => 'Vivid',
            13 => 'Neutral',
            14 => 'Sepia',
            15 => 'B&W',
        },
    },
);

# face detect information (MakerNotes tag 0x24) - PH (A570IS)
%Image::ExifTool::Canon::FaceDetect1 = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16u',
    FIRST_ENTRY => 0,
    DATAMEMBER => [ 0x02 ],
    GROUPS => { 0 => 'MakerNotes', 2 => 'Image' },
    0x02 => {
        Name => 'FacesDetected',
        DataMember => 'FacesDetected',
        RawConv => '$$self{FacesDetected} = $val',
    },
    0x03 => 'FaceDetectFrameWidth',
    0x04 => 'FaceDetectFrameHeight',
    0x08 => {
        Name => 'Face0Position',
        Format => 'int16s[2]',
        RawConv => '$$self{FacesDetected} < 1 ? undef: $val',
        Notes => q{
            X-Y coordinates for the center of each face in the Face Detect frame at the
            time of focus lock. "0 0" is the center, and positive X and Y are to the
            right and downwards respectively
        },
    },
    0x0a => {
        Name => 'Face1Position',
        Format => 'int16s[2]',
        RawConv => '$$self{FacesDetected} < 2 ? undef : $val',
    },
    0x0c => {
        Name => 'Face2Position',
        Format => 'int16s[2]',
        RawConv => '$$self{FacesDetected} < 3 ? undef : $val',
    },
    0x0e => {
        Name => 'Face3Position',
        Format => 'int16s[2]',
        RawConv => '$$self{FacesDetected} < 4 ? undef : $val',
    },
    0x10 => {
        Name => 'Face4Position',
        Format => 'int16s[2]',
        RawConv => '$$self{FacesDetected} < 5 ? undef : $val',
    },
    0x12 => {
        Name => 'Face5Position',
        Format => 'int16s[2]',
        RawConv => '$$self{FacesDetected} < 6 ? undef : $val',
    },
    0x14 => {
        Name => 'Face6Position',
        Format => 'int16s[2]',
        RawConv => '$$self{FacesDetected} < 7 ? undef : $val',
    },
    0x16 => {
        Name => 'Face7Position',
        Format => 'int16s[2]',
        RawConv => '$$self{FacesDetected} < 8 ? undef : $val',
    },
    0x18 => {
        Name => 'Face8Position',
        Format => 'int16s[2]',
        RawConv => '$$self{FacesDetected} < 9 ? undef : $val',
    },
);

# more face detect information (MakerNotes tag 0x25) - PH (A570IS)
%Image::ExifTool::Canon::FaceDetect2 = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int8u',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Image' },
    0x02 => 'FacesDetected',
);

# Preview image information (MakerNotes tag 0xb6)
# - The 300D writes a 1536x1024 preview image that is accessed
#   through this information - decoded by PH 12/14/03
%Image::ExifTool::Canon::PreviewImageInfo = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int32u',
    FIRST_ENTRY => 1,
    IS_OFFSET => [ 5 ],   # tag 5 is 'IsOffset'
    GROUPS => { 0 => 'MakerNotes', 2 => 'Image' },
# the size of the preview block in 2-byte increments
#    0 => {
#        Name => 'PreviewImageInfoWords',
#    },
    1 => {
        Name => 'PreviewQuality',
        PrintConv => \%canonQuality,
    },
    2 => {
        Name => 'PreviewImageLength',
        OffsetPair => 5,   # point to associated offset
        DataTag => 'PreviewImage',
        Protected => 2,
    },
    3 => 'PreviewImageWidth',
    4 => 'PreviewImageHeight',
    5 => {
        Name => 'PreviewImageStart',
        Flags => 'IsOffset',
        OffsetPair => 2,  # associated byte count tagID
        DataTag => 'PreviewImage',
        Protected => 2,
    },
    # NOTE: The size of the PreviewImageInfo structure is incorrectly
    # written as 48 bytes (Count=12, Format=int32u), but only the first
    # 6 int32u values actually exist
);

# Sensor information (MakerNotes tag 0xe0) (ref 12)
%Image::ExifTool::Canon::SensorInfo = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    FORMAT => 'int16s',
    FIRST_ENTRY => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Image' },
    # Note: Don't make these writable because it confuses Canon decoding software
    # if these are changed
    1 => 'SensorWidth',
    2 => 'SensorHeight',
    5 => 'SensorLeftBorder', #2
    6 => 'SensorTopBorder', #2
    7 => 'SensorRightBorder', #2
    8 => 'SensorBottomBorder', #2
    9 => { #22
        Name => 'BlackMaskLeftBorder',
        Notes => q{
            coordinates for the area to the left or right of the image used to calculate
            the average black level
        },
    },
    10 => 'BlackMaskTopBorder', #22
    11 => 'BlackMaskRightBorder', #22
    12 => 'BlackMaskBottomBorder', #22
);

# File number information (MakerNotes tag 0x93)
%Image::ExifTool::Canon::FileInfo = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16s',
    FIRST_ENTRY => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Image' },
    1 => [
        { #5
            Name => 'FileNumber',
            Condition => '$$self{Model} =~ /\b(20D|350D|REBEL XT|Kiss Digital N)\b/',
            Format => 'int32u',
            # Thanks to Juha Eskelinen for figuring this out:
            # [this is an odd bit mapping -- it looks like the file number exists as
            # a 16-bit integer containing the high bits, followed by an 8-bit integer
            # with the low bits.  But it is more convenient to have this in a single
            # word, so some bit manipulations are necessary... - PH]
            # The bit pattern of the 32-bit word is:
            #   31....24 23....16 15.....8 7......0
            #   00000000 ffffffff DDDDDDDD ddFFFFFF
            #     0 = zero bits (not part of the file number?)
            #     f/F = low/high bits of file number
            #     d/D = low/high bits of directory number
            # The directory and file number are then converted into decimal
            # and separated by a '-' to give the file number used in the 20D
            ValueConv => '(($val&0xffc0)>>6)*10000+(($val>>16)&0xff)+(($val&0x3f)<<8)',
            ValueConvInv => q{
                my $d = int($val/10000);
                my $f = $val - $d * 10000;
                return (($d<<6) & 0xffc0) + (($f & 0xff)<<16) + (($f>>8) & 0x3f);
            },
            PrintConv => '$_=$val,s/(\d+)(\d{4})/$1-$2/,$_',
            PrintConvInv => '$val=~s/-//g;$val',
        },
        { #16
            Name => 'FileNumber',
            Condition => '$$self{Model} =~ /\b(30D|400D|REBEL XTi|Kiss Digital X|K236)\b/',
            Format => 'int32u',
            Notes => q{
                the location of the upper 4 bits of the directory number is a mystery for
                the EOS 30D, so the reported directory number will be incorrect for original
                images with a directory number of 164 or greater
            },
            # Thanks to Emil Sit for figuring this out:
            # [more insane bit maniplations like the 20D/350D above, but this time we
            # appear to have lost the upper 4 bits of the directory number (this was
            # verified through tests with directory numbers 100, 222, 801 and 999) - PH]
            # The bit pattern for the 30D is: (see 20D notes above for more information)
            #   31....24 23....16 15.....8 7......0
            #   00000000 ffff0000 ddddddFF FFFFFFFF
            # [NOTE: the 4 high order directory bits don't appear in this record, but
            # I have chosen to write them into bits 16-19 since these 4 zero bits look
            # very suspicious, and are a convenient place to store this information - PH]
            ValueConv  => q{
                my $d = ($val & 0xffc00) >> 10;
                # we know there are missing bits if directory number is < 100
                $d += 0x40 while $d < 100;  # (repair the damage as best we can)
                return $d*10000 + (($val&0x3ff)<<4) + (($val>>20)&0x0f);
            },
            ValueConvInv => q{
                my $d = int($val/10000);
                my $f = $val - $d * 10000;
                return ($d << 10) + (($f>>4)&0x3ff) + (($f&0x0f)<<20);
            },
            PrintConv => '$_=$val,s/(\d+)(\d{4})/$1-$2/,$_',
            PrintConvInv => '$val=~s/-//g;$val',
        },
        { #7 (1D, 1Ds)
            Name => 'ShutterCount',
            Condition => 'GetByteOrder() eq "MM"',
            Format => 'int32u',
        },
        { #7 (1DmkII, 1DSmkII, 1DSmkIIN)
            Name => 'ShutterCount',
            Condition => '$$self{Model} =~ /\b1Ds? Mark II\b/',
            Format => 'int32u',
            ValueConv => '($val>>16)|(($val&0xffff)<<16)',
            ValueConvInv => '($val>>16)|(($val&0xffff)<<16)',
        },
        # 5D gives a single byte value (unknown)
        # 40D stores all zeros
    ],
    3 => { #PH
        Name => 'BracketMode',
        PrintConv => {
            0 => 'Off',
            1 => 'AEB',
            2 => 'FEB',
            3 => 'ISO',
            4 => 'WB',
        },
    },
    4 => 'BracketValue', #PH
    5 => 'BracketShotNumber', #PH
    6 => { #PH
        Name => 'RawJpgQuality',
        RawConv => '$val<=0 ? undef : $val',
        PrintConv => \%canonQuality,
    },
    7 => { #PH
        Name => 'RawJpgSize',
        RawConv => '$val<0 ? undef : $val',
        PrintConv => \%canonImageSize,
    },
    8 => { #PH
        Name => 'NoiseReduction',
        Notes => 'valid for the 1D, 1DS, 1DmkII, 1DmkIIN, 1DSmkII, 5D, 20D, 30D, 350D and 400D',
        Condition => '$Image::ExifTool::Canon::FileInfo{8}{ValidID}{$$self{CanonModelID} || 0}',
        ValidID => {
            0x80000001 => 1, # 1D
            0x80000167 => 1, # 1DS
            0x80000174 => 1, # 1DmkII
            0x80000232 => 1, # 1DmkIIN
            0x80000188 => 1, # 1DSmkII
            0x80000213 => 1, # 5D
            0x80000175 => 1, # 20D
            0x80000234 => 1, # 30D
            0x80000189 => 1, # 350D
            0x80000236 => 1, # 400D
        },
        RawConv => '$val<0 ? undef : $val',
        PrintConv => {
            0 => 'Off',
            1 => 'On 1',
            2 => 'On 2',
            3 => 'On',
            4 => 'Auto',
        },
    },
    9 => { #PH
        Name => 'WBBracketMode',
        PrintConv => {
            0 => 'Off',
            1 => 'On (shift AB)',
            2 => 'On (shift GM)',
        },
    },
    12 => 'WBBracketValueAB', #PH
    13 => 'WBBracketValueGM', #PH
    14 => { #PH
        Name => 'FilterEffect',
        RawConv => '$val==-1 ? undef : $val',
        PrintConv => {
            0 => 'None',
            1 => 'Yellow',
            2 => 'Orange',
            3 => 'Red',
            4 => 'Green',
        },
    },
    15 => { #PH
        Name => 'ToningEffect',
        RawConv => '$val==-1 ? undef : $val',
        PrintConv => {
            0 => 'None',
            1 => 'Sepia',
            2 => 'Blue',
            3 => 'Purple',
            4 => 'Green',
        },
    },
    # 18 - same as LiveViewShooting for all my samples (5DmkII, 50D) - PH
    19 => { #PH
        Name => 'LiveViewShooting',
        PrintConv => { 0 => 'Off', 1 => 'On' },
    },
    25 => { #PH
        Name => 'FlashExposureLock',
        PrintConv => { 0 => 'Off', 1 => 'On' },
    },
);

# Internal serial number information (MakerNotes tag 0x96) (ref PH)
%Image::ExifTool::Canon::SerialInfo = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    9 => {
        Name => 'InternalSerialNumber',
        Format => 'string',
    },
);

# color information (MakerNotes tag 0xa0)
%Image::ExifTool::Canon::Processing = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16s',
    FIRST_ENTRY => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Image' },
    1 => { #PH
        Name => 'ToneCurve',
        PrintConv => {
            0 => 'Standard',
            1 => 'Manual',
            2 => 'Custom',
        },
    },
    2 => { #12
        Name => 'Sharpness',
        Notes => 'all models except the 20D and 350D',
        Condition => '$$self{Model} !~ /\b(20D|350D|REBEL XT|Kiss Digital N)\b/',
        Priority => 0,  # (maybe not as reliable as other sharpness values)
    },
    3 => { #PH
        Name => 'SharpnessFrequency',
        PrintConv => {
            0 => 'n/a',
            1 => 'Lowest',
            2 => 'Low',
            3 => 'Standard',
            4 => 'High',
            5 => 'Highest',
        },
    },
    4 => 'SensorRedLevel', #PH
    5 => 'SensorBlueLevel', #PH
    6 => 'WhiteBalanceRed', #PH
    7 => 'WhiteBalanceBlue', #PH
    8 => { #PH
        Name => 'WhiteBalance',
        RawConv => '$val < 0 ? undef : $val',
        PrintConv => \%canonWhiteBalance,
        SeparateTable => 1,
    },
    9 => 'ColorTemperature', #6
    10 => { #12
        Name => 'PictureStyle',
        Flags => ['PrintHex','SeparateTable'],
        PrintConv => \%pictureStyles,
    },
    11 => { #PH
        Name => 'DigitalGain',
        ValueConv => '$val / 10',
        ValueConvInv => '$val * 10',
    },
    12 => { #PH
        Name => 'WBShiftAB',
        Notes => 'positive is a shift toward amber',
    },
    13 => { #PH
        Name => 'WBShiftGM',
        Notes => 'positive is a shift toward green',
    },
);

# D30 color information (MakerNotes tag 0x0a)
%Image::ExifTool::Canon::UnknownD30 = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16s',
    FIRST_ENTRY => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
);

# Measured color levels (ref 37)
%Image::ExifTool::Canon::MeasuredColor = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    FORMAT => 'int16u',
    FIRST_ENTRY => 1,
    WRITABLE => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    1 => {
        # this is basically the inverse of WB_RGGBLevelsMeasured (ref 37)
        Name => 'MeasuredRGGB',
        Format => 'int16u[4]',
    },
);

# Color balance information (MakerNotes tag 0xa9) (ref PH)
%Image::ExifTool::Canon::ColorBalance = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    NOTES => 'These tags are used by the 10D and 300D.',
    FORMAT => 'int16s',
    FIRST_ENTRY => 0,
    WRITABLE => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    # red,green1,green2,blue (ref 2)
    0  => { Name => 'WB_RGGBLevelsAuto',       Format => 'int16s[4]' },
    4  => { Name => 'WB_RGGBLevelsDaylight',   Format => 'int16s[4]' },
    8  => { Name => 'WB_RGGBLevelsShade',      Format => 'int16s[4]' },
    12 => { Name => 'WB_RGGBLevelsCloudy',     Format => 'int16s[4]' },
    16 => { Name => 'WB_RGGBLevelsTungsten',   Format => 'int16s[4]' },
    20 => { Name => 'WB_RGGBLevelsFluorescent',Format => 'int16s[4]' },
    24 => { Name => 'WB_RGGBLevelsFlash',      Format => 'int16s[4]' },
    28 => { Name => 'WB_RGGBLevelsCustom',     Format => 'int16s[4]' },
    32 => { Name => 'WB_RGGBLevelsKelvin',     Format => 'int16s[4]' },
);

# Color data (MakerNotes tag 0x4001, count=582) (ref 12)
%Image::ExifTool::Canon::ColorData1 = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    NOTES => 'These tags are used by the 20D and 350D.',
    FORMAT => 'int16s',
    FIRST_ENTRY => 0,
    WRITABLE => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    # 0x00: size of record in bytes - PH
    # (dcraw 8.81 uses index 0x19 for WB)
    0x19 => { Name => 'WB_RGGBLevelsAsShot',      Format => 'int16s[4]' },
    0x1d => 'ColorTempAsShot',
    0x1e => { Name => 'WB_RGGBLevelsAuto',        Format => 'int16s[4]' },
    0x22 => 'ColorTempAuto',
    0x23 => { Name => 'WB_RGGBLevelsDaylight',    Format => 'int16s[4]' },
    0x27 => 'ColorTempDaylight',
    0x28 => { Name => 'WB_RGGBLevelsShade',       Format => 'int16s[4]' },
    0x2c => 'ColorTempShade',
    0x2d => { Name => 'WB_RGGBLevelsCloudy',      Format => 'int16s[4]' },
    0x31 => 'ColorTempCloudy',
    0x32 => { Name => 'WB_RGGBLevelsTungsten',    Format => 'int16s[4]' },
    0x36 => 'ColorTempTungsten',
    0x37 => { Name => 'WB_RGGBLevelsFluorescent', Format => 'int16s[4]' },
    0x3b => 'ColorTempFluorescent',
    0x3c => { Name => 'WB_RGGBLevelsFlash',       Format => 'int16s[4]' },
    0x40 => 'ColorTempFlash',
    0x41 => { Name => 'WB_RGGBLevelsCustom1',     Format => 'int16s[4]' },
    0x45 => 'ColorTempCustom1',
    0x46 => { Name => 'WB_RGGBLevelsCustom2',     Format => 'int16s[4]' },
    0x4a => 'ColorTempCustom2',
    0x4b => { Name => 'CameraColorCalibration01', %cameraColorCalibration,
              Notes => 'A, B, C, Temperature' }, #PH
    0x4f => { Name => 'CameraColorCalibration02', %cameraColorCalibration }, #PH
    0x53 => { Name => 'CameraColorCalibration03', %cameraColorCalibration }, #PH
    0x57 => { Name => 'CameraColorCalibration04', %cameraColorCalibration }, #PH
    0x5b => { Name => 'CameraColorCalibration05', %cameraColorCalibration }, #PH
    0x5f => { Name => 'CameraColorCalibration06', %cameraColorCalibration }, #PH
    0x63 => { Name => 'CameraColorCalibration07', %cameraColorCalibration }, #PH
    0x67 => { Name => 'CameraColorCalibration08', %cameraColorCalibration }, #PH
    0x6b => { Name => 'CameraColorCalibration09', %cameraColorCalibration }, #PH
    0x6f => { Name => 'CameraColorCalibration10', %cameraColorCalibration }, #PH
    0x73 => { Name => 'CameraColorCalibration11', %cameraColorCalibration }, #PH
    0x77 => { Name => 'CameraColorCalibration12', %cameraColorCalibration }, #PH
    0x7b => { Name => 'CameraColorCalibration13', %cameraColorCalibration }, #PH
    0x7f => { Name => 'CameraColorCalibration14', %cameraColorCalibration }, #PH
    0x83 => { Name => 'CameraColorCalibration15', %cameraColorCalibration }, #PH
);

# Color data (MakerNotes tag 0x4001, count=653) (ref 12)
%Image::ExifTool::Canon::ColorData2 = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    NOTES => 'These tags are used by the 1DmkII and 1DSmkII.',
    FORMAT => 'int16s',
    FIRST_ENTRY => 0,
    WRITABLE => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    0x18 => { Name => 'WB_RGGBLevelsAuto',        Format => 'int16s[4]' },
    0x1c => 'ColorTempAuto',
    0x1d => { Name => 'WB_RGGBLevelsUnknown',     Format => 'int16s[4]', Unknown => 1 },
    0x21 => { Name => 'ColorTempUnknown', Unknown => 1 },
    # (dcraw 8.81 uses index 0x22 for WB)
    0x22 => { Name => 'WB_RGGBLevelsAsShot',      Format => 'int16s[4]' },
    0x26 => 'ColorTempAsShot',
    0x27 => { Name => 'WB_RGGBLevelsDaylight',    Format => 'int16s[4]' },
    0x2b => 'ColorTempDaylight',
    0x2c => { Name => 'WB_RGGBLevelsShade',       Format => 'int16s[4]' },
    0x30 => 'ColorTempShade',
    0x31 => { Name => 'WB_RGGBLevelsCloudy',      Format => 'int16s[4]' },
    0x35 => 'ColorTempCloudy',
    0x36 => { Name => 'WB_RGGBLevelsTungsten',    Format => 'int16s[4]' },
    0x3a => 'ColorTempTungsten',
    0x3b => { Name => 'WB_RGGBLevelsFluorescent', Format => 'int16s[4]' },
    0x3f => 'ColorTempFluorescent',
    0x40 => { Name => 'WB_RGGBLevelsKelvin',      Format => 'int16s[4]' },
    0x44 => 'ColorTempKelvin',
    0x45 => { Name => 'WB_RGGBLevelsFlash',       Format => 'int16s[4]' },
    0x49 => 'ColorTempFlash',
    0x4a => { Name => 'WB_RGGBLevelsUnknown2',    Format => 'int16s[4]', Unknown => 1 },
    0x4e => { Name => 'ColorTempUnknown2', Unknown => 1 },
    0x4f => { Name => 'WB_RGGBLevelsUnknown3',    Format => 'int16s[4]', Unknown => 1 },
    0x53 => { Name => 'ColorTempUnknown3', Unknown => 1 },
    0x54 => { Name => 'WB_RGGBLevelsUnknown4',    Format => 'int16s[4]', Unknown => 1 },
    0x58 => { Name => 'ColorTempUnknown4', Unknown => 1 },
    0x59 => { Name => 'WB_RGGBLevelsUnknown5',    Format => 'int16s[4]', Unknown => 1 },
    0x5d => { Name => 'ColorTempUnknown5', Unknown => 1 },
    0x5e => { Name => 'WB_RGGBLevelsUnknown6',    Format => 'int16s[4]', Unknown => 1 },
    0x62 => { Name => 'ColorTempUnknown6', Unknown => 1 },
    0x63 => { Name => 'WB_RGGBLevelsUnknown7',    Format => 'int16s[4]', Unknown => 1 },
    0x67 => { Name => 'ColorTempUnknown7', Unknown => 1 },
    0x68 => { Name => 'WB_RGGBLevelsUnknown8',   Format => 'int16s[4]', Unknown => 1 },
    0x6c => { Name => 'ColorTempUnknown8', Unknown => 1 },
    0x6d => { Name => 'WB_RGGBLevelsUnknown9',   Format => 'int16s[4]', Unknown => 1 },
    0x71 => { Name => 'ColorTempUnknown9', Unknown => 1 },
    0x72 => { Name => 'WB_RGGBLevelsUnknown10',  Format => 'int16s[4]', Unknown => 1 },
    0x76 => { Name => 'ColorTempUnknown10', Unknown => 1 },
    0x77 => { Name => 'WB_RGGBLevelsUnknown11',  Format => 'int16s[4]', Unknown => 1 },
    0x7b => { Name => 'ColorTempUnknown11', Unknown => 1 },
    0x7c => { Name => 'WB_RGGBLevelsUnknown12',  Format => 'int16s[4]', Unknown => 1 },
    0x80 => { Name => 'ColorTempUnknown12', Unknown => 1 },
    0x81 => { Name => 'WB_RGGBLevelsUnknown13',  Format => 'int16s[4]', Unknown => 1 },
    0x85 => { Name => 'ColorTempUnknown13', Unknown => 1 },
    0x86 => { Name => 'WB_RGGBLevelsUnknown14',  Format => 'int16s[4]', Unknown => 1 },
    0x8a => { Name => 'ColorTempUnknown14', Unknown => 1 },
    0x8b => { Name => 'WB_RGGBLevelsUnknown15',  Format => 'int16s[4]', Unknown => 1 },
    0x8f => { Name => 'ColorTempUnknown15', Unknown => 1 },
    0x90 => { Name => 'WB_RGGBLevelsPC1',        Format => 'int16s[4]' },
    0x94 => 'ColorTempPC1',
    0x95 => { Name => 'WB_RGGBLevelsPC2',        Format => 'int16s[4]' },
    0x99 => 'ColorTempPC2',
    0x9a => { Name => 'WB_RGGBLevelsPC3',        Format => 'int16s[4]' },
    0x9e => 'ColorTempPC3',
    0x9f => { Name => 'WB_RGGBLevelsUnknown16',  Format => 'int16s[4]', Unknown => 1 },
    0xa3 => { Name => 'ColorTempUnknown16', Unknown => 1 },
    0xa4 => { Name => 'CameraColorCalibration01', %cameraColorCalibration,
              Notes => 'A, B, C, Temperature' }, #PH
    0xa8 => { Name => 'CameraColorCalibration02', %cameraColorCalibration }, #PH
    0xac => { Name => 'CameraColorCalibration03', %cameraColorCalibration }, #PH
    0xb0 => { Name => 'CameraColorCalibration04', %cameraColorCalibration }, #PH
    0xb4 => { Name => 'CameraColorCalibration05', %cameraColorCalibration }, #PH
    0xb8 => { Name => 'CameraColorCalibration06', %cameraColorCalibration }, #PH
    0xbc => { Name => 'CameraColorCalibration07', %cameraColorCalibration }, #PH
    0xc0 => { Name => 'CameraColorCalibration08', %cameraColorCalibration }, #PH
    0xc4 => { Name => 'CameraColorCalibration09', %cameraColorCalibration }, #PH
    0xc8 => { Name => 'CameraColorCalibration10', %cameraColorCalibration }, #PH
    0xcc => { Name => 'CameraColorCalibration11', %cameraColorCalibration }, #PH
    0xd0 => { Name => 'CameraColorCalibration12', %cameraColorCalibration }, #PH
    0xd4 => { Name => 'CameraColorCalibration13', %cameraColorCalibration }, #PH
    0xd8 => { Name => 'CameraColorCalibration14', %cameraColorCalibration }, #PH
    0xdc => { Name => 'CameraColorCalibration15', %cameraColorCalibration }, #PH
    0x26a => { #PH
        Name => 'RawMeasuredRGGB',
        Format => 'int32u[4]',
        Notes => 'raw MeasuredRGGB values, before normalization',
        # swap words because the word ordering is big-endian, opposite to the byte ordering
        ValueConv => \&SwapWords,
        ValueConvInv => \&SwapWords,
    },
);

# Color data (MakerNotes tag 0x4001, count=796) (ref 12)
%Image::ExifTool::Canon::ColorData3 = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    NOTES => 'These tags are used by the 1DmkIIN, 5D, 30D and 400D.',
    FORMAT => 'int16s',
    FIRST_ENTRY => 0,
    WRITABLE => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    0x00 => { #PH
        Name => 'ColorDataVersion',
        PrintConv => {
            1 => '1 (1DmkIIN/5D/30D/400D)',
        },
    },
    # 0x01-0x3e: RGGB coefficients, apparently specific to the
    # individual camera and possibly used for color calibration (ref 37)
    # (dcraw 8.81 uses index 0x3f for WB)
    0x3f => { Name => 'WB_RGGBLevelsAsShot',      Format => 'int16s[4]' },
    0x43 => 'ColorTempAsShot',
    0x44 => { Name => 'WB_RGGBLevelsAuto',        Format => 'int16s[4]' },
    0x48 => 'ColorTempAuto',
    # not sure exactly what 'Measured' values mean...
    0x49 => { Name => 'WB_RGGBLevelsMeasured',    Format => 'int16s[4]' },
    0x4d => 'ColorTempMeasured',
    0x4e => { Name => 'WB_RGGBLevelsDaylight',    Format => 'int16s[4]' },
    0x52 => 'ColorTempDaylight',
    0x53 => { Name => 'WB_RGGBLevelsShade',       Format => 'int16s[4]' },
    0x57 => 'ColorTempShade',
    0x58 => { Name => 'WB_RGGBLevelsCloudy',      Format => 'int16s[4]' },
    0x5c => 'ColorTempCloudy',
    0x5d => { Name => 'WB_RGGBLevelsTungsten',    Format => 'int16s[4]' },
    0x61 => 'ColorTempTungsten',
    0x62 => { Name => 'WB_RGGBLevelsFluorescent', Format => 'int16s[4]' },
    0x66 => 'ColorTempFluorescent',
    0x67 => { Name => 'WB_RGGBLevelsKelvin',     Format => 'int16s[4]' },
    0x6b => 'ColorTempKelvin',
    0x6c => { Name => 'WB_RGGBLevelsFlash',      Format => 'int16s[4]' },
    0x70 => 'ColorTempFlash',
    0x71 => { Name => 'WB_RGGBLevelsPC1',        Format => 'int16s[4]' },
    0x75 => 'ColorTempPC1',
    0x76 => { Name => 'WB_RGGBLevelsPC2',        Format => 'int16s[4]' },
    0x7a => 'ColorTempPC2',
    0x7b => { Name => 'WB_RGGBLevelsPC3',        Format => 'int16s[4]' },
    0x7f => 'ColorTempPC3',
    0x80 => { Name => 'WB_RGGBLevelsCustom',     Format => 'int16s[4]' },
    0x84 => 'ColorTempCustom',
    # 0x85-0xbd: these coefficients are in a different order compared to older
    # models (A,B,C in ColorData1/2 vs. C,A,B in ColorData3/4) - PH
    # Coefficient A most closely matches the blue curvature, and
    # coefficient B most closely matches the red curvature, but the match
    # is not perfect, and I don't know what coefficient C is for (certainly
    # not a green coefficient) - PH
    0x85 => { Name => 'CameraColorCalibration01', %cameraColorCalibration,
              Notes => 'B, C, A, Temperature' }, #37
    0x89 => { Name => 'CameraColorCalibration02', %cameraColorCalibration }, #37
    0x8d => { Name => 'CameraColorCalibration03', %cameraColorCalibration }, #37
    0x91 => { Name => 'CameraColorCalibration04', %cameraColorCalibration }, #37
    0x95 => { Name => 'CameraColorCalibration05', %cameraColorCalibration }, #37
    0x99 => { Name => 'CameraColorCalibration06', %cameraColorCalibration }, #37
    0x9d => { Name => 'CameraColorCalibration07', %cameraColorCalibration }, #37
    0xa1 => { Name => 'CameraColorCalibration08', %cameraColorCalibration }, #37
    0xa5 => { Name => 'CameraColorCalibration09', %cameraColorCalibration }, #37
    0xa9 => { Name => 'CameraColorCalibration10', %cameraColorCalibration }, #37
    0xad => { Name => 'CameraColorCalibration11', %cameraColorCalibration }, #37
    0xb1 => { Name => 'CameraColorCalibration12', %cameraColorCalibration }, #37
    0xb5 => { Name => 'CameraColorCalibration13', %cameraColorCalibration }, #37
    0xb9 => { Name => 'CameraColorCalibration14', %cameraColorCalibration }, #37
    0xbd => { Name => 'CameraColorCalibration15', %cameraColorCalibration }, #37
    # 0xc5-0xc7: looks like black levels (ref 37)
    # 0xc8-0x1c7: some sort of color table (ref 37)
    0x248 => { #37
        Name => 'FlashOutput',
        ValueConv => '$val >= 255 ? 255 : exp(($val-200)/16*log(2))',
        ValueConvInv => '$val == 255 ? 255 : 200 + log($val)*16/log(2)',
        PrintConv => '$val == 255 ? "Strobe or Misfire" : sprintf("%.0f%%", $val * 100)',
        PrintConvInv => '$val =~ /^(\d(\.?\d*))/ ? $1 / 100 : 255',
    },
    0x249 => { #37
        Name => 'FlashBatteryLevel',
        # calibration points for external flash: 144=3.76V (almost empty), 192=5.24V (full)
        # - have seen a value of 201 with internal flash
        PrintConv => '$val ? sprintf("%.2fV", $val * 5 / 186) : "n/a"',
        PrintConvInv => '$val=~/^(\d+\.\d+)\s*V?$/i ? int($val*186/5+0.5) : 0',
    },
    0x24a => { #37
        Name => 'ColorTempFlashData',
        # 0 for no external flash, 35980 for 'Strobe or Misfire'
        # (lower than ColorTempFlash by up to 200 degrees)
        RawConv => '($val < 2000 or $val > 12000) ? undef : $val',
    },
    # 0x24b: inverse relationship with flash power (ref 37)
    # 0x286: has value 256 for correct exposure, less for under exposure (seen 96 minimum) (ref 37)
    0x287 => { #37
        Name => 'MeasuredRGGBData',
        Format => 'int32u[4]',
        Notes => 'MeasuredRGGB may be derived from these data values',
        # swap words because the word ordering is big-endian, opposite to the byte ordering
        ValueConv => \&SwapWords,
        ValueConvInv => \&SwapWords,
    },
    # 0x297: ranges from -10 to 30, higher for high ISO (ref 37)
);

# Color data (MakerNotes tag 0x4001, count=674|692|702|1227|1250) (ref PH)
%Image::ExifTool::Canon::ColorData4 = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    NOTES => q{
        These tags are used by the 1DmkIII, 1DSmkIII, 40D, 50D, 5DmkII, 450D and
        1000D.
    },
    FORMAT => 'int16s',
    FIRST_ENTRY => 0,
    WRITABLE => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    0x00 => {
        Name => 'ColorDataVersion',
        PrintConv => {
            2 => '2 (1DmkIII)',
            3 => '3 (40D)',
            4 => '4 (1DSmkIII)',
            5 => '5 (450D/1000D)',
            6 => '6 (50D/5DmkII)',
            7 => '7 (500D)',
        },
    },
    # 0x01-0x18: unknown RGGB coefficients (int16s[4]) (50D)
    # (dcraw 8.81 uses index 0x3f for WB)
    0x3f => { Name => 'WB_RGGBLevelsAsShot',      Format => 'int16s[4]' },
    0x43 => 'ColorTempAsShot',
    0x44 => { Name => 'WB_RGGBLevelsAuto',        Format => 'int16s[4]' },
    0x48 => 'ColorTempAuto',
    0x49 => { Name => 'WB_RGGBLevelsMeasured',    Format => 'int16s[4]' },
    0x4d => 'ColorTempMeasured',
    # the following Unknown values are set for the 50D and 5DmkII, and the
    # SRAW images of the 40D, and affect thumbnail display for the 50D/5DmkII
    # and conversion for all modes of the 40D
    0x4e => { Name => 'WB_RGGBLevelsUnknown',     Format => 'int16s[4]', Unknown => 1 },
    0x52 => { Name => 'ColorTempUnknown', Unknown => 1 },
    0x53 => { Name => 'WB_RGGBLevelsDaylight',    Format => 'int16s[4]' },
    0x57 => 'ColorTempDaylight',
    0x58 => { Name => 'WB_RGGBLevelsShade',       Format => 'int16s[4]' },
    0x5c => 'ColorTempShade',
    0x5d => { Name => 'WB_RGGBLevelsCloudy',      Format => 'int16s[4]' },
    0x61 => 'ColorTempCloudy',
    0x62 => { Name => 'WB_RGGBLevelsTungsten',    Format => 'int16s[4]' },
    0x66 => 'ColorTempTungsten',
    0x67 => { Name => 'WB_RGGBLevelsFluorescent',Format => 'int16s[4]' },
    0x6b => 'ColorTempFluorescent',
    # (changing the Kelvin values has no effect on image in DPP... why not?)
    0x6c => { Name => 'WB_RGGBLevelsKelvin',     Format => 'int16s[4]' },
    0x70 => 'ColorTempKelvin',
    0x71 => { Name => 'WB_RGGBLevelsFlash',      Format => 'int16s[4]' },
    0x75 => 'ColorTempFlash',
    0x76 => { Name => 'WB_RGGBLevelsUnknown2',   Format => 'int16s[4]', Unknown => 1 },
    0x7a => { Name => 'ColorTempUnknown2', Unknown => 1 },
    0x7b => { Name => 'WB_RGGBLevelsUnknown3',   Format => 'int16s[4]', Unknown => 1 },
    0x7f => { Name => 'ColorTempUnknown3', Unknown => 1 },
    0x80 => { Name => 'WB_RGGBLevelsUnknown4',   Format => 'int16s[4]', Unknown => 1 },
    0x84 => { Name => 'ColorTempUnknown4', Unknown => 1 },
    0x85 => { Name => 'WB_RGGBLevelsUnknown5',   Format => 'int16s[4]', Unknown => 1 },
    0x89 => { Name => 'ColorTempUnknown5', Unknown => 1 },
    0x8a => { Name => 'WB_RGGBLevelsUnknown6',   Format => 'int16s[4]', Unknown => 1 },
    0x8e => { Name => 'ColorTempUnknown6', Unknown => 1 },
    0x8f => { Name => 'WB_RGGBLevelsUnknown7',   Format => 'int16s[4]', Unknown => 1 },
    0x93 => { Name => 'ColorTempUnknown7', Unknown => 1 },
    0x94 => { Name => 'WB_RGGBLevelsUnknown8',   Format => 'int16s[4]', Unknown => 1 },
    0x98 => { Name => 'ColorTempUnknown8', Unknown => 1 },
    0x99 => { Name => 'WB_RGGBLevelsUnknown9',   Format => 'int16s[4]', Unknown => 1 },
    0x9d => { Name => 'ColorTempUnknown9', Unknown => 1 },
    0x9e => { Name => 'WB_RGGBLevelsUnknown10',  Format => 'int16s[4]', Unknown => 1 },
    0xa2 => { Name => 'ColorTempUnknown10', Unknown => 1 },
    0xa3 => { Name => 'WB_RGGBLevelsUnknown11',  Format => 'int16s[4]', Unknown => 1 },
    0xa7 => { Name => 'ColorTempUnknown11', Unknown => 1 },
    0xa8 => { Name => 'CameraColorCalibration01', %cameraColorCalibration,
              Notes => 'B, C, A, Temperature' },
    0xac => { Name => 'CameraColorCalibration02', %cameraColorCalibration },
    0xb0 => { Name => 'CameraColorCalibration03', %cameraColorCalibration },
    0xb4 => { Name => 'CameraColorCalibration04', %cameraColorCalibration },
    0xb8 => { Name => 'CameraColorCalibration05', %cameraColorCalibration },
    0xbc => { Name => 'CameraColorCalibration06', %cameraColorCalibration },
    0xc0 => { Name => 'CameraColorCalibration07', %cameraColorCalibration },
    0xc4 => { Name => 'CameraColorCalibration08', %cameraColorCalibration },
    0xc8 => { Name => 'CameraColorCalibration09', %cameraColorCalibration },
    0xcc => { Name => 'CameraColorCalibration10', %cameraColorCalibration },
    0xd0 => { Name => 'CameraColorCalibration11', %cameraColorCalibration },
    0xd4 => { Name => 'CameraColorCalibration12', %cameraColorCalibration },
    0xd8 => { Name => 'CameraColorCalibration13', %cameraColorCalibration },
    0xdc => { Name => 'CameraColorCalibration14', %cameraColorCalibration },
    0xe0 => { Name => 'CameraColorCalibration15', %cameraColorCalibration },
    0x280 => { #PH
        Name => 'RawMeasuredRGGB',
        Format => 'int32u[4]',
        Notes => 'raw MeasuredRGGB values, before normalization',
        # swap words because the word ordering is big-endian, opposite to the byte ordering
        ValueConv => \&SwapWords,
        ValueConvInv => \&SwapWords,
    },
);

# Color data (MakerNotes tag 0x4001, count=5120) (ref PH)
%Image::ExifTool::Canon::ColorData5 = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    NOTES => 'These tags are used by the PowerShot G10.',
    FORMAT => 'int16s',
    FIRST_ENTRY => 0,
    WRITABLE => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    0x47 => { Name => 'WB_RGGBLevelsAsShot',      Format => 'int16s[4]' },
    0x4b => 'ColorTempAsShot',
    0x4c => { Name => 'WB_RGGBLevelsAuto',        Format => 'int16s[4]' },
    0x50 => 'ColorTempAuto',
    0x51 => { Name => 'WB_RGGBLevelsMeasured',    Format => 'int16s[4]' },
    0x55 => 'ColorTempMeasured',
    0x56 => { Name => 'WB_RGGBLevelsUnknown',     Format => 'int16s[4]', Unknown => 1 },
    0x5a => { Name => 'ColorTempUnknown', Unknown => 1 },
    0x5b => { Name => 'WB_RGGBLevelsDaylight',    Format => 'int16s[4]' },
    0x5f => 'ColorTempDaylight',
    0x60 => { Name => 'WB_RGGBLevelsShade',       Format => 'int16s[4]' },
    0x64 => 'ColorTempShade',
    0x65 => { Name => 'WB_RGGBLevelsCloudy',      Format => 'int16s[4]' },
    0x69 => 'ColorTempCloudy',
    0x6a => { Name => 'WB_RGGBLevelsTungsten',    Format => 'int16s[4]' },
    0x6e => 'ColorTempTungsten',
    0x6f => { Name => 'WB_RGGBLevelsFluorescent',Format => 'int16s[4]' },
    0x73 => 'ColorTempFluorescent',
    0x74 => { Name => 'WB_RGGBLevelsKelvin',     Format => 'int16s[4]' },
    0x78 => 'ColorTempKelvin',
    0x79 => { Name => 'WB_RGGBLevelsFlash',      Format => 'int16s[4]' },
    0x7d => 'ColorTempFlash',
    0x7e => { Name => 'WB_RGGBLevelsUnknown2',   Format => 'int16s[4]', Unknown => 1 },
    0x82 => { Name => 'ColorTempUnknown2', Unknown => 1 },
    0x83 => { Name => 'WB_RGGBLevelsUnknown3',   Format => 'int16s[4]', Unknown => 1 },
    0x87 => { Name => 'ColorTempUnknown3', Unknown => 1 },
    0x88 => { Name => 'WB_RGGBLevelsUnknown4',   Format => 'int16s[4]', Unknown => 1 },
    0x8c => { Name => 'ColorTempUnknown4', Unknown => 1 },
    0x8d => { Name => 'WB_RGGBLevelsUnknown5',   Format => 'int16s[4]', Unknown => 1 },
    0x91 => { Name => 'ColorTempUnknown5', Unknown => 1 },
    0x92 => { Name => 'WB_RGGBLevelsUnknown6',   Format => 'int16s[4]', Unknown => 1 },
    0x96 => { Name => 'ColorTempUnknown6', Unknown => 1 },
    0x97 => { Name => 'WB_RGGBLevelsUnknown7',   Format => 'int16s[4]', Unknown => 1 },
    0x9b => { Name => 'ColorTempUnknown7', Unknown => 1 },
    0x9c => { Name => 'WB_RGGBLevelsUnknown8',   Format => 'int16s[4]', Unknown => 1 },
    0xa0 => { Name => 'ColorTempUnknown8', Unknown => 1 },
    0xa1 => { Name => 'WB_RGGBLevelsUnknown9',   Format => 'int16s[4]', Unknown => 1 },
    0xa5 => { Name => 'ColorTempUnknown9', Unknown => 1 },
    0xa6 => { Name => 'WB_RGGBLevelsUnknown10',  Format => 'int16s[4]', Unknown => 1 },
    0xaa => { Name => 'ColorTempUnknown10', Unknown => 1 },
    0xab => { Name => 'WB_RGGBLevelsUnknown11',  Format => 'int16s[4]', Unknown => 1 },
    0xaf => { Name => 'ColorTempUnknown11', Unknown => 1 },
    0xb0 => { Name => 'WB_RGGBLevelsUnknown12',  Format => 'int16s[4]', Unknown => 1 },
    0xb4 => { Name => 'ColorTempUnknown12', Unknown => 1 },
    0xb5 => { Name => 'WB_RGGBLevelsUnknown13',  Format => 'int16s[4]', Unknown => 1 },
    0xb9 => { Name => 'ColorTempUnknown13', Unknown => 1 },
    0xba => { Name => 'CameraColorCalibration01', %cameraColorCalibration2,
              Notes => 'B, C, A, D, Temperature' },
    0xbf => { Name => 'CameraColorCalibration02', %cameraColorCalibration2 },
    0xc4 => { Name => 'CameraColorCalibration03', %cameraColorCalibration2 },
    0xc9 => { Name => 'CameraColorCalibration04', %cameraColorCalibration2 },
    0xce => { Name => 'CameraColorCalibration05', %cameraColorCalibration2 },
    0xd3 => { Name => 'CameraColorCalibration06', %cameraColorCalibration2 },
    0xd8 => { Name => 'CameraColorCalibration07', %cameraColorCalibration2 },
    0xdd => { Name => 'CameraColorCalibration08', %cameraColorCalibration2 },
    0xe2 => { Name => 'CameraColorCalibration09', %cameraColorCalibration2 },
    0xe7 => { Name => 'CameraColorCalibration10', %cameraColorCalibration2 },
    0xec => { Name => 'CameraColorCalibration11', %cameraColorCalibration2 },
    0xf1 => { Name => 'CameraColorCalibration12', %cameraColorCalibration2 },
    0xf6 => { Name => 'CameraColorCalibration13', %cameraColorCalibration2 },
    0xfb => { Name => 'CameraColorCalibration14', %cameraColorCalibration2 },
    0x100=> { Name => 'CameraColorCalibration15', %cameraColorCalibration2 },
);

# Unknown color data
%Image::ExifTool::Canon::ColorDataUnknown = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    FORMAT => 'int16s',
    FIRST_ENTRY => 0,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
);

# Color information (MakerNotes tag 0x4003) (ref PH)
%Image::ExifTool::Canon::ColorInfo = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16s',
    FIRST_ENTRY => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    1 => {
        Condition => '$$self{Model} =~ /EOS-1D/',
        Name => 'Saturation',
        %Image::ExifTool::Exif::printParameter,
    },
    2 => {
        Name => 'ColorTone',
        %Image::ExifTool::Exif::printParameter,
    },
    3 => {
        Name => 'ColorSpace',
        RawConv => '$val ? $val : undef', # ignore tag if zero
        PrintConv => {
            1 => 'sRGB',
            2 => 'Adobe RGB',
        },
    },
);

# AF micro-adjustment information (MakerNotes tag 0x4013) (ref PH)
%Image::ExifTool::Canon::AFMicroAdj = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int32s',
    FIRST_ENTRY => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    1 => {
        Name => 'AFMicroAdjActive',
        PrintConv => {
            0 => 'No',
            1 => 'Yes',
        },
    },
    2 => {
        Name => 'AFMicroAdjValue',
        Format => 'rational64s',
    },
);

# Flags information (MakerNotes tag 0xb0) (ref PH)
%Image::ExifTool::Canon::Flags = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16s',
    FIRST_ENTRY => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    1 => 'ModifiedParamFlag',
);

# Modified information (MakerNotes tag 0xb1) (ref PH)
%Image::ExifTool::Canon::ModifiedInfo = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    WRITE_PROC => \&Image::ExifTool::WriteBinaryData,
    CHECK_PROC => \&Image::ExifTool::CheckBinaryData,
    WRITABLE => 1,
    FORMAT => 'int16s',
    FIRST_ENTRY => 1,
    GROUPS => { 0 => 'MakerNotes', 2 => 'Camera' },
    1 => {
        Name => 'ModifiedToneCurve',
        PrintConv => {
            0 => 'Standard',
            1 => 'Manual',
            2 => 'Custom',
        },
    },
    2 => {
        Name => 'ModifiedSharpness',
        Notes => '1D and 5D only',
        Condition => '$$self{Model} =~ /\b(1D|5D)/',
    },
    3 => {
        Name => 'ModifiedSharpnessFreq',
        PrintConv => {
            0 => 'n/a',
            1 => 'Lowest',
            2 => 'Low',
            3 => 'Standard',
            4 => 'High',
            5 => 'Highest',
        },
    },
    4 => 'ModifiedSensorRedLevel',
    5 => 'ModifiedSensorBlueLevel',
    6 => 'ModifiedWhiteBalanceRed',
    7 => 'ModifiedWhiteBalanceBlue',
    8 => {
        Name => 'ModifiedWhiteBalance',
        PrintConv => \%canonWhiteBalance,
        SeparateTable => 'WhiteBalance',
    },
    9 => 'ModifiedColorTemp',
    10 => {
        Name => 'ModifiedPictureStyle',
        PrintHex => 1,
        SeparateTable => 'PictureStyle',
        PrintConv => \%pictureStyles,
    },
    11 => {
        Name => 'ModifiedDigitalGain',
        ValueConv => '$val / 10',
        ValueConvInv => '$val * 10',
    },
);

# Canon composite tags
%Image::ExifTool::Canon::Composite = (
    GROUPS => { 2 => 'Camera' },
    DriveMode => {
        Require => {
            0 => 'ContinuousDrive',
            1 => 'SelfTimer',
        },
        ValueConv => '$val[0] ? 0 : ($val[1] ? 1 : 2)',
        PrintConv => {
            0 => 'Continuous shooting',
            1 => 'Self-timer Operation',
            2 => 'Single-frame shooting',
        },
    },
    Lens => {
        Require => {
            0 => 'ShortFocal',
            1 => 'LongFocal',
        },
        ValueConv => '$val[0]',
        PrintConv => 'Image::ExifTool::Canon::PrintFocalRange(@val)',
    },
    Lens35efl => {
        Description => 'Lens',
        Require => {
            0 => 'ShortFocal',
            1 => 'LongFocal',
            3 => 'Lens',
        },
        Desire => {
            2 => 'ScaleFactor35efl',
        },
        ValueConv => '$val[3] * ($val[2] ? $val[2] : 1)',
        PrintConv => '$prt[3] . ($val[2] ? sprintf(" (35 mm equivalent: %s)",Image::ExifTool::Canon::PrintFocalRange(@val)) : "")',
    },
    ShootingMode => {
        Require => {
            0 => 'CanonExposureMode',
            1 => 'EasyMode',
        },
        Desire => {
            2 => 'BulbDuration',
        },
        # most Canon models set CanonExposureMode to Manual (4) for Bulb shots,
        # but the 1DmkIII uses a value of 7 for Bulb, so use this for other
        # models too (Note that Canon DPP reports "Manual Exposure" here)
        ValueConv => '$val[0] ? (($val[0] eq "4" and $val[2]) ? 7 : $val[0]) : $val[1] + 10',
        PrintConv => '$val eq "7" ? "Bulb" : ($val[0] ? $prt[0] : $prt[1])',
    },
    FlashType => {
        Notes => q{
            may report "Built-in Flash" for some Canon cameras with external flash in
            manual mode
        },
        Require => {
            0 => 'FlashBits',
        },
        RawConv => '$val[0] ? $val : undef',
        ValueConv => '$val[0]&(1<<14)? 1 : 0',
        PrintConv => {
            0 => 'Built-In Flash',
            1 => 'External',
        },
    },
    RedEyeReduction => {
        Require => {
            0 => 'CanonFlashMode',
            1 => 'FlashBits',
        },
        RawConv => '$val[1] ? $val : undef',
        ValueConv => '($val[0]==3 or $val[0]==4 or $val[0]==6) ? 1 : 0',
        PrintConv => {
            0 => 'Off',
            1 => 'On',
        },
    },
    # same as FlashExposureComp, but undefined if no flash
    ConditionalFEC => {
        Description => 'Flash Exposure Compensation',
        Require => {
            0 => 'FlashExposureComp',
            1 => 'FlashBits',
        },
        RawConv => '$val[1] ? $val : undef',
        ValueConv => '$val[0]',
        PrintConv => '$prt[0]',
    },
    # hack to assume 1st curtain unless we see otherwise
    ShutterCurtainHack => {
        Description => 'Shutter Curtain Sync',
        Desire => {
            0 => 'ShutterCurtainSync',
        },
        Require => {
            1 => 'FlashBits',
        },
        RawConv => '$val[1] ? $val : undef',
        ValueConv => 'defined($val[0]) ? $val[0] : 0',
        PrintConv => {
            0 => '1st-curtain sync',
            1 => '2nd-curtain sync',
        },
    },
    WB_RGGBLevels => {
        Require => {
            0 => 'Canon:WhiteBalance',
        },
        Desire => {
            1 => 'WB_RGGBLevelsAsShot',
            # indices of the following entries correspond to Canon:WhiteBalance + 2
            2 => 'WB_RGGBLevelsAuto',
            3 => 'WB_RGGBLevelsDaylight',
            4 => 'WB_RGGBLevelsCloudy',
            5 => 'WB_RGGBLevelsTungsten',
            6 => 'WB_RGGBLevelsFluorescent',
            7 => 'WB_RGGBLevelsFlash',
            8 => 'WB_RGGBLevelsCustom',
           10 => 'WB_RGGBLevelsShade',
           11 => 'WB_RGGBLevelsKelvin',
        },
        ValueConv => '$val[1] ? $val[1] : $val[($val[0] || 0) + 2]',
    },
    ISO => {
        Priority => 0,  # let EXIF:ISO take priority
        Desire => {
            0 => 'Canon:CameraISO',
            1 => 'Canon:BaseISO',
            2 => 'Canon:AutoISO',
        },
        Notes => 'use CameraISO if numerical, otherwise calculate as BaseISO * AutoISO / 100',
        ValueConv => q{
            return $val[0] if $val[0] and $val[0] =~ /^\d+$/;
            return undef unless $val[1] and $val[2];
            return $val[1] * $val[2] / 100;
        },
        PrintConv => 'sprintf("%.0f",$val)',
    },
    DigitalZoom => {
        Require => {
            0 => 'Canon:ZoomSourceWidth',
            1 => 'Canon:ZoomTargetWidth',
            2 => 'Canon:DigitalZoom',
        },
        RawConv => q{
            ToFloat(@val);
            return undef unless $val[2] and $val[2] == 3 and $val[0] and $val[1];
            return $val[1] / $val[0];
        },
        PrintConv => 'sprintf("%.2fx",$val)',
    },
    OriginalDecisionData => {
        Flags => ['Writable','Protected'],
        WriteGroup => 'MakerNotes',
        Require => 'OriginalDecisionDataOffset',
        RawConv => 'Image::ExifTool::Canon::ReadODD($self,$val[0])',
    },
    FileNumber => {
        Groups => { 2 => 'Image' },
        Require => {
            0 => 'DirectoryIndex',
            1 => 'FileIndex',
        },
        ValueConv => 'sprintf("%.3d-%.4d",@val)',
    },
);

# add our composite tags
Image::ExifTool::AddCompositeTags('Image::ExifTool::Canon');

#------------------------------------------------------------------------------
# Attempt to identify the specific lens if multiple lenses have the same LensType
# Inputs: 0) PrintConv hash ref, 1) LensType, 2) ShortFocal, 3) LongFocal
#         4) MaxAperture, 5) LensModel
# Notes: PrintConv, LensType, ShortFocal and LongFocal must be defined.
#        Other inputs are optional.
sub PrintLensID(@)
{
    my ($printConv, $lensType, $shortFocal, $longFocal, $maxAperture, $lensModel) = @_;
    my $lens = $$printConv{$lensType};
    if ($lens) {
        return $lens unless $$printConv{"$lensType.1"};
        $lens =~ s/ or .*//s;    # remove everything after "or"
        # make list of all possible matching lenses
        my @lenses = ( $lens );
        my $i;
        for ($i=1; $$printConv{"$lensType.$i"}; ++$i) {
            push @lenses, $$printConv{"$lensType.$i"};
        }
        my ($tc, @maybe, @likely, @matches);
        # look for lens in user-defined lenses
        foreach $lens (@lenses) {
            next unless $Image::ExifTool::userLens{$lens} and $lens =~ /(\d+)/;
            my $sf = $1;    # short focal length
            # add teleconverter multiplication factor if applicable
            foreach $tc (1, 1.4, 2, 2.8) {
                next if abs($shortFocal - $sf * $tc) > 0.9;
                $lens .= " + ${tc}x" if $tc > 1;
                last;
            }
            return $lens;
        }
        # attempt to determine actual lens
        foreach $tc (1, 1.4, 2, 2.8) {  # loop through teleconverter scaling factors
            foreach $lens (@lenses) {
                next unless $lens =~ /(\d+)(?:-(\d+))?mm.*?(?:[fF]\/?)(\d+(?:\.\d+)?)(?:-(\d+(?:\.\d+)?))?/;
                # ($1=short focal, $2=long focal, $3=max aperture wide, $4=max aperture tele)
                my ($sf, $lf, $sa, $la) = ($1, $2, $3, $4);
                # see if we can rule out this lens by focal length or aperture
                $lf = $sf if $sf and not $lf;
                $la = $sa if $sa and not $la;
                next if abs($shortFocal - $sf * $tc) > 0.9;
                my $tclens = $lens;
                $tclens .= " + ${tc}x" if $tc > 1;
                push @maybe, $tclens;
                next if abs($longFocal  - $lf * $tc) > 0.9;
                push @likely, $tclens;
                if ($maxAperture) {
                    # (not 100% sure that TC affects MaxAperture, but it should!)
                    next if $maxAperture < $sa * $tc - 0.15;
                    next if $maxAperture > $la * $tc + 0.15;
                }
                push @matches, $tclens;
            }
            last if @maybe;
        }
        return join(' or ', @matches) if @matches;
        return join(' or ', @likely) if @likely;
        return join(' or ', @maybe) if @maybe;
    } elsif ($lensModel and $lensModel =~ /\d/) {
        # use lens model as written by the camera (add "Canon" to the start
        # since the camera only understands Canon lenses anyway)
        return "Canon $lensModel";
    }
    my $str = '';
    if ($shortFocal) {
        $str .= sprintf(' %d', $shortFocal);
        $str .= sprintf('-%d', $longFocal) if $longFocal and $longFocal != $shortFocal;
        $str .= 'mm';
    }
    return "Unknown$str" if $lensType < 0;
    return "Unknown ($lensType)$str";
}

#------------------------------------------------------------------------------
# Swap 16-bit words in 32-bit integers
# Inputs: 0) string of integers
# Returns: string of word-swapped integers
sub SwapWords($)
{
    my @a = split(' ', shift);
    $_ = (($_ >> 16) | ($_ << 16)) & 0xffffffff foreach @a;
    return "@a";
}

#------------------------------------------------------------------------------
# Validate first word of Canon binary data
# Inputs: 0) data pointer, 1) offset, 2-N) list of valid values
# Returns: true if data value is the same
sub Validate($$@)
{
    my ($dataPt, $offset, @vals) = @_;
    # the first 16-bit value is the length of the data in bytes
    my $dataVal = Image::ExifTool::Get16u($dataPt, $offset);
    my $val;
    foreach $val (@vals) {
        return 1 if $val == $dataVal;
    }
    return undef;
}

#------------------------------------------------------------------------------
# Validate CanonAFInfo
# Inputs: 0) data pointer, 1) offset, 2) size
# Returns: true if data appears valid
sub ValidateAFInfo($$$)
{
    my ($dataPt, $offset, $size) = @_;
    return 0 if $size < 24; # must be at least 24 bytes long (PowerShot Pro1)
    my $af = Get16u($dataPt, $offset);
    return 0 if $af !~ /^(1|5|7|9|15|45|53)$/; # check NumAFPoints
    my $w1 = Get16u($dataPt, $offset + 4);
    my $h1 = Get16u($dataPt, $offset + 6);
    return 0 unless $h1 and $w1;
    my $f1 = $w1 / $h1;
    # check for normal aspect ratio
    return 1 if abs($f1 - 1.33) < 0.01 or abs($f1 - 1.67) < 0.01;
    # ZoomBrowser can modify this for rotated images (ref Joshua Bixby)
    return 1 if abs($f1 - 0.75) < 0.01 or abs($f1 - 0.60) < 0.01;
    my $w2 = Get16u($dataPt, $offset + 8);
    my $h2 = Get16u($dataPt, $offset + 10);
    return 0 unless $h2 and $w2;
    # compare aspect ratio with AF image size
    # (but the Powershot AFImageHeight is odd, hence the test above)
    return 0 if $w1 eq $h1;
    my $f2 = $w2 / $h2;
    return 1 if abs(1-$f1/$f2) < 0.01;
    return 1 if abs(1-$f1*$f2) < 0.01;
    return 0;
}

#------------------------------------------------------------------------------
# Read original decision data from file (variable length)
# Inputs: 0) ExifTool object ref, 1) offset in file
# Returns: reference to original decision data (or undef if no data)
sub ReadODD($$)
{
    my ($exifTool, $offset) = @_;
    return undef unless $offset;
    my ($raf, $buff, $buf2, $i);
    return undef unless defined($raf = $$exifTool{RAF});
    # the data block is a variable length and starts with ff ff ff ff followed
    # an int32u count of the number of records.  Then an int32u size of the first
    # record, then the first record data, int32u size of the 2nd record, etc,
    # for the specified number of records (for some reason the size of the last
    # record includes the size word, but the others don't)
    my $pos = $raf->Tell();
    if ($raf->Seek($offset, 0) and $raf->Read($buff, 8)==8 and $buff=~/^\xff{4}.\0\0/s) {
        my $err = 1;
        # must set byte order in case it is different than current byte order
        # (we could be reading this after byte order was changed)
        my $oldOrder = GetByteOrder();
        my $count = Get32u(\$buff, 4);
        if ($count > 20) {
            ToggleByteOrder();
            $count = unpack('N',pack('V',$count));
        }
        if ($count and $count <= 20) {
            for ($i=0; ; ++$i) {
                $i >= $count and undef $err, last;
                $raf->Read($buf2, 4) == 4 or last;
                $buff .= $buf2;
                my $len = Get32u(\$buf2, 0);
                # (apparently the last record includes the size word itself
                # in the data size, but the others don't. doh!)
                $len -= 4 if $i == $count - 1 and $len >= 4;
                # make sure records are a reasonable size (< 1MB)
                $len <= 0x100000 and $raf->Read($buf2, $len) == $len or last;
                $buff .= $buf2;
            }
        }
        SetByteOrder($oldOrder);
        if ($err) {
            # the Canon 5D doesn't seem to use the same record format as the 40D,
            # and the above parsing fails.  For the 40D, the data size is 512 bytes
            # for JPEG images and 608 bytes for CR2 images.  For my only 5D sample
            # with this information, it is 160 bytes for the CR2 image.  So just to
            # be safe, let's copy up to 800 bytes:
            $raf->Seek($offset, 0);
            $raf->Read($buff, 800);
        } elsif ($exifTool->Options('HtmlDump')) {
            $exifTool->HtmlDump($offset, length $buff, '[OriginalDecisionData]', undef);
        }
        $raf->Seek($pos, 0);    # restore original file position
        return \$buff;
    }
    $exifTool->Warn('Invalid original decision data');
    $raf->Seek($pos, 0);    # restore original file position
    return undef;
}

#------------------------------------------------------------------------------
# Convert the CameraISO value
# Inputs: 0) value, 1) set for inverse conversion
sub CameraISO($;$)
{
    my ($val, $inv) = @_;
    my $rtnVal;
    my %isoLookup = (
         0 => 'n/a',
        14 => 'Auto High', #PH (S3IS)
        15 => 'Auto',
        16 => 50,
        17 => 100,
        18 => 200,
        19 => 400,
        20 => 800, #PH
    );
    if ($inv) {
        $rtnVal = Image::ExifTool::ReverseLookup($val, \%isoLookup);
        if (not defined $rtnVal and Image::ExifTool::IsInt($val)) {
            $rtnVal = ($val & 0x3fff) | 0x4000;
        }
    } elsif ($val != 0x7fff) {
        if ($val & 0x4000) {
            $rtnVal = $val & 0x3fff;
        } else {
            $rtnVal = $isoLookup{$val} || "Unknown ($val)";
        }
    }
    return $rtnVal;
}

#------------------------------------------------------------------------------
# Print range of focal lengths
# Inputs: 0) short focal, 1) long focal, 2) optional scaling factor
sub PrintFocalRange(@)
{
    my ($short, $long, $scale) = @_;

    $scale or $scale = 1;
    if ($short == $long) {
        return sprintf("%.1f mm", $short * $scale);
    } else {
        return sprintf("%.1f - %.1f mm", $short * $scale, $long * $scale);
    }
}

#------------------------------------------------------------------------------
# process a serial stream of binary data
# Inputs: 0) ExifTool object ref, 1) dirInfo ref, 2) tag table ref
# Returns: 1 on success
# Notes: The tagID's for serial stream tags are consecutive indices beginning
#        at 0, and the corresponding values must be contiguous in memory.
#        "Unknown" tags must be used to skip padding or unknown values.
sub ProcessSerialData($$$)
{
    my ($exifTool, $dirInfo, $tagTablePtr) = @_;
    my $dataPt = $$dirInfo{DataPt};
    my $offset = $$dirInfo{DirStart};
    my $size = $$dirInfo{DirLen};
    my $base = $$dirInfo{Base} || 0;
    my $verbose = $exifTool->Options('Verbose');
    my $dataPos = $$dirInfo{DataPos} || 0;

    # temporarily set Unknown option so GetTagInfo() will return existing unknown tags
    # (require to maintain serial data synchronization)
    my $unknown = $exifTool->Options(Unknown => 1);
    # but disable unknown tag generation (because processing ends when we run out of tags)
    $$exifTool{NO_UNKNOWN} = 1;

    $verbose and $exifTool->VerboseDir('SerialData', undef, $size);

    # get default format ('int8u' unless specified)
    my $defaultFormat = $$tagTablePtr{FORMAT} || 'int8u';

    my ($index, %val);
    my $pos = 0;
    for ($index=0; $$tagTablePtr{$index} and $pos <= $size; ++$index) {
        my $tagInfo = $exifTool->GetTagInfo($tagTablePtr, $index) or last;
        my $format = $$tagInfo{Format};
        my $count = 1;
        if ($format) {
            if ($format =~ /(.*)\[(.*)\]/) {
                $format = $1;
                $count = $2;
                # evaluate count to allow count to be based on previous values
                #### eval Format (%val, $size)
                $count = eval $count;
                $@ and warn("Format $$tagInfo{Name}: $@"), last;
            } elsif ($format eq 'string') {
                # allow string with no specified count to run to end of block
                $count = ($size > $pos) ? $size - $pos : 0;
            }
        } else {
            $format = $defaultFormat;
        }
        my $len = (Image::ExifTool::FormatSize($format) || 1) * $count;
        last if $pos + $len > $size;
        my $val = ReadValue($dataPt, $pos+$offset, $format, $count, $size-$pos);
        last unless defined $val;
        if ($verbose) {
            $exifTool->VerboseInfo($index, $tagInfo,
                Index  => $index,
                Table  => $tagTablePtr,
                Value  => $val,
                DataPt => $dataPt,
                Size   => $len,
                Start  => $pos+$offset,
                Addr   => $pos+$offset+$base+$dataPos,
                Format => $format,
                Count  => $count,
            );
        }
        $val{$index} = $val;
        if ($$tagInfo{SubDirectory}) {
            my $subTablePtr = GetTagTable($tagInfo->{SubDirectory}->{TagTable});
            my %dirInfo = (
                DataPt => \$val,
                DataPos => $dataPos + $pos,
                DirStart => 0,
                DirLen => length($val),
            );
            $exifTool->ProcessDirectory(\%dirInfo, $subTablePtr);
        } elsif (not $$tagInfo{Unknown} or $unknown) {
            # don't extract zero-length information
            $exifTool->FoundTag($tagInfo, $val) if $count;
        }
        $pos += $len;
    }
    $exifTool->Options(Unknown => $unknown);    # restore Unknown option
    delete $$exifTool{NO_UNKNOWN};
    return 1;
}

#------------------------------------------------------------------------------
# Print 1D AF points
# Inputs: 0) value to convert
# Focus point pattern:
#            A1  A2  A3  A4  A5  A6  A7
#      B1  B2  B3  B4  B5  B6  B7  B8  B9  B10
#    C1  C2  C3  C4  C5  C6  C7  C9  C9  C10  C11
#      D1  D2  D3  D4  D5  D6  D7  D8  D9  D10
#            E1  E2  E3  E4  E5  E6  E7
sub PrintAFPoints1D($)
{
    my $val = shift;
    return 'Unknown' unless length $val == 8;
    # list of focus point values for decoding the first byte of the 8-byte record.
    # they are the x/y positions of each bit in the AF point mask
    # (y is upper 3 bits / x is lower 5 bits)
    my @focusPts = (0,0,
              0x04,0x06,0x08,0x0a,0x0c,0x0e,0x10,         0,0,
      0x21,0x23,0x25,0x27,0x29,0x2b,0x2d,0x2f,0x31,0x33,
    0x40,0x42,0x44,0x46,0x48,0x4a,0x4c,0x4d,0x50,0x52,0x54,
      0x61,0x63,0x65,0x67,0x69,0x6b,0x6d,0x6f,0x71,0x73,  0,0,
              0x84,0x86,0x88,0x8a,0x8c,0x8e,0x90,   0,0,0,0,0
    );
    my $focus = unpack('C',$val);
    my @bits = split //, unpack('b*',substr($val,1));
    my @rows = split //, '  AAAAAAA  BBBBBBBBBBCCCCCCCCCCCDDDDDDDDDD  EEEEEEE     ';
    my ($focusing, $focusPt, @points);
    my $lastRow = '';
    my $col = 0;
    foreach $focusPt (@focusPts) {
        my $row = shift @rows;
        $col = ($row eq $lastRow) ? $col + 1 : 1;
        $lastRow = $row;
        $focusing = "$row$col" if $focus eq $focusPt;
        push @points, "$row$col" if shift @bits;
    }
    $focusing or $focusing = ($focus eq 0xff) ? 'Auto' : sprintf('Unknown (0x%.2x)',$focus);
    return "$focusing (" . join(',',@points) . ')';
}

#------------------------------------------------------------------------------
# Convert Canon hex-based EV (modulo 0x20) to real number
# Inputs: 0) value to convert
# ie) 0x00 -> 0
#     0x0c -> 0.33333
#     0x10 -> 0.5
#     0x14 -> 0.66666
#     0x20 -> 1   ...  etc
sub CanonEv($)
{
    my $val = shift;
    my $sign;
    # temporarily make the number positive
    if ($val < 0) {
        $val = -$val;
        $sign = -1;
    } else {
        $sign = 1;
    }
    my $frac = $val & 0x1f;
    $val -= $frac;      # remove fraction
    # Convert 1/3 and 2/3 codes
    if ($frac == 0x0c) {
        $frac = 0x20 / 3;
    } elsif ($frac == 0x14) {
        $frac = 0x40 / 3;
    }
    return $sign * ($val + $frac) / 0x20;
}

#------------------------------------------------------------------------------
# Convert number to Canon hex-based EV (modulo 0x20)
# Inputs: 0) number
# Returns: Canon EV code
sub CanonEvInv($)
{
    my $num = shift;
    my $sign;
    # temporarily make the number positive
    if ($num < 0) {
        $num = -$num;
        $sign = -1;
    } else {
        $sign = 1;
    }
    my $val = int($num);
    my $frac = $num - $val;
    if (abs($frac - 0.33) < 0.05) {
        $frac = 0x0c
    } elsif (abs($frac - 0.67) < 0.05) {
        $frac = 0x14;
    } else {
        $frac = int($frac * 0x20 + 0.5);
    }
    return $sign * ($val * 0x20 + $frac);
}

#------------------------------------------------------------------------------
# Write Canon maker notes
# Inputs: 0) ExifTool object reference, 1) dirInfo ref, 2) tag table ref
# Returns: data block (may be empty if no Exif data) or undef on error
sub WriteCanon($$$)
{
    my ($exifTool, $dirInfo, $tagTablePtr) = @_;
    $exifTool or return 1;    # allow dummy access to autoload this package
    my $dirData = Image::ExifTool::Exif::WriteExif($exifTool, $dirInfo, $tagTablePtr);
    # add footer which is written by some Canon models (format of a TIFF header)
    if (defined $dirData and length $dirData and $$dirInfo{Fixup}) {
        $dirData .= GetByteOrder() . Set16u(42) . Set32u(0);
        $dirInfo->{Fixup}->AddFixup(length($dirData) - 4);
    }
    return $dirData;
}

#------------------------------------------------------------------------------
1;  # end

__END__

=head1 NAME

Image::ExifTool::Canon - Canon EXIF maker notes tags

=head1 SYNOPSIS

This module is loaded automatically by Image::ExifTool when required.

=head1 DESCRIPTION

This module contains definitions required by Image::ExifTool to interpret
Canon maker notes in EXIF information.

=head1 AUTHOR

Copyright 2003-2009, Phil Harvey (phil at owl.phy.queensu.ca)

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 REFERENCES

=over 4

=item L<http://park2.wakwak.com/~tsuruzoh/Computer/Digicams/exif-e.html>

=item L<http://www.wonderland.org/crw/>

=item L<http://www.cybercom.net/~dcoffin/dcraw/>

=item L<http://homepage3.nifty.com/kamisaka/makernote/makernote_canon.htm>

=item (...plus lots of testing with my 300D and my daughter's A570IS!)

=back

=head1 ACKNOWLEDGEMENTS

Thanks Michael Rommel and Daniel Pittman for information they provided about
the Digital Ixus and PowerShot S70 cameras, Juha Eskelinen and Emil Sit for
figuring out the 20D and 30D FileNumber, Denny Priebe for figuring out a
couple of 1D tags, and Michael Tiemann, Rainer Honle, Dave Nicholson, Chris
Huebsch, Ger Vermeulen, Darryl Zurn, D.J. Cristi, Bogdan and Vesa Kivisto for
decoding a number of new tags.  Also thanks to everyone who made contributions
to the LensType lookup list or the meanings of other tag values.

=head1 SEE ALSO

L<Image::ExifTool::TagNames/Canon Tags>,
L<Image::ExifTool(3pm)|Image::ExifTool>

=cut
