#------------------------------------------------------------------------------
# File:         de.pm
#
# Description:  ExifTool German language translations
#
# Notes:        This file generated automatically by Image::ExifTool::TagInfoXML
#------------------------------------------------------------------------------

package Image::ExifTool::Lang::de;

use vars qw($VERSION);

$VERSION = '1.07';

%Image::ExifTool::Lang::de::Translate = (
   'AEAperture' => 'AE-Blende',
   'AEBAutoCancel' => {
      Description => 'Automatisches Bracketingende',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AEBBracketValue' => 'AEB-Korrekturwert',
   'AEBSequence' => 'Bracketing-Sequenz',
   'AEBSequenceAutoCancel' => {
      Description => 'WB-Sequenz/autom. Abschaltung',
      PrintConv => {
        '-,0,+/Disabled' => '-,0,+/Aus',
        '-,0,+/Enabled' => '-,0,+/Ein',
        '0,-,+/Disabled' => '0,-,+/Aus',
        '0,-,+/Enabled' => '0,-,+/Ein',
      },
    },
   'AEBShotCount' => 'Anzahl Belichtungsreihenaufnahmen',
   'AEBXv' => 'AEB-Belichtungskorrektur',
   'AEExposureTime' => 'AE-Belichtungszeit',
   'AEExtra' => 'AE-Extra?',
   'AELock' => {
      Description => 'Belichtungsspeicher',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AELockButton' => {
      Description => 'AE-L/AF-L-Taste',
      PrintConv => {
        'AE Lock Hold' => 'Nur Belichtung (halten)',
        'AE Lock Only' => 'Nur Belichtung',
        'AE-L/AF Area' => 'Belichtung & Messfeld',
        'AE-L/AF-L/AF Area' => 'Bel. & Fokus & Messfeld',
        'AE/AF Lock' => 'Belichtung & Fokus',
        'AF Lock Only' => 'Nur Fokus',
        'AF-L/AF Area' => 'Fokus & Messfeld',
        'AF-ON' => 'AF-Aktivierung',
        'AF-ON/AF Area' => 'AF-Aktiv. & Messfeld',
        'FV Lock' => 'FV-Messwertspeicher',
        'Focus Area Selection' => 'AF-Messfeldauswahl',
      },
    },
   'AEMaxAperture' => 'Größte AE-Blende',
   'AEMaxAperture2' => 'Größte AE-Blende (2)',
   'AEMeteringMode' => {
      Description => 'AE Belichtungs-Messmethode',
      PrintConv => {
        'Multi-segment' => 'Multi-Segment',
      },
    },
   'AEMeteringSegments' => 'AE-Messfelder',
   'AEMinAperture' => 'Kleinste AE-Blende',
   'AEMinExposureTime' => 'Kürzeste AE Belichtungszeit',
   'AEProgramMode' => {
      Description => 'AE-Programm-Modus',
      PrintConv => {
        'Av, B or X' => 'Av, B oder X',
        'Candlelight' => 'Kerzenlicht',
        'DOF Program' => 'Schärfentiefe-Priorität',
        'DOF Program (P-Shift)' => 'Schärfentiefe-Priorität (P Shift)',
        'Hi-speed Program' => 'HS-Priorität',
        'Hi-speed Program (P-Shift)' => 'HS-Priorität (P Shift)',
        'Kids' => 'Kinder',
        'Landscape' => 'Landschaft',
        'M, P or TAv' => 'M, P oder TAv',
        'MTF Program' => 'MTF-Priorität',
        'MTF Program (P-Shift)' => 'MTF-Priorität (P Shift)',
        'Macro' => 'Makro',
        'Night Scene' => 'Nachtszene',
        'Night Scene Portrait' => 'Nacht-Porträt',
        'No Flash' => 'Kein Blitz',
        'Pet' => 'Haustier',
        'Portrait' => 'Porträt',
        'Sunset' => 'Sonnenuntergang',
        'Surf & Snow' => 'Surf + Schnee',
        'Sv or Green Mode' => 'Sv oder "Grünes" AE-Programm',
      },
    },
   'AESetting' => {
      Description => 'AE-Einstellung',
      PrintConv => {
        'Exposure Compensation' => 'Belichtungsausgleich',
      },
    },
   'AEXv' => 'AE-Belichtungskorrektur',
   'AE_ISO' => 'AE-ISO-Empfindlichkeit',
   'AF-CPrioritySelection' => {
      Description => 'Priorität bei AF-C',
      PrintConv => {
        'Focus' => 'Schärfepriorität',
        'Release' => 'Auslösepriorität',
        'Release + Focus' => 'Auslösepriorität & AF',
      },
    },
   'AF-OnForMB-D10' => {
      Description => 'AF-ON-Taste (MB-D10)',
      PrintConv => {
        'AE Lock (hold)' => 'Belichtung speichern ein/aus',
        'AE Lock (reset on release)' => 'Bel. speichern ein/aus (Reset)',
        'AE Lock Only' => 'Belichtung speichern',
        'AE/AF Lock' => 'Belichtung & Fokus speichern',
        'AF Lock Only' => 'Fokus speichern',
        'AF-On' => 'Autofokus aktiviert',
        'Same as FUNC Button' => 'Wie Funktionstaste',
      },
    },
   'AF-SPrioritySelection' => {
      Description => 'Priorität bei AF-S (Einzel-AF)',
      PrintConv => {
        'Focus' => 'Schärfepriorität',
        'Release' => 'Auslösepriorität',
      },
    },
   'AFActivation' => {
      Description => 'AF-Aktivierung',
      PrintConv => {
        'AF-On Only' => 'Nur AF-ON-Taste',
        'Shutter/AF-On' => 'AF-On-Taste & Auslöser',
      },
    },
   'AFAdjustment' => 'AF-Verstellung',
   'AFAreaHeight' => 'AF-Bereichshöhe',
   'AFAreaHeights' => 'AF-Bereichshöhe',
   'AFAreaIllumination' => {
      Description => 'Messfeld-LED',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AFAreaMode' => {
      Description => 'Messfeldsteuerung',
      PrintConv => {
        'Auto-area AF' => 'Autom. Messfeldgr.',
        'Dynamic Area' => 'Dynamisch',
        'Single Area' => 'Einzelfeld',
      },
    },
   'AFAreaModeSetting' => {
      Description => 'Messfeldsteuerung',
      PrintConv => {
        'Closest Subject' => 'Nächstes Objekt',
        'Dynamic Area' => 'Dynamisch',
        'Single Area' => 'Einzelfeld',
      },
    },
   'AFAreaWidth' => 'AF-Bereichsbreite',
   'AFAreaWidths' => 'AF-Bereichsbreite',
   'AFAssist' => {
      Description => 'AF-Hilfslicht',
      PrintConv => {
        'Does not emit/Fires' => 'Kein Messlicht/Zündung',
        'Emits/Does not fire' => 'Messlicht/keine Zündung',
        'Emits/Fires' => 'Messlicht/Zündung',
        'Off' => 'Aus',
        'On' => 'Ein',
        'Only ext. flash emits/Fires' => 'Nur ext. Messl./Zündung',
      },
    },
   'AFAssistBeam' => {
      Description => 'AF-Hilfslicht Aussendung',
      PrintConv => {
        'Does not emit' => 'Deaktiv',
        'Emits' => 'Aktiv',
        'Only ext. flash emits' => 'Nur bei ext. Blitz aktiv',
      },
    },
   'AFAssistIlluminator' => {
      Description => 'Integriertes AF-Hilfslicht',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AFDefocus' => 'AF-Defocus',
   'AFDuringLiveView' => {
      Description => 'AF bei Live View-Aufnahmen',
      PrintConv => {
        'Disable' => 'Inaktiv',
        'Enable' => 'Aktiv',
        'Live mode' => 'LiveModus',
        'Quick mode' => 'QuickModus',
      },
    },
   'AFFineTuneAdj' => 'AF-Feinabstimmung',
   'AFImageHeight' => 'AF-Bildhöhe',
   'AFImageWidth' => 'AF-Bildbreite',
   'AFIntegrationTime' => 'AF-Messzeit',
   'AFMicroAdjActive' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'AFMicroadjustment' => {
      Description => 'AFFeinabstimmung',
      PrintConv => {
        'Adjust all by same amount' => 'Alle auf gleichen Wert',
        'Adjust by lens' => 'Abstimmung pro Objektiv',
        'Disable' => 'Deaktivieren',
      },
    },
   'AFMode' => {
      Description => 'AF-Modus',
      PrintConv => {
        'Face Detect AF' => 'Gesichtserk',
      },
    },
   'AFOnAELockButtonSwitch' => {
      Description => 'AF-ON/AELocktaste- Schalter',
      PrintConv => {
        'Disable' => 'Deaktiviert',
        'Enable' => 'Aktiviert',
      },
    },
   'AFPoint' => {
      Description => 'Gewählter AF-Punkt',
      PrintConv => {
        'Bottom' => 'Unten',
        'Center' => 'Mitte',
        'Far Left' => 'Ganz links',
        'Far Right' => 'Ganz rechts',
        'Left' => 'Links',
        'Lower-left' => 'Unten-Links',
        'Lower-right' => 'Unten-Rechts',
        'None' => 'Keine',
        'Right' => 'Rechts',
        'Top' => 'Oben',
        'Upper-left' => 'Oben-Links',
        'Upper-right' => 'Oben-Rechts',
      },
    },
   'AFPointActivationArea' => 'AF-Messfeld-Aktivierungsbereich',
   'AFPointAreaExpansion' => {
      Description => 'AF-Messbereich Ausweitung',
      PrintConv => {
        'Disable' => 'Aus',
        'Enable' => 'An',
        'Enable (left/right assist points)' => 'Möglich (linkes/rechtes zusätzliches AF-Messfeld)',
        'Enable (surrounding assist points)' => 'Möglich (entsprechendes zusätzliches AF-Messfeld)',
      },
    },
   'AFPointAutoSelection' => {
      Description => 'Automatische AF-Feldwahl',
      PrintConv => {
        'Control-direct:disable/Main:disable' => 'Schnelleinstellrad-Direkt:nicht möglich/Haupt-Wahlrad:nein',
        'Control-direct:disable/Main:enable' => 'Schnelleinstellrad-Direkt:nicht möglich/Haupt-Wahlrad:möglich',
        'Control-direct:enable/Main:enable' => 'Schnelleinstellrad-Direkt:möglich/Haupt-Wahlrad:möglich',
      },
    },
   'AFPointBrightness' => {
      Description => 'AF-Feld Helligkeit',
      PrintConv => {
        'Brighter' => 'Heller',
      },
    },
   'AFPointDisplayDuringFocus' => {
      Description => 'AF-Feld Anzeige während Fokus',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
        'On (when focus achieved)' => 'Ein (nach Scharfeinstellung)',
      },
    },
   'AFPointIllumination' => {
      Description => 'Messfeld-LED',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AFPointMode' => {
      Description => 'AF-Punkt-Modus',
      PrintConv => {
        'Auto' => 'Automatisch',
      },
    },
   'AFPointRegistration' => {
      Description => 'AF-Feld Speicherung',
      PrintConv => {
        'Automatic' => 'Automatisch',
        'Bottom' => 'Unten',
        'Center' => 'Mitte',
        'Extreme Left' => 'Ganz links',
        'Extreme Right' => 'Ganz rechts',
        'Left' => 'Links',
        'Right' => 'Rechts',
        'Top' => 'Oben',
      },
    },
   'AFPointSelected' => {
      Description => 'Gewählter AF-Punkt',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Automatic Tracking AF' => 'Nachführ AF',
        'Bottom' => 'Unten',
        'Center' => 'Mitte',
        'Face Recognition AF' => 'Gesichtserkennungs-AF',
        'Fixed Center' => 'Auf Mitte fixiert',
        'Left' => 'Links',
        'Lower-left' => 'Unten-links',
        'Lower-right' => 'Unten-rechts',
        'Mid-left' => 'Links-Mitte',
        'Mid-right' => 'Rechts-Mitte',
        'Right' => 'Rechts',
        'Top' => 'Oben',
        'Upper-left' => 'Oben-links',
        'Upper-right' => 'Oben-rechts',
      },
    },
   'AFPointSelected2' => {
      Description => 'Gewählter AF-Punkt 2',
      PrintConv => {
        'Auto' => 'Automatisch',
      },
    },
   'AFPointSelection' => {
      Description => 'AF-Messfeldauswahl',
      PrintConv => {
        '11 Points' => '11 Messfelder',
        '51 Points' => '51 Messfelder (3D-Tracking)',
      },
    },
   'AFPointSelectionMethod' => {
      Description => 'Wahlmethode für AF-Messfeld',
      PrintConv => {
        'Multi-controller direct' => 'Multicontroller',
        'Quick Control Dial direct' => 'Schnelleinstellrad',
      },
    },
   'AFPointSpotMetering' => 'Anzahl AF-Messff./Spotmsg.',
   'AFPoints' => 'AF-Punkte',
   'AFPointsInFocus' => {
      Description => 'AF-Punkte im Fokus',
      PrintConv => {
        'Bottom' => 'Unten',
        'Bottom, Center' => 'Unten + Mitte',
        'Bottom-center' => 'Unten-Mitte',
        'Bottom-left' => 'Unten-links',
        'Bottom-right' => 'Unten-rechts',
        'Center' => 'Mitte',
        'Center (horizontal)' => 'Mitte (horizontal)',
        'Center (vertical)' => 'Mitte (vertikal)',
        'Fixed Center or Multiple' => 'Auf Mitte fixiert oder mehrere',
        'Left' => 'Links',
        'Lower-left, Bottom' => 'Unten-links + Unten',
        'Lower-left, Mid-left' => 'Unten-links + Links-Mitte',
        'Lower-right, Bottom' => 'Unten-rechts + Unten',
        'Lower-right, Mid-right' => 'Unten-rechts + Rechts-Mitte',
        'Mid-left' => 'Links-Mitte',
        'Mid-left, Center' => 'Links-Mitte + Mitte',
        'Mid-right' => 'Rechts-Mitte',
        'Mid-right, Center' => 'Rechts-Mitte + Mitte',
        'None' => 'Keiner',
        'Right' => 'Rechts',
        'Top' => 'Oben',
        'Top, Center' => 'Oben + Mitte',
        'Top-center' => 'Oben-Mitte',
        'Top-left' => 'Oben-links',
        'Top-right' => 'Oben-rechts',
        'Upper-left, Mid-left' => 'Oben-links + Links-mitte',
        'Upper-left, Top' => 'Oben-links + Oben',
        'Upper-right, Mid-right' => 'Oben-rechts + Rechts-Mitte',
        'Upper-right, Top' => 'Oben-rechts + Oben',
      },
    },
   'AFPointsInFocus1D' => 'AF-Punkte im Fokus 1D',
   'AFPointsInFocus5D' => 'AF-Punkte im Fokus',
   'AFPointsSelected' => 'Gewählte AF-Punkte',
   'AFPointsUnknown1' => {
      PrintConv => {
        'All' => 'Alle',
        'Central 9 points' => 'Alle mittleren 9 Punkte',
      },
    },
   'AFPointsUnknown2' => {
      Description => 'AF-Punkte Unbekannt 2?',
      PrintConv => {
        'Auto' => 'Automatisch',
      },
    },
   'AFPredictor' => 'AF-Prädiktor',
   'AFResponse' => 'Verwendeter AF',
   'AIServoContinuousShooting' => 'Auslösepriorität',
   'AIServoImagePriority' => {
      Description => 'AI Servo Priorität 1./2. Bild',
      PrintConv => {
        '1: AF, 2: Drive speed' => 'AF-Priorität/Transportgeschwindigkeit',
        '1: AF, 2: Tracking' => 'AF-Priorität/Nachführpriorität',
        '1: Release, 2: Drive speed' => 'Auslösung/Transportgeschwindigkeit',
      },
    },
   'AIServoTrackingMethod' => {
      Description => 'AI Servo AF Nachführung',
      PrintConv => {
        'Continuous AF track priority' => 'AF Nachführ-Priorität',
        'Main focus point priority' => 'Hauptfokussierungsfeld',
      },
    },
   'AIServoTrackingSensitivity' => {
      Description => 'AI Servo Empfindlichkeit',
      PrintConv => {
        'Fast' => 'Rapide',
        'Slow' => '[Langsam]',
      },
    },
   'APEVersion' => 'APE-Version',
   'ARMVersion' => 'ARM-Version',
   'ActionAdvised' => 'Aktion empfohlen',
   'ActiveArea' => 'Aktiver Bereich',
   'ActiveD-Lighting' => {
      PrintConv => {
        'High' => 'Hoch',
        'Low' => 'Leicht',
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ActiveD-LightingMode' => {
      PrintConv => {
        'High' => 'Hoch',
        'Low' => 'Leicht',
        'Off' => 'Aus',
      },
    },
   'AddAspectRatioInfo' => {
      Description => 'Seitenverhältnisinfo zufügen',
      PrintConv => {
        'Off' => 'Aus',
      },
    },
   'AddOriginalDecisionData' => {
      Description => 'Originaldaten zufügen',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AdultContentWarning' => {
      PrintConv => {
        'Unknown' => 'Unbekannt',
      },
    },
   'AdvancedRaw' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AlphaByteCount' => 'Anzahl Bytes der Alpha-Kanal-Daten',
   'AlphaDataDiscard' => {
      Description => 'Verworfene Alpha-Kanal-Daten',
      PrintConv => {
        'Flexbits Discarded' => 'FlexBits verworfen',
        'Full Resolution' => 'Volle Auflösung',
        'HighPass Frequency Data Discarded' => 'Hochpass-Frequenz-Daten verworfen',
        'Highpass and LowPass Frequency Data Discarded' => 'Hochpass- und Tiefpass-Frequenz-Daten verworfen',
      },
    },
   'AlphaOffset' => 'Alpha-Kanal-Datenposition',
   'AnalogBalance' => 'Analog-Balance',
   'Anti-Blur' => {
      Description => 'Verwacklungsschutz-Modus',
      PrintConv => {
        'Off' => 'Aus',
        'On (Continuous)' => 'Ein (Kontinuierlich)',
        'On (Shooting)' => 'Ein (Aufnahme)',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'Aperture' => 'F-Wert',
   'ApertureRange' => {
      Description => 'Einstellung Verschlusszeitenbereich',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'ApertureRingUse' => {
      Description => 'Blendenring-Verwendung',
      PrintConv => {
        'Permitted' => 'Erlaubt',
        'Prohibited' => 'Nicht erlaubt',
      },
    },
   'ApertureValue' => 'Blende',
   'ApplicationRecordVersion' => 'IPTC-Modell-2-Version',
   'ApplyShootingMeteringMode' => {
      Description => 'Angewandter Belichtungs-/Messmodus',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'Artist' => 'Ersteller des Bildes',
   'AssignFuncButton' => {
      Description => 'FUNC.-Taste zuordnen',
      PrintConv => {
        'Exposure comp./AEB setting' => 'Belichtungskorrektur/AEB-Einstellung',
        'Image jump with main dial' => 'Bildsprung mit Haupt-Wahlrad',
        'Image quality' => 'Qualität ändern',
        'LCD brightness' => 'LCD-Helligkeit',
        'Live view function settings' => 'Livebild Funktionseinstellung',
      },
    },
   'AssistButtonFunction' => {
      Description => 'Funktion Assist-Taste',
      PrintConv => {
        'Av+/- (AF point by QCD)' => 'Av+/- (AF-Feld mit Daumenrad)',
        'FE lock' => 'FE Blitzmesswertspeicherung',
        'Select HP (while pressing)' => 'Ausw.G.pos.(Ass-Taste gedr.)',
        'Select Home Position' => 'Auswahl Grundposition',
      },
    },
   'Audio' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'AudioDuration' => 'Audiodauer',
   'AudioOutcue' => 'Audio-Outcue',
   'AudioSamplingRate' => 'Audio-Samplingrate',
   'AudioSamplingResolution' => 'Audio-Samplingauflösung',
   'AudioType' => 'Audiotyp',
   'Author' => 'Autor',
   'AutoAperture' => {
      Description => 'Blendenring auf A',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AutoBracketModeM' => {
      Description => 'Belichtungsreihen bei M',
      PrintConv => {
        'Flash Only' => 'Nur Blitz',
        'Flash/Aperture' => 'Blitz & Blende',
        'Flash/Speed' => 'Blitz & Zeit',
        'Flash/Speed/Aperture' => 'Blitz, Zeit & Blende',
      },
    },
   'AutoBracketOrder' => 'BKT-Reihenfolge',
   'AutoBracketRelease' => {
      Description => 'Belichtungsreihen-Auslösung',
      PrintConv => {
        'Auto Release' => 'Automatisches Auslösen (Fortlaufend)',
        'Manual Release' => 'Manuelles Auslösen (Einzelbild)',
        'None' => 'Keine',
      },
    },
   'AutoBracketSet' => {
      Description => 'Belichtungsreihen',
      PrintConv => {
        'AE & Flash' => 'Belichtung & Blitz',
        'AE Only' => 'Nur Belichtung',
        'Flash Only' => 'Nur Blitz',
        'WB Bracketing' => 'Weißabgleichsreihe',
      },
    },
   'AutoBracketing' => {
      Description => 'Automatische Belichtungsreihe',
      PrintConv => {
        'No flash & flash' => 'Kein Blitz & Blitz',
        'Off' => 'Aus',
        'On' => 'An',
      },
    },
   'AutoExposureBracketing' => {
      Description => 'Auto-Belichtungsreihe',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AutoFP' => {
      Description => 'FP-Kurzzeitsynchr.',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AutoFocus' => {
      Description => 'Auto-Fokus',
      PrintConv => {
        'Off' => 'Deaktiviert',
        'On' => 'Aktiviert',
      },
    },
   'AutoISO' => {
      Description => 'ISO-Automatik',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AutoISOMax' => 'ISO-Automatik Max',
   'AutoISOMinShutterSpeed' => 'ISO-Automatik Längste Belichtungszeit',
   'AutoLightingOptimizer' => {
      Description => 'Autom. Belichtungsoptimierung',
      PrintConv => {
        'Disable' => 'Inaktiv',
        'Enable' => 'Aktiv',
        'Low' => 'Gering',
        'Off' => 'Aus',
        'Strong' => 'Stark',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'AutoLightingOptimizerOn' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'AutoRedEye' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'AutoRotate' => {
      Description => 'Automatische Bilddrehung',
      PrintConv => {
        'None' => 'Keine',
        'Rotate 180' => '180° (unten/rechts)',
        'Rotate 270 CW' => '90° im Uhrzeigersinn (links/unten)',
        'Rotate 90 CW' => '90° gegen den Uhrzeigersinn (rechts/oben)',
        'Unknown' => 'Unbekannt',
      },
    },
   'AuxiliaryLens' => 'Vorsatzlinse',
   'AvApertureSetting' => 'Av Blenden-Einstellung',
   'AvSettingWithoutLens' => {
      Description => 'Blendeneinstellung ohne Objektiv',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'BWFilter' => 'S/W-Filter',
   'BWMode' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'An',
      },
    },
   'BackgroundTiling' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'BannerImageType' => {
      PrintConv => {
        'None' => 'Keine',
      },
    },
   'BaseExposureCompensation' => 'Basis-Belichtungskorrektur',
   'BaseISO' => 'Basis-ISO',
   'BatteryADBodyLoad' => 'Kamerabatterie A/D unter Last',
   'BatteryADBodyNoLoad' => 'Kamerabatterie A/D im Leerlauf',
   'BatteryADGripLoad' => 'Griffbatterie A/D unter Last',
   'BatteryADGripNoLoad' => 'Griffbatterie A/D im Leerlauf',
   'BatteryLevel' => 'Batteriestatus',
   'BatteryOrder' => {
      Description => 'Akkureihenfolge',
      PrintConv => {
        'Camera Battery First' => 'Zuerst Akku in der Kamera',
        'MB-D10 First' => 'Zuerst Akkus im MB-D10',
      },
    },
   'BatteryStates' => {
      Description => 'Batterie-Status',
      PrintConv => {
        'Body Battery Almost Empty' => 'Kamerabatterie ist fast leer',
        'Body Battery Empty or Missing' => 'Kamerabatterie ist leer oder nicht vorhanden',
        'Body Battery Full' => 'Kamerabatterie ist voll geladen',
        'Body Battery Running Low' => 'Kamerabatterie ist schwach',
        'Grip Battery Almost Empty' => 'Griffbatterie ist fast leer',
        'Grip Battery Empty or Missing' => 'Griffbatterie ist leer oder nicht vorhanden',
        'Grip Battery Full' => 'Griffbatterie ist voll geladen',
        'Grip Battery Running Low' => 'Griffbatterie ist schwach',
      },
    },
   'Beep' => {
      Description => 'Tonsignal',
      PrintConv => {
        'High' => 'Hoch',
        'Low' => 'Tief',
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'BitDepth' => 'Bit-Tiefe',
   'BitsPerSample' => 'Anzahl der Bits pro Komponente',
   'BlackPoint' => 'Schwarzpunkt',
   'BlueBalance' => 'Blau-Balance',
   'BlueMatrixColumn' => 'Blau-Matrixspalte',
   'BlueTRC' => 'Blau-Tonwertwiedergabe-Kurve',
   'BlurWarning' => {
      Description => 'Verwackelungswarnung',
      PrintConv => {
        'Blur Warning' => 'Verwackelungswarnung',
        'None' => 'Keine',
      },
    },
   'BodyFirmwareVersion' => 'Kamera-Firmware-Version',
   'BracketMode' => {
      Description => 'Belichtungsreihen-Modus',
      PrintConv => {
        'Off' => 'Aus',
      },
    },
   'BracketShotNumber' => {
      Description => 'Belichtungsreihen-Bildnummer',
      PrintConv => {
        '1 of 3' => '1 von 3',
        '1 of 5' => '1 von 5',
        '2 of 3' => '2 von 3',
        '2 of 5' => '2 von 5',
        '3 of 3' => '3 von 3',
        '3 of 5' => '3 von 5',
        '4 of 5' => '4 von 5',
        '5 of 5' => '5 von 5',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'BracketStep' => {
      Description => 'Belichtungsreihenschritte',
      PrintConv => {
        '1 EV' => '1 LW',
        '1/3 EV' => '1/3 LW',
        '2/3 EV' => '2/3 LW',
      },
    },
   'BracketValue' => 'Belichtungsreihen-Wert',
   'Brightness' => 'Helligkeit',
   'BrightnessValue' => 'Helligkeit',
   'BulbDuration' => 'Bulb-Dauer',
   'BurstMode' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ButtonFunctionControlOff' => {
      Description => 'Tastenfunktion wenn Schnelleinstellrad OFF',
      PrintConv => {
        'Disable main, Control, Multi-control' => 'Deaktiv Haupt-Wahlrad, Schnelleinstellrad, Multicontroller',
        'Normal (enable)' => 'Normal (eingeschaltet)',
      },
    },
   'By-line' => 'Ersteller',
   'By-lineTitle' => 'Beruf des Erstellers',
   'CFAPattern' => 'Farbfiltermatrix',
   'CFAPattern2' => 'Farbfiltermatrix 2',
   'CFARepeatPatternDim' => 'Farbfiltermatrix-Größe',
   'CLModeShootingSpeed' => 'Lowspeed-Bildrate',
   'CMMFlags' => 'CMM-Flags',
   'CPUFirmwareVersion' => 'CPU-Firmware-Version',
   'CPUType' => {
      PrintConv => {
        'None' => 'Keine',
      },
    },
   'CalibrationIlluminant1' => {
      Description => 'Lichtquellenkalibrierung 1',
      PrintConv => {
        'Cloudy' => 'Bewölkt',
        'Cool White Fluorescent' => 'Kühle weiße Leuchtstofflampe',
        'Day White Fluorescent' => 'Tageslicht-Weiß Leuchtstofflampe',
        'Daylight' => 'Tageslicht',
        'Daylight Fluorescent' => 'Tageslicht-Leuchtstofflampe',
        'Fine Weather' => 'Unbewölkt',
        'Flash' => 'Blitz',
        'Fluorescent' => 'Fluoreszierend',
        'ISO Studio Tungsten' => 'ISO Studio-Kunstlicht (Glühbirne)',
        'Other' => 'Andere Lichtquelle',
        'Shade' => 'Schatten',
        'Standard Light A' => 'Standard-Licht A',
        'Standard Light B' => 'Standard-Licht B',
        'Standard Light C' => 'Standard-Licht C',
        'Tungsten' => 'Kunstlicht (Glühbirne)',
        'Unknown' => 'Unbekannt',
        'White Fluorescent' => 'Warme weiße Leuchtstofflampe',
      },
    },
   'CalibrationIlluminant2' => {
      Description => 'Lichtquellenkalibrierung 2',
      PrintConv => {
        'Cloudy' => 'Bewölkt',
        'Cool White Fluorescent' => 'Kühle weiße Leuchtstofflampe',
        'Day White Fluorescent' => 'Tageslicht-Weiß Leuchtstofflampe',
        'Daylight' => 'Tageslicht',
        'Daylight Fluorescent' => 'Tageslicht-Leuchtstofflampe',
        'Fine Weather' => 'Unbewölkt',
        'Flash' => 'Blitz',
        'Fluorescent' => 'Fluoreszierend',
        'ISO Studio Tungsten' => 'ISO Studio-Kunstlicht (Glühbirne)',
        'Other' => 'Andere Lichtquelle',
        'Shade' => 'Schatten',
        'Standard Light A' => 'Standard-Licht A',
        'Standard Light B' => 'Standard-Licht B',
        'Standard Light C' => 'Standard-Licht C',
        'Tungsten' => 'Kunstlicht (Glühbirne)',
        'Unknown' => 'Unbekannt',
        'White Fluorescent' => 'Warme weiße Leuchtstofflampe',
      },
    },
   'CameraCalibration1' => 'Kamerakalibrierung 1',
   'CameraCalibration2' => 'Kamerakalibrierung 2',
   'CameraISO' => 'Kamera-ISO',
   'CameraOrientation' => {
      Description => 'Ausrichtung des Bildes',
      PrintConv => {
        'Horizontal (normal)' => '0° (oben/links)',
        'Rotate 270 CW' => '90° im Uhrzeigersinn (links/unten)',
        'Rotate 90 CW' => '90° gegen den Uhrzeigersinn (rechts/oben)',
      },
    },
   'CameraSerialNumber' => 'Kamera-Seriennummer',
   'CameraSettingsVersion' => 'Kameraeinstellungen-Version',
   'CameraTemperature' => 'Kamera-Temperatur',
   'CameraType' => 'Kameratyp',
   'CameraType2' => 'Kameratyp 2',
   'CanonExposureMode' => {
      Description => 'Belichtungsmodus',
      PrintConv => {
        'Aperture-priority AE' => 'Blendenpriorität',
        'Bulb' => 'Bulb-Modus',
        'Manual' => 'Manuell',
        'Program AE' => 'Programmautomatik',
        'Shutter speed priority AE' => 'Verschlusspriorität',
      },
    },
   'CanonFileLength' => 'Dateilänge',
   'CanonFirmwareVersion' => 'Firmware-Version',
   'CanonFlashMode' => {
      Description => 'Blitz-Modus',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Off' => 'Aus',
        'On' => 'Ein',
        'Red-eye reduction' => 'Rote-Augen-Reduzierung',
      },
    },
   'CanonImageHeight' => 'Canon-Bildhöhe',
   'CanonImageSize' => {
      Description => 'Canon-Bildgröße',
      PrintConv => {
        'Large' => 'Groß',
        'Medium' => 'Mittelgroß',
        'Medium 1' => 'Mittelgroß 1',
        'Medium 2' => 'Mittelgroß 2',
        'Medium 3' => 'Mittelgroß 3',
        'Medium Movie' => 'Mittelgroßer Film',
        'Postcard' => 'Postkarte',
        'Small' => 'Klein',
        'Small Movie' => 'Kleiner Film',
        'Widescreen' => 'Breitbild',
      },
    },
   'CanonImageType' => 'Canon-Bildtyp',
   'CanonImageWidth' => 'Canon-Bildbreite',
   'CanonModelID' => 'Canon-Modell',
   'Caption-Abstract' => 'Beschreibung/Zusammenfassung',
   'CaptureXResolutionUnit' => {
      PrintConv => {
        'um' => 'µm (Mikrometer)',
      },
    },
   'CaptureYResolutionUnit' => {
      PrintConv => {
        'um' => 'µm (Mikrometer)',
      },
    },
   'Categories' => 'Kategorien',
   'Category' => 'Kategorie',
   'CenterAFArea' => {
      Description => 'AF-Messfeldgröße',
      PrintConv => {
        'Normal Zone' => 'Normal',
        'Wide Zone' => 'Groß',
      },
    },
   'CenterWeightedAreaSize' => {
      Description => 'Messfeldgröße',
      PrintConv => {
        'Average' => 'Durchschnitt',
      },
    },
   'ChrominanceNR_TIFF_JPEG' => {
      PrintConv => {
        'High' => 'Hoch',
        'Low' => 'Leicht',
        'Off' => 'Aus',
      },
    },
   'ChrominanceNoiseReduction' => {
      PrintConv => {
        'High' => 'Hoch',
        'Low' => 'Leicht',
        'Off' => 'Aus',
      },
    },
   'City' => 'Stadt/Ort',
   'ClassifyState' => 'Klassifizierungs-Status',
   'ColorAberrationControl' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ColorAdjustmentMode' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ColorBalance1' => 'Farbabgleich 1',
   'ColorBalanceAdj' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ColorBalanceBlue' => 'Farbbalance Blau',
   'ColorBalanceGreen' => 'Farbbalance Grün',
   'ColorBalanceRed' => 'Farbbalance Rot',
   'ColorBooster' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ColorComponents' => 'Anzahl der Bildkomponenten',
   'ColorEffect' => {
      PrintConv => {
        'Black & White' => 'Schwarz/Weiß',
        'Off' => 'Aus',
      },
    },
   'ColorFilter' => {
      Description => 'Farbfilter',
      PrintConv => {
        'Black & White' => 'Schwarz/Weiß',
        'Blue' => 'Blau',
        'Green' => 'Grün',
        'Off' => 'Aus',
        'Purple' => 'Lila',
        'Red' => 'Rot',
        'Yellow' => 'Gelb',
      },
    },
   'ColorHue' => 'Farbwiedergabe',
   'ColorMatrix1' => 'Farbmatrix 1',
   'ColorMatrix2' => 'Farbmatrix 2',
   'ColorMode' => {
      Description => 'Farbmodus',
      PrintConv => {
        'Autumn Leaves' => 'Herbstlaub',
        'B & W' => 'S/W',
        'B&W' => 'Schwarz-Weiß',
        'Black & White' => 'Schwarz/Weiß',
        'Black&white' => 'Schwarz/Weiß',
        'Clear' => 'Klar',
        'Deep' => 'Tief',
        'Evening' => 'Abends',
        'Landscape' => 'Landschaft',
        'Light' => 'Hell',
        'Natural' => 'Natürlich',
        'Natural color' => 'Natürliche Farben',
        'Natural sRGB' => 'Neutral sRGB',
        'Natural+ sRGB' => 'Neutral+ sRGB',
        'Night Portrait' => 'Nachtporträt',
        'Night Scene' => 'Nachtszene',
        'Night View' => 'Abendszene',
        'Off' => 'Aus',
        'Portrait' => 'Porträt',
        'Solarization' => 'Solarisation',
        'Sunset' => 'Sonnenuntergang',
        'Vivid' => 'Lebhafte Farbe',
        'Vivid color' => 'Lebhafte Farbe',
      },
    },
   'ColorMoireReduction' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ColorMoireReductionMode' => {
      PrintConv => {
        'High' => 'Hoch',
        'Low' => 'Leicht',
        'Off' => 'Aus',
      },
    },
   'ColorProfile' => {
      Description => 'Farbprofil',
      PrintConv => {
        'Embedded' => 'Eingebunden',
        'Not Embedded' => 'Nicht eingebunden',
      },
    },
   'ColorReproduction' => 'Farbreproduktion',
   'ColorSpace' => {
      Description => 'Farbraum',
      PrintConv => {
        'Monochrome' => 'Monochrom',
        'Natural sRGB' => 'Neutral sRGB',
        'Natural+ sRGB' => 'Neutral+ sRGB',
        'Uncalibrated' => 'Nicht festgelegt',
      },
    },
   'ColorSpaceData' => 'Daten-Farbraum',
   'ColorTemperature' => 'Farbtemperatur',
   'ColorTone' => {
      Description => 'Farbton',
      PrintConv => {
        'Normal' => 'Standard',
      },
    },
   'ColorimetricReference' => 'Farbmetrische Referenz',
   'CommandDials' => {
      Description => 'Einstellräder',
      PrintConv => {
        'Reversed (Main Aperture, Sub Shutter)' => 'Vertauscht',
        'Standard (Main Shutter, Sub Aperture)' => 'Standard',
      },
    },
   'CommandDialsApertureSetting' => {
      Description => 'Einstellräder Blendeneinstellung',
      PrintConv => {
        'Aperture Ring' => 'Mit Blendenring',
        'Sub-command Dial' => 'Mit Einstellrad',
      },
    },
   'CommandDialsChangeMainSub' => {
      Description => 'Einstellräder Funktionsbelegung',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'CommandDialsMenuAndPlayback' => {
      Description => 'Einstellräder Menüs und Wiedergabe',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'CommandDialsReverseRotation' => {
      Description => 'Einstellräder Auswahlrichtung',
      PrintConv => {
        'No' => 'Standard',
        'Yes' => 'Umgekehrt',
      },
    },
   'CommanderChannel' => 'Master-Steuerung > Kanal',
   'CommanderGroupAMode' => {
      Description => 'Master-Steuerung Gruppe A Modus',
      PrintConv => {
        'Manual' => 'Manuell',
        'Off' => 'Aus',
      },
    },
   'CommanderGroupA_ManualOutput' => 'Master-Steuerung Gruppe A M Korr',
   'CommanderGroupA_TTL-AAComp' => 'Master-Steuerung Gruppe A TTL/AA Korr',
   'CommanderGroupBMode' => {
      Description => 'Master-Steuerung Gruppe B Modus',
      PrintConv => {
        'Manual' => 'Manuell',
        'Off' => 'Aus',
      },
    },
   'CommanderGroupB_ManualOutput' => 'Master-Steuerung Gruppe B M Korr',
   'CommanderGroupB_TTL-AAComp' => 'Master-Steuerung Gruppe B TTL/AA Korr',
   'CommanderInternalFlash' => {
      Description => 'Master-Steuerung Intgr. Blitz Modus',
      PrintConv => {
        'Manual' => 'Manuell',
        'Off' => 'Aus',
      },
    },
   'CommanderInternalManualOutput' => 'Master-Steuerung Intgr. Blitz M Korr',
   'CommanderInternalTTLComp' => 'Master-Steuerung Intgr. Blitz TTL Korr',
   'Comment' => 'Kommentar',
   'Comments' => 'Kommentare',
   'Compilation' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'ComponentsConfiguration' => 'Bedeutung jeder Komponente',
   'CompressedBitsPerPixel' => 'Bildkomprimierungsmodus',
   'Compression' => {
      Description => 'Komprimierungsschema',
      PrintConv => {
        'Epson ERF Compressed' => 'Epson ERF-komprimiert',
        'JPEG (old-style)' => 'JPEG (alte Version)',
        'Kodak DCR Compressed' => 'Kodak DCR-komprimiert',
        'Kodak KDC Compressed' => 'Kodak KDC-komprimiert',
        'Next' => 'NeXT 2-Bit Kodierung',
        'Nikon NEF Compressed' => 'Nikon NEF-komprimiert',
        'None' => 'Keine',
        'Pentax PEF Compressed' => 'Pentax PEF-komprimiert',
        'SGILog' => 'SGI 32-Bit Log Luminance Kodierung',
        'SGILog24' => 'SGI 24-Bit Log Luminance Kodierung',
        'Sony ARW Compressed' => 'Sony ARW-komprimiert',
        'Thunderscan' => 'ThunderScan 4-Bit Kodierung',
        'Uncompressed' => 'Nicht komprimiert',
      },
    },
   'CompressionType' => {
      PrintConv => {
        'None' => 'Keine',
      },
    },
   'ConditionalFEC' => 'Blitzbelichtungsausgleich',
   'ConnectionSpaceIlluminant' => 'Weißpunkt des Verbindungsfarbraums',
   'Contact' => 'Kontakt',
   'ContentLocationCode' => 'Inhaltspositionscode',
   'ContentLocationName' => 'Inhaltspositionsname',
   'ContinuousDrive' => {
      Description => 'Aufnahme-Modus',
      PrintConv => {
        'Continuous' => 'Serienaufnahme',
        'Movie' => 'Filmen',
      },
    },
   'ContinuousShootingSpeed' => {
      Description => 'Geschwindigkeit Reihenaufnahmen',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'ContinuousShotLimit' => {
      Description => 'Limit Anzahl Reihenaufnahmen',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'Contrast' => {
      Description => 'Kontrast',
      PrintConv => {
        'Film Simulation' => 'Film-Simulation',
        'High' => 'Stark',
        'Low' => 'Leicht',
        'Med High' => 'Leicht erhöht',
        'Med Low' => 'Leicht verringert',
        'Medium High' => 'Mittel-Hoch',
        'Medium Low' => 'Mittel-Gering',
        'Normal' => 'Standard',
        'Very High' => 'Sehr hoch',
        'Very Low' => 'Sehr gering',
      },
    },
   'ContrastCurve' => 'Kontrast-Kurve',
   'ControlMode' => {
      Description => 'Steuerungsmethode',
      PrintConv => {
        'n/a' => 'Nicht gesetzt',
      },
    },
   'ConversionLens' => {
      PrintConv => {
        'Macro' => 'Makro',
        'Off' => 'Aus',
      },
    },
   'Converter' => 'Konverter',
   'Copyright' => 'Urheberrechtsinhaber',
   'CopyrightNotice' => 'Urheberrechtsvermerk',
   'CopyrightStatus' => {
      PrintConv => {
        'Unknown' => 'Unbekannt',
      },
    },
   'Country-PrimaryLocationCode' => 'ISO-Landescode',
   'Country-PrimaryLocationName' => 'Land',
   'CreateDate' => 'Datum der Digitaldatengenerierung',
   'Creator' => 'Ersteller',
   'Credit' => 'Anbieter',
   'CropActive' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'CropHiSpeed' => 'Highspeed-Bildformat',
   'Curves' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'CustomRendered' => {
      Description => 'Benutzerdefinierte Bildverarbeitung',
      PrintConv => {
        'Custom' => 'Benutzerdefinierter Prozess',
        'Normal' => 'Standard-Prozess',
      },
    },
   'D-LightingHQ' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'D-LightingHQSelected' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'D-LightingHS' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'DECPosition' => {
      Description => 'DEC-Position',
      PrintConv => {
        'Contrast' => 'Kontrast',
        'Exposure' => 'Belichtung',
        'Saturation' => 'Sättigung',
      },
    },
   'DNGBackwardVersion' => 'DNG Versionskompatibilität',
   'DNGLensInfo' => 'Geringste Brennweite',
   'DNGVersion' => 'DNG-Version',
   'DSPFirmwareVersion' => 'DSP-Firmware-Version',
   'DataDump' => 'Daten-Dump',
   'DataImprint' => {
      Description => 'Daten-Einblendung',
      PrintConv => {
        'MM/DD/HH:MM' => 'MM/TT/SS:MM',
        'None' => 'Keine',
        'YYYY/MM/DD' => 'JJJJ/MM/TT',
      },
    },
   'Date' => 'Datum',
   'DateCreated' => 'Erstellungsdatum',
   'DateDisplayFormat' => {
      Description => 'Datumsformat',
      PrintConv => {
        'D/M/Y' => 'Tag/Monat/Jahr',
        'M/D/Y' => 'Monat/Tag/Jahr',
        'Y/M/D' => 'Jahr/Monat/Tag',
      },
    },
   'DateSent' => 'Absendedatum',
   'DateStampMode' => {
      Description => 'Zeitstempel-Modus',
      PrintConv => {
        'Date' => 'Datum',
        'Off' => 'Aus',
      },
    },
   'DateTime' => 'Dateiänderungsdatum',
   'DateTimeOriginal' => 'Datum der Originaldatengenerierung',
   'DaylightSavings' => {
      Description => 'Sommerzeit',
      PrintConv => {
        'No' => 'Aus',
        'Yes' => 'Ein',
      },
    },
   'DeletedImageCount' => 'Anzahl gelöschter Bilder',
   'Description' => 'Beschreibung',
   'Destination' => 'Ziel',
   'DestinationCity' => 'Zielort',
   'DestinationCityCode' => 'Zielort-Code',
   'DestinationDST' => {
      Description => 'Zielort Sommerzeit (DST)',
      PrintConv => {
        'No' => 'Deaktiviert',
        'Yes' => 'Aktiviert',
      },
    },
   'DevelopmentDynamicRange' => 'Dynamikbereich Entwicklung',
   'DeviceAttributes' => 'Geräte-Eigenschaften',
   'DeviceManufacturer' => 'Geräte-Hersteller',
   'DeviceMfgDesc' => 'Geräte-Hersteller-Bezeichnung',
   'DeviceModel' => 'Geräte-Modell',
   'DeviceModelDesc' => 'Geräte-Modell-Bezeichnung',
   'DeviceSettingDescription' => 'Geräteeinstellung',
   'DialDirectionTvAv' => {
      Description => 'Sens rotation molette Tv/Av',
      PrintConv => {
        'Reversed' => 'Umgekehrt',
      },
    },
   'DigitalCreationDate' => 'Digitalisierungsdatum',
   'DigitalCreationTime' => 'Digitalisierungszeit',
   'DigitalGEM' => 'Bildeffekt-Methode',
   'DigitalZoom' => {
      Description => 'Digital-Zoom',
      PrintConv => {
        'Electronic magnification' => 'Elektronische Vergrößerung',
        'None' => 'Keiner',
        'Off' => 'Aus',
        'Other' => 'Unbekannt',
      },
    },
   'DigitalZoomOn' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'DigitalZoomRatio' => 'Digital-Zoom-Fakor',
   'DirectoryIndex' => 'Verzeichnis-Index',
   'DisplayAperture' => 'Angezeigte Blende',
   'DisplayXResolutionUnit' => {
      PrintConv => {
        'um' => 'µm (Mikrometer)',
      },
    },
   'DisplayYResolutionUnit' => {
      PrintConv => {
        'um' => 'µm (Mikrometer)',
      },
    },
   'DistortionCorrection' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'DistortionCorrection2' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'DjVuVersion' => 'DjVu-Version',
   'DocumentHistory' => 'Historie des Dokuments',
   'DocumentNotes' => 'Notizen zum Dokument',
   'DriveMode' => {
      Description => 'Aufnahmeart',
      PrintConv => {
        'Bracketing' => 'Belichtungsreihe',
        'Continuous' => 'Serienaufnahme',
        'Continuous (Hi)' => 'Serienaufnahme (Hi)',
        'Continuous Bracketing' => 'Serienbild-Belichtungsreihe',
        'Continuous shooting' => 'Serienaufnahme',
        'HS continuous' => 'High-Speed Serienbild',
        'Multiple Exposure' => 'Mehrfachbelichtung',
        'No Timer' => 'Ohne Selbstauslöser',
        'Off' => 'Aus',
        'Remote Control' => 'Fernauslöser',
        'Remote Control (3 s delay)' => 'Fernauslöser (3 Sek. Verzögerung)',
        'Self-timer' => 'Selbstauslöser',
        'Self-timer (12 s)' => 'Selbstauslöser (12 Sek.)',
        'Self-timer (2 s)' => 'Selbstauslöser (2 Sek.)',
        'Self-timer Operation' => 'Selbstauslöser',
        'Shutter Button' => 'Kamera-Auslöser',
        'Single' => 'Einzelbild',
        'Single Exposure' => 'Einzelbelichtung',
        'Single Frame' => 'Einzelbild',
        'Single Shot' => 'Einzelbild',
        'Single-Frame Bracketing' => 'Einzelbild-Belichtungsreihe',
        'Single-frame' => 'Einzelbild',
        'Single-frame shooting' => 'Einzelbild',
        'UHS continuous' => 'Ultra High-Speed Serienbild',
        'White Balance Bracketing' => 'Weißabgleichs-Belichtungsreihe',
      },
    },
   'DriveMode2' => {
      Description => 'Mehrfachbelichtung',
      PrintConv => {
        'Single-frame' => 'Einzelbildaufnahme',
      },
    },
   'DynamicAFArea' => {
      Description => 'Dynamisches AF-Messfeld',
      PrintConv => {
        '21 Points' => '21 Messfelder',
        '51 Points' => '51 Messfelder',
        '51 Points (3D-tracking)' => '51 Messfelder (3D-Tracking)',
        '9 Points' => '9 Messfelder',
      },
    },
   'DynamicRange' => {
      Description => 'Dynamikbereich',
      PrintConv => {
        'Wide' => 'Weit',
      },
    },
   'DynamicRangeExpansion' => {
      Description => 'Dynamikbereich-Erweiterung',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'DynamicRangeOptimizer' => {
      Description => 'Dynamikbereich-Optimierung',
      PrintConv => {
        'Advanced Auto' => 'Erw. Automatik',
        'Advanced Lv1' => 'Erw. Stufe 1',
        'Advanced Lv2' => 'Erw. Stufe 2',
        'Advanced Lv3' => 'Erw. Stufe 3',
        'Advanced Lv4' => 'Erw. Stufe 4',
        'Advanced Lv5' => 'Erw. Stufe 5',
        'Off' => 'Aus',
      },
    },
   'DynamicRangeSetting' => {
      Description => 'Dynamikbereich-Einstellungen',
      PrintConv => {
        'Film Simulation' => 'Film-Simulation',
        'Wide1 (230%)' => 'Weit1 (230%)',
        'Wide2 (400%)' => 'Weit2 (400%)',
      },
    },
   'E-DialInProgram' => {
      PrintConv => {
        'Tv or Av' => 'Tv oder Av',
      },
    },
   'ETTLII' => {
      PrintConv => {
        'Average' => 'Durchschnitt',
        'Evaluative' => 'Mehrfeldmessung',
      },
    },
   'EVStepSize' => {
      Description => 'Belichtungswerte',
      PrintConv => {
        '1/2 EV' => '1/2 LW',
        '1/3 EV' => '1/3 LW',
      },
    },
   'EVSteps' => {
      Description => 'LW-Schritte',
      PrintConv => {
        '1/2 EV Steps' => '1/2 LW-Schritte',
        '1/2 EV steps' => '1/2 LW-Schritte',
        '1/3 EV Steps' => '1/3 LW-Schritte',
        '1/3 EV steps' => '1/3 LW-Schritte',
      },
    },
   'EasyExposureCompensation' => {
      Description => 'Belichtungskorrektur',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
        'On (auto reset)' => 'Einstellrad (Reset)',
      },
    },
   'EasyMode' => {
      Description => 'Easy-Modus',
      PrintConv => {
        'Beach' => 'Strand',
        'Black & White' => 'Schwarz/Weiß',
        'Color Accent' => 'Farbton',
        'Color Swap' => 'Farbwechsel',
        'Fireworks' => 'Feuerwerk',
        'Foliage' => 'Laub',
        'Indoor' => 'Innenaufnahme',
        'Kids & Pets' => 'Kinder & Tiere',
        'Landscape' => 'Landschaft',
        'Macro' => 'Makro',
        'Manual' => 'Manuell',
        'Night' => 'Nachtszene',
        'Night Snapshot' => 'Nacht Schnappschuss',
        'Portrait' => 'Porträt',
        'Snow' => 'Schnee',
        'Sports' => 'Sport',
        'Super Macro' => 'Super-Makro',
        'Underwater' => 'Tauchen',
      },
    },
   'EdgeNoiseReduction' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'EditStatus' => 'Bearbeitungsstatus',
   'EditorialUpdate' => 'Redaktionelle Überarbeitung',
   'EffectiveLV' => 'Effektiver LW',
   'Emphasis' => {
      PrintConv => {
        'None' => 'Keine',
      },
    },
   'EncodingProcess' => 'JPEG-Kodierung Prozess',
   'EnhanceDarkTones' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'Enhancement' => {
      PrintConv => {
        'Blue' => 'Blau',
        'Green' => 'Grün',
        'Off' => 'Aus',
        'Red' => 'Rot',
      },
    },
   'EnvelopePriority' => {
      Description => 'Priorität',
      PrintConv => {
        '0 (reserved)' => '0 (Reserviert für zukünftige Verwendung)',
        '1 (most urgent)' => '1 (sehr wichtig)',
        '5 (normal urgency)' => '5 (normale Wichtigkeit)',
        '8 (least urgent)' => '8 (geringe Wichtigkeit)',
        '9 (user-defined priority)' => '9 (Benutzerdefinierte Priorität)',
      },
    },
   'EnvelopeRecordVersion' => 'IPTC-Modell-1-Version',
   'EquipmentVersion' => 'Equipment-Version',
   'Error' => 'Fehler',
   'ExifCameraInfo' => 'Exif Kamerainformationen',
   'ExifImageHeight' => 'Exif-Bildhöhe',
   'ExifImageWidth' => 'Exif-Bildbreite',
   'ExifToolVersion' => 'ExifTool-Version',
   'ExifVersion' => 'Exif-Version',
   'ExpandFilm' => 'Erweitert Film',
   'ExpandFilterLens' => 'Erweitert Filterlinse',
   'ExpandFlashLamp' => 'Erweitert Blitzlicht',
   'ExpandLens' => 'Erweitert Objektiv',
   'ExpandScanner' => 'Erweitert Scanner',
   'ExpandSoftware' => 'Erweitert Software',
   'ExpirationDate' => 'Ablaufdatum',
   'ExpirationTime' => 'Ablaufzeit',
   'ExposureBracketStepSize' => 'Belichtungsreihen-Stufenabstand',
   'ExposureBracketValue' => 'Belichtungsreihenwert',
   'ExposureCompensation' => 'Belichtungskorrektur',
   'ExposureControlStepSize' => {
      Description => 'Belichtungswert',
      PrintConv => {
        '1 EV' => '1 LW',
        '1/2 EV' => '1/2 LW',
        '1/3 EV' => '1/3 LW',
      },
    },
   'ExposureDelayMode' => {
      Description => 'Spiegelvorauslösung',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ExposureDifference' => 'Belichtungsabweichung',
   'ExposureIndex' => 'Belichtungsindex',
   'ExposureLevelIncrements' => {
      Description => 'Belichtungswert',
      PrintConv => {
        '1-stop set, 1/3-stop comp.' => '1-Blende, 1/3-Blendenkompensation',
        '1/2 Stop' => '1/2 LW',
        '1/2-stop set, 1/2-stop comp.' => '1/2-Blende, 1/2-Blendenkompensation',
        '1/3 Stop' => '1/3 LW',
        '1/3-stop set, 1/3-stop comp.' => '1/3-Blende, 1/3-Blendenkompensation',
      },
    },
   'ExposureMode' => {
      Description => 'Belichtungsmodus',
      PrintConv => {
        'Aperture Priority' => 'Blendenpriorität',
        'Aperture-priority AE' => 'Blendenpriorität',
        'Auto' => 'Automatische Belichtung',
        'Auto bracket' => 'Belichtungsreihe',
        'Auto?' => 'Automatisch?',
        'Bulb' => 'Bulb-Modus',
        'Landscape' => 'Landschaft',
        'Manual' => 'Manuelle Belichtung',
        'Night Scene' => 'Nachtszene',
        'Portrait' => 'Porträt',
        'Program' => 'Programm',
        'Program-shift' => 'Programm-Shift',
        'Program-shift A' => 'Programmverschiebung A',
        'Program-shift S' => 'Programmverschiebung S',
        'Shutter Priority' => 'Verschlusspriorität',
        'Shutter speed priority AE' => 'Verschlusspriorität',
      },
    },
   'ExposureModeInManual' => {
      Description => 'Belichtungsmodus bei manueller Belichtung',
      PrintConv => {
        'Center-weighted average' => 'Mittenbetont',
        'Evaluative metering' => 'Mehrfeldmessung',
        'Partial metering' => 'Teilbild',
        'Specified metering mode' => 'Spezifizierte Messmethode',
        'Spot metering' => 'Spotmessung',
      },
    },
   'ExposureProgram' => {
      Description => 'Belichtungsprogramm',
      PrintConv => {
        'Action (High speed)' => 'Action-Programm (ausgerichtet auf schnelle Verschlussgeschwindigkeit)',
        'Aperture Priority' => 'Blendenpriorität',
        'Aperture-priority AE' => 'Blendenpriorität',
        'Creative (Slow speed)' => 'Kreativ-Programm (ausgerichtet auf Schärfentiefe)',
        'Landscape' => 'Landschaftsmodus',
        'Manual' => 'Manuell',
        'Not Defined' => 'Nicht definiert',
        'Portrait' => 'Portrait-Modus',
        'Program' => 'Programm',
        'Program AE' => 'Normal-Programm',
        'Shutter Priority' => 'Verschlusspriorität',
        'Shutter speed priority AE' => 'Verschlusspriorität',
      },
    },
   'ExposureTime' => 'Belichtungsdauer',
   'ExposureTime2' => 'Belichtungsdauer 2',
   'ExposureWarning' => {
      Description => 'Belichtungswarnung',
      PrintConv => {
        'Bad exposure' => 'Schlechte Belichtung',
        'Good' => 'OK',
      },
    },
   'ExtendedWBDetect' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'Extender' => 'Konverter',
   'ExtenderFirmwareVersion' => 'Konverter-Firmware-Version',
   'ExtenderModel' => 'Konverter-Modell',
   'ExtenderSerialNumber' => 'Konverter-Seriennummer',
   'ExternalFlash' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ExternalFlashBounce' => {
      Description => 'Externer Blitz - Bounce',
      PrintConv => {
        'Bounce' => 'Mit Bounce',
        'Direct' => 'Direkt',
        'No' => 'Nein',
        'Yes' => 'Ja',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'ExternalFlashExposureComp' => {
      Description => 'Belichtungskorrektur des externen Blitzgeräts',
      PrintConv => {
        '-0.5' => '-0.5 LW',
        '-1.0' => '-1.0 LW',
        '-1.5' => '-1.5 LW',
        '-2.0' => '-2.0 LW',
        '-2.5' => '-2.5 LW',
        '-3.0' => '-3.0 LW',
        '0.0' => '0.0 LW',
        '0.5' => '0.5 LW',
        '1.0' => '1.0 LW',
        'n/a' => 'Nicht gesetzt (Aus oder Auto-Modi)',
        'n/a (Manual Mode)' => 'Nicht gesetzt (Manueller Modus)',
      },
    },
   'ExternalFlashMode' => {
      Description => 'Slave-Blitz-Messfeld 3',
      PrintConv => {
        'Off' => 'Aus',
        'On, Auto' => 'Ein, Auto',
        'On, Contrast-control Sync' => 'Ein, Kontrast-Steuerungs-Synchronisation',
        'On, Flash Problem' => 'Ein, Blitzproblem?',
        'On, High-speed Sync' => 'Ein, High-Speed-Synchronisation',
        'On, Manual' => 'Ein, Manuell',
        'On, P-TTL Auto' => 'Ein, P-TTL-Blitzautomatik',
        'On, Wireless' => 'Ein, Drahtlos',
        'On, Wireless, High-speed Sync' => 'Ein, Drahtlos, High-Speed-Synchronisation',
        'n/a - Off-Auto-Aperture' => 'K/A - Blendenring nicht auf A',
      },
    },
   'ExtraSamples' => 'Zusätzliche Komponenten',
   'FNumber' => 'F-Wert',
   'Face0Position' => 'Position, 0. Gesicht',
   'Face1Position' => 'Position, 1. Gesicht',
   'Face2Position' => 'Position, 2. Gesicht',
   'Face3Position' => 'Position, 3. Gesicht',
   'Face4Position' => 'Position, 4. Gesicht',
   'Face5Position' => 'Position, 5. Gesicht',
   'Face6Position' => 'Position, 6. Gesicht',
   'Face7Position' => 'Position, 7. Gesicht',
   'Face8Position' => 'Position, 8. Gesicht',
   'FaceDetectFrameHeight' => 'Bereichshöhe',
   'FaceDetectFrameWidth' => 'Bereichsbreite',
   'FacesDetected' => 'Gesichter erkannt',
   'FastSeek' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'FaxProfile' => {
      PrintConv => {
        'Unknown' => 'Unbekannt',
      },
    },
   'FaxRecvParams' => 'Fax-Empfangsparameter',
   'FaxRecvTime' => 'Fax-Empfangszeit',
   'FaxSubAddress' => 'Fax-Sub-Adresse',
   'FileFormat' => 'Dateiformat',
   'FileIndex' => 'Datei-Index',
   'FileModifyDate' => 'Datei Änderung Datum / Uhrzeit',
   'FileName' => 'Dateiname',
   'FileNumber' => 'Dateinummer',
   'FileNumberMemory' => {
      Description => 'Dateinummernspeicher',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'FileNumberSequence' => {
      Description => 'Nummernspeicher',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'FileSize' => 'Dateigröße',
   'FileSource' => {
      Description => 'Dateiquelle',
      PrintConv => {
        'Digital Camera' => 'Digital-Kamera',
        'Film Scanner' => 'Film-Scanner',
        'Reflection Print Scanner' => 'Scanner',
      },
    },
   'FileType' => 'Dateityp',
   'FileVersion' => 'Dateiformatversion',
   'FillFlashAutoReduction' => {
      Description => 'E-TTL II-Automatikblitz-System',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'FilmMode' => {
      Description => 'Film-Modus',
      PrintConv => {
        'F1/Studio Portrait' => 'F1/Studio-Porträt',
        'F1a/Studio Portrait Enhanced Saturation' => 'F1a/Studio-Porträt Erweiterte Sättigung',
        'F1b/Studio Portrait Smooth Skin Tone' => 'F1b/Studio-Porträt Weiche Hauttöne',
        'F1c/Studio Portrait Increased Sharpness' => 'F1c/Studio-Porträt Erhöhte Schärfe',
        'F3/Studio Portrait Ex' => 'F3/Studio Porträt Ex',
      },
    },
   'FilmType' => 'Filmtyp',
   'Filter' => {
      PrintConv => {
        'Off' => 'Aus',
      },
    },
   'FilterEffect' => {
      Description => 'Filter-Effekt',
      PrintConv => {
        'Green' => 'Grün',
        'None' => 'Keiner',
        'Off' => 'Aus',
        'Red' => 'Rot',
        'Yellow' => 'Gelb',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'FilterEffectMonochrome' => {
      PrintConv => {
        'Green' => 'Grün',
        'None' => 'Keine',
        'Red' => 'Rot',
        'Yellow' => 'Gelb',
      },
    },
   'FinderDisplayDuringExposure' => {
      Description => 'Sucheranzeige bei Belichtung',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'FineTuneOptCenterWeighted' => 'Feinabst. der Bel.Messung > Mittenbetonte Messung',
   'FineTuneOptMatrixMetering' => 'Feinabst. der Bel.Messung > Matrixmessung',
   'FineTuneOptSpotMetering' => 'Feinabst. der Bel.Messung > Spotmessung',
   'FineTuneStepSize' => {
      Description => 'Belichtungskorrekturwert',
      PrintConv => {
        '1 EV' => '1 LW',
        '1/2 EV' => '1/2 LW',
        '1/3 EV' => '1/3 LW',
      },
    },
   'FirmwareRevision' => 'Firmware-Revision',
   'FirmwareVersion' => 'Firmware-Version',
   'FixtureIdentifier' => 'Kennzeichnung',
   'Flash' => {
      Description => 'Blitz',
      PrintConv => {
        'Auto, Did not fire' => 'Blitz wurde nicht ausgelöst, Automodus',
        'Auto, Did not fire, Red-eye reduction' => 'Blitz wurde nicht ausgelöst, Rote-Augen-Reduzierung',
        'Auto, Fired' => 'Blitz wurde ausgelöst, Automodus',
        'Auto, Fired, Red-eye reduction' => 'Blitz wurde ausgelöst, Automodus, Rote-Augen-Reduzierung',
        'Auto, Fired, Red-eye reduction, Return detected' => 'Blitz wurde ausgelöst, Automodus, Messblitz-Licht zurückgeworfen, Rote-Augen-Reduzierung',
        'Auto, Fired, Red-eye reduction, Return not detected' => 'Blitz wurde ausgelöst, Automodus, kein Messblitz-Licht zurückgeworfen, Rote-Augen-Reduzierung',
        'Auto, Fired, Return detected' => 'Blitz wurde ausgelöst, Automodus, Messblitz-Licht zurückgeworfen',
        'Auto, Fired, Return not detected' => 'Blitz wurde ausgelöst, Automodus, kein Messblitz-Licht zurückgeworfen',
        'Did not fire' => 'Blitz wurde nicht ausgelöst',
        'Fired' => 'Blitz wurde ausgelöst',
        'Fired, Red-eye reduction' => 'Blitz wurde ausgelöst, Rote-Augen-Reduzierung',
        'Fired, Red-eye reduction, Return detected' => 'Blitz wurde ausgelöst, Rote-Augen-Reduzierung, Messblitz-Licht zurückgeworfen',
        'Fired, Red-eye reduction, Return not detected' => 'Blitz wurde ausgelöst, Rote-Augen-Reduzierung, kein Messblitz-Licht zurückgeworfen',
        'Fired, Return detected' => 'Messblitz-Licht zurückgeworfen',
        'Fired, Return not detected' => 'Kein Messblitz-Licht zurückgeworfen',
        'No Flash' => 'Blitz wurde nicht ausgelöst',
        'No flash function' => 'Keine Blitzfunktion',
        'Off' => 'Aus',
        'Off, Did not fire' => 'Blitz wurde nicht ausgelöst, Blitz unterdrücken-Modus',
        'Off, Did not fire, Return not detected' => 'Deaktiviert, Blitz wurde nicht ausgelöst, kein Messblitz-Licht zurückgeworfen',
        'Off, No flash function' => 'Deaktiviert, Keine Blitzfunktion',
        'Off, Red-eye reduction' => 'Deaktiviert, Rote-Augen-Reduzierung',
        'On' => 'Ein',
        'On, Did not fire' => 'Ein, Blitz wurde nicht ausgelöst',
        'On, Fired' => 'Blitz wurde ausgelöst, Blitz erzwingen-Modus',
        'On, Red-eye reduction' => 'Blitz wurde ausgelöst, Blitz erzwingen-Modus, Rote-Augen-Reduzierung',
        'On, Red-eye reduction, Return detected' => 'Blitz wurde ausgelöst, Blitz erzwingen-Modus, Rote-Augen-Reduzierung, Messblitz-Licht zurückgeworfen',
        'On, Red-eye reduction, Return not detected' => 'Blitz wurde ausgelöst, Blitz erzwingen-Modus, Rote-Augen-Reduzierung, kein Messblitz-Licht zurückgeworfen',
        'On, Return detected' => 'Blitz wurde ausgelöst, Blitz erzwingen-Modus, Messblitz-Licht zurückgeworfen',
        'On, Return not detected' => 'Blitz wurde ausgelöst, Blitz erzwingen-Modus, kein Messblitz-Licht zurückgeworfen',
      },
    },
   'FlashActivity' => 'Blitz-Leistung',
   'FlashBits' => 'Blitz-Details',
   'FlashCommanderMode' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'FlashControlMode' => {
      Description => 'Blitzlichtsteuerungsmodus',
      PrintConv => {
        'Manual' => 'Manuell',
        'Off' => 'Aus',
        'Repeating Flash' => 'Stroboskopblitz',
      },
    },
   'FlashDevice' => {
      PrintConv => {
        'External' => 'Extern',
        'Internal' => 'Intern',
        'Internal + External' => 'Intern + Extern',
        'None' => 'Keins',
      },
    },
   'FlashEnergy' => 'Blitzstärke',
   'FlashExposureBracketValue' => 'Blitzbelichtungsreihenwert',
   'FlashExposureComp' => 'Blitzbelichtungsausgleich',
   'FlashExposureCompSet' => 'Eingestellte Blitz-Belichtungskorrektur',
   'FlashExposureLock' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'FlashFired' => {
      Description => 'Blitz wurde ausgelöst',
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'FlashFiring' => {
      Description => 'Blitzzündung',
      PrintConv => {
        'Does not fire' => 'Unterdrückt',
        'Fires' => 'Aktiv',
      },
    },
   'FlashFirmwareVersion' => 'Blitz-Firmware-Version',
   'FlashGroupAControlMode' => {
      Description => 'Gruppe A, Blitzlichtsteuerungsmodus',
      PrintConv => {
        'Manual' => 'Manuell',
        'Off' => 'Aus',
        'Repeating Flash' => 'Stroboskopblitz',
      },
    },
   'FlashGroupBControlMode' => {
      Description => 'Gruppe B, Blitzlichtsteuerungsmodus',
      PrintConv => {
        'Manual' => 'Manuell',
        'Off' => 'Aus',
        'Repeating Flash' => 'Stroboskopblitz',
      },
    },
   'FlashGroupCControlMode' => {
      Description => 'Gruppe C, Blitzlichtsteuerungsmodus',
      PrintConv => {
        'Manual' => 'Manuell',
        'Off' => 'Aus',
        'Repeating Flash' => 'Stroboskopblitz',
      },
    },
   'FlashGuideNumber' => 'Blitzleitzahl',
   'FlashIntensity' => {
      PrintConv => {
        'High' => 'Hoch',
        'Strong' => 'Stark',
      },
    },
   'FlashLevel' => 'Blitzbelichtungskorr.',
   'FlashMetering' => {
      Description => 'Blitz-Messung',
      PrintConv => {
        'Manual flash control' => 'Manuelle Blitz-Kontrolle',
        'Pre-flash TTL' => 'Vorblitz TTL',
      },
    },
   'FlashMeteringSegments' => 'Blitz-Messfelder',
   'FlashMode' => {
      Description => 'Blitz-Modus',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Auto, Did not fire' => 'Auto, nicht ausgelöst',
        'Auto, Did not fire, Red-eye reduction' => 'Auto, nicht ausgelöst, Rote-Augen-Reduzierung',
        'Auto, Fired' => 'Auto, ausgelöst',
        'Auto, Fired, Red-eye reduction' => 'Auto, ausgelöst, Rote-Augen-Reduzierung',
        'Did Not Fire' => 'Nicht ausgelöst',
        'External, Auto' => 'Extern, Auto',
        'External, Contrast-control Sync' => 'Extern, Kontrast-Steuerungs-Synchronisation',
        'External, Flash Problem' => 'Extern, Blitzproblem?',
        'External, High-speed Sync' => 'Extern, High-Speed-Synchronisation',
        'External, Manual' => 'Extern, Manuell',
        'External, P-TTL Auto' => 'Extern, P-TTL-Blitzautomatik',
        'External, Wireless' => 'Extern, Drahtlos',
        'External, Wireless, High-speed Sync' => 'Extern, Drahtlos, High-Speed-Synchronisation',
        'Fill flash' => 'Aufhellblitz',
        'Fired, Commander Mode' => 'Ausgelöst, Befehlsmodus',
        'Fired, External' => 'Ausgelöst, Extern',
        'Fired, Manual' => 'Ausgelöst, Manuell',
        'Fired, TTL Mode' => 'Ausgelöst, TTL-Modus',
        'Internal' => 'Intern',
        'Off' => 'Aus',
        'Off, Did not fire' => 'Aus',
        'Off?' => 'Aus?',
        'On' => 'Ein',
        'On, Did not fire' => 'Ein, nicht ausgelöst',
        'On, Fired' => 'Ein',
        'On, Red-eye reduction' => 'Ein, Rote-Augen-Reduzierung',
        'On, Slow-sync' => 'Ein, Langzeit-Synchronisation',
        'On, Slow-sync, Red-eye reduction' => 'Ein, Langzeit-Synchronisation, Rote-Augen-Reduzierung',
        'On, Soft' => 'Ein, Softblitz',
        'On, Trailing-curtain Sync' => 'Ein, 2. Verschlussvorhang',
        'On, Wireless (Control)' => 'Ein, Drahtlos (Steuerblitz)',
        'On, Wireless (Master)' => 'Ein, Drahtlos (Hauptblitz)',
        'Rear flash sync' => 'Synchronisation auf den zweiten Verschlussvorhang',
        'Red-eye Reduction' => 'Rote-Augen-Reduzierung',
        'Red-eye reduction' => 'Rote-Augen-Reduzierung',
        'Unknown' => 'Unbekannt',
        'Wireless' => 'Drahtlos',
        'n/a - Off-Auto-Aperture' => 'K/A - Blendenring nicht auf A',
      },
    },
   'FlashModel' => {
      Description => 'Blitz-Modell',
      PrintConv => {
        'None' => 'Keines',
      },
    },
   'FlashOptions' => {
      Description => 'Blitz-Optionen',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Auto, Red-eye reduction' => 'Auto, Rote-Augen-Reduzierung',
        'Red-eye reduction' => 'Rote-Augen-Reduzierung',
        'Slow-sync' => 'Langzeit-Synchronisation',
        'Slow-sync, Red-eye reduction' => 'Langzeit-Synchronisation, Rote-Augen-Reduzierung',
        'Trailing-curtain Sync' => '2. Verschlussvorhang',
        'Wireless (Control)' => 'Drahtlos (Steuerblitz)',
        'Wireless (Master)' => 'Drahtlos (Hauptblitz)',
      },
    },
   'FlashOptions2' => {
      Description => 'Blitz-Optionen (2)',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Auto, Red-eye reduction' => 'Auto, Rote-Augen-Reduzierung',
        'Red-eye reduction' => 'Rote-Augen-Reduzierung',
        'Slow-sync' => 'Langzeit-Synchronisation',
        'Slow-sync, Red-eye reduction' => 'Langzeit-Synchronisation, Rote-Augen-Reduzierung',
        'Trailing-curtain Sync' => '2. Verschlussvorhang',
        'Wireless (Control)' => 'Drahtlos (Steuerblitz)',
        'Wireless (Master)' => 'Drahtlos (Hauptblitz)',
      },
    },
   'FlashOutput' => 'Blitzstärke',
   'FlashSerialNumber' => 'Blitz-Seriennummer',
   'FlashSetting' => 'Blitzeinstellung',
   'FlashShutterSpeed' => 'Längste Verschlussz. (Blitz)',
   'FlashStatus' => {
      Description => 'Slave-Blitz-Messfeld 1',
      PrintConv => {
        'External, Did not fire' => 'Extern, nicht ausgelöst',
        'External, Fired' => 'Extern, ausgelöst',
        'Internal, Did not fire' => 'Intern, nicht ausgelöst',
        'Internal, Fired' => 'Intern, ausgelöst',
        'Off' => 'Aus',
      },
    },
   'FlashSyncSpeed' => 'Blitzsynchronzeit',
   'FlashSyncSpeedAv' => {
      Description => 'Blitzsynchronzeit bei Av',
      PrintConv => {
        '1/200 Fixed' => '1/200 Fest',
        '1/200-1/60 Auto' => '1/200-1/60 automatisch',
        '1/250 Fixed' => '1/250 Fest',
        '1/250-1/60 Auto' => '1/200-1/60 automatisch',
        '1/300 Fixed' => '1/300 Fest',
        'Auto' => 'Automatisch',
      },
    },
   'FlashType' => {
      Description => 'Blitztyp',
      PrintConv => {
        'None' => 'Keiner',
      },
    },
   'FlashWarning' => {
      Description => 'Blitzsymbol',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'FlashpixVersion' => 'Unterstützte Flashpix-Version',
   'FlickerReduce' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'FlipHorizontal' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'FocalLength' => 'Brennweite',
   'FocalLength35efl' => 'Brennweite',
   'FocalLengthIn35mmFormat' => 'Brennweite in 35 mm-Kleinbildformat',
   'FocalPlaneDiagonal' => 'Diagonale der Fokalebene',
   'FocalPlaneResolutionUnit' => {
      Description => 'Einheit der Sensorauflösung',
      PrintConv => {
        'None' => 'Keine',
        'um' => 'µm (Mikrometer)',
      },
    },
   'FocalPlaneXResolution' => 'Sensorauflösung horizontal',
   'FocalPlaneXSize' => 'Breite der Fokal-Ebene',
   'FocalPlaneXUnknown' => 'Breite der Fokal-Ebene',
   'FocalPlaneYResolution' => 'Sensorauflösung vertikal',
   'FocalPlaneYSize' => 'Höhe der Fokal-Ebene',
   'FocalPlaneYUnknown' => 'Höhe der Fokal-Ebene',
   'FocalType' => {
      Description => 'Objektivart',
      PrintConv => {
        'Fixed' => 'Festbrennweite',
        'Zoom' => 'Zoom-Objektiv',
      },
    },
   'FocalUnits' => '"focal units" pro mm',
   'Focus' => {
      PrintConv => {
        'Manual' => 'Manuell',
      },
    },
   'FocusArea' => {
      Description => 'Fokus-Bereich',
      PrintConv => {
        'Spot Focus' => 'Spot-AF-Messfeld',
        'Wide Focus (normal)' => 'Großes AF-Messfeld (normal)',
      },
    },
   'FocusAreaSelection' => {
      Description => 'Scrollen bei Messfeldausw.',
      PrintConv => {
        'No Wrap' => 'Am Rand stoppen',
        'Wrap' => 'Umlaufend',
      },
    },
   'FocusContinuous' => {
      Description => 'Fortlaufende Fokussierung',
      PrintConv => {
        'Continuous' => 'Serienaufnahme',
        'Manual' => 'Manuell',
      },
    },
   'FocusDistance' => 'Fokus-Distanz',
   'FocusDistanceLower' => 'Nahe Fokus-Distanz',
   'FocusDistanceUpper' => 'Entfernte Fokus-Distanz',
   'FocusMode' => {
      Description => 'Fokus-Modus',
      PrintConv => {
        'AF-C' => 'AF-C (Kontinuierlicher Autofokus)',
        'AF-S' => 'AF-S (Einzelautofokus)',
        'Auto' => 'Automatisch',
        'Continuous' => 'Serienaufnahme',
        'Custom' => 'Benutzerdefiniert',
        'Infinity' => 'Unendlich',
        'Macro' => 'Makro',
        'Macro (1)' => 'Makro (1)',
        'Macro (2)' => 'Makro (2)',
        'Manual' => 'Manuell',
        'Pan Focus' => 'Pan-Fokus',
        'Super Macro' => 'Super-Makro',
      },
    },
   'FocusMode2' => {
      Description => 'Fokus-Modus 2',
      PrintConv => {
        'AF-C' => 'AF-C (Kontinuierlicher Autofokus)',
        'AF-S' => 'AF-S (Einzelautofokus)',
        'Manual' => 'Manuell',
      },
    },
   'FocusModeSetting' => {
      Description => 'Autofokus',
      PrintConv => {
        'AF-C' => 'AF-C (Kontinuierlicher Autofokus)',
        'AF-S' => 'AF-S (Einzelautofokus)',
        'Manual' => 'Manuell',
      },
    },
   'FocusPixel' => 'Fokus-Pixel',
   'FocusPointWrap' => {
      Description => 'Scrollen bei Messfeldausw.',
      PrintConv => {
        'No Wrap' => 'Am Rand stoppen',
        'Wrap' => 'Umlaufend',
      },
    },
   'FocusPosition' => 'Fokus-Distanz',
   'FocusRange' => {
      Description => 'Fokus-Bereich',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Close' => 'Nah',
        'Far Range' => 'Entfernt',
        'Infinity' => 'Unendlich',
        'Macro' => 'Makro',
        'Manual' => 'Manuell',
        'Middle Range' => 'Mittlerer Bereich',
        'Not Known' => 'Nicht bekannt',
        'Pan Focus' => 'Pan-Fokus',
        'Super Macro' => 'Super-Makro',
        'Very Close' => 'Sehr nah',
      },
    },
   'FocusTrackingLockOn' => {
      Description => 'Schärfenarchiv. mit Lock-On',
      PrintConv => {
        'Long' => 'Lang',
        'Off' => 'Aus',
        'Short' => 'Kurz',
      },
    },
   'FocusWarning' => {
      Description => 'Fokus-Warnung',
      PrintConv => {
        'Good' => 'OK',
        'Out of focus' => 'Ausserhalb des Fokus',
      },
    },
   'FocusingScreen' => 'Mattscheibe',
   'FolderName' => 'Ordner-Name',
   'FrameNumber' => 'Bildnummer',
   'FreeByteCounts' => 'Anzahl Bytes des leeren Datenbereiches',
   'FreeMemoryCardImages' => 'Platz auf Speicherkarten für',
   'FreeOffsets' => 'Leerdatenposition',
   'FujiFlashMode' => {
      Description => 'Blitz-Modus',
      PrintConv => {
        'Auto' => 'Automatisch',
        'External' => 'Externer Blitz',
        'Off' => 'Unterdrückter Blitz',
        'On' => 'Erzwungener Blitz',
        'Red-eye reduction' => 'Rote-Augen-Reduzierung',
      },
    },
   'FunctionButton' => {
      Description => 'Funktionstaste',
      PrintConv => {
        'AF-area Mode' => 'Messfeldsteuerung',
        'Center AF Area' => 'AF-Messfeldgröße',
        'Center-weighted' => 'Mittenbetont',
        'FV Lock' => 'FV-Messwertspeicher',
        'Flash Off' => 'Blitz aus',
        'Framing Grid' => 'Gitterlinien',
        'ISO Display' => 'ISO-Anzeige',
        'Matrix Metering' => 'Matrixmessung',
        'Spot Metering' => 'Spotmessung',
      },
    },
   'GIFVersion' => 'GIF-Version',
   'GPSAltitude' => 'Höhe',
   'GPSAltitudeRef' => {
      Description => 'Bezugshöhe',
      PrintConv => {
        'Above Sea Level' => 'Höhe über Normal-Null (Meeresspiegel)',
        'Below Sea Level' => 'Meereshöhe-Referenz (negative Werte)',
      },
    },
   'GPSAreaInformation' => 'Name des GPS-Gebietes',
   'GPSDOP' => 'Messgenauigkeit',
   'GPSDateStamp' => 'GPS Datum',
   'GPSDateTime' => 'GPS-Zeit (Atomuhr)',
   'GPSDestBearing' => 'Motivrichtung',
   'GPSDestBearingRef' => {
      Description => 'Referenz für Motivrichtung',
      PrintConv => {
        'Magnetic North' => 'Magnetische Ausrichtung',
        'True North' => 'Geographische Ausrichtung',
      },
    },
   'GPSDestDistance' => 'Distanz zum Ziel',
   'GPSDestDistanceRef' => {
      Description => 'Reference for distance to destination',
      PrintConv => {
        'Kilometers' => 'Kilometer',
        'Miles' => 'Meilen',
        'Nautical Miles' => 'Knoten',
      },
    },
   'GPSDestLatitude' => 'Breite des Zieles',
   'GPSDestLatitudeRef' => {
      Description => 'Referenz für die Breite des Zieles',
      PrintConv => {
        'North' => 'Nordliche Breite',
        'South' => 'Südliche Breite',
      },
    },
   'GPSDestLongitude' => 'Längengrad des Ziels',
   'GPSDestLongitudeRef' => {
      Description => 'Referenz für die Länge des Zieles',
      PrintConv => {
        'East' => 'Östliche Länge',
        'West' => 'Westliche Länge',
      },
    },
   'GPSDifferential' => {
      Description => 'GPS-Differentialkorrektur',
      PrintConv => {
        'Differential Corrected' => 'Differentialkorrektur angewandt',
        'No Correction' => 'Messung ohne Differentialkorrektur',
      },
    },
   'GPSImgDirection' => 'Bildrichtung',
   'GPSImgDirectionRef' => {
      Description => 'Referenz für die Ausrichtung des Bildes',
      PrintConv => {
        'Magnetic North' => 'Magnetische Ausrichtung',
        'True North' => 'Geographische Ausrichtung',
      },
    },
   'GPSLatitude' => 'Geografische Breite',
   'GPSLatitudeRef' => {
      Description => 'Nördl. oder südl. Breite',
      PrintConv => {
        'North' => 'Nördliche Breite',
        'South' => 'Südliche Breite',
      },
    },
   'GPSLongitude' => 'Geografische Länge',
   'GPSLongitudeRef' => {
      Description => 'östl. oder westl. Länge',
      PrintConv => {
        'East' => 'Östliche Länge',
        'West' => 'Westliche Länge',
      },
    },
   'GPSMapDatum' => 'Geodätisches Datum',
   'GPSMeasureMode' => {
      Description => 'GPS-Messverfahren',
      PrintConv => {
        '2-D' => '2-Dimensionale Messung',
        '2-Dimensional' => '2-Dimensionale Messung',
        '2-Dimensional Measurement' => '2-Dimensionale Messung',
        '3-D' => '3-Dimensionale Messung',
        '3-Dimensional' => '3-Dimensionale Messung',
        '3-Dimensional Measurement' => '3-Dimensionale Messung',
      },
    },
   'GPSProcessingMethod' => 'Name der GPS-Verarbeitungsmethode',
   'GPSSatellites' => 'Für die Messung verwendete Satelliten',
   'GPSSpeed' => 'Geschwindigkeit des GPS-Empfängers',
   'GPSSpeedRef' => {
      Description => 'Geschwindigkeitseinheit',
      PrintConv => {
        'km/h' => 'Kilometer pro Stunde',
        'knots' => 'Knoten',
        'mph' => 'Meilen pro Stunde',
      },
    },
   'GPSStatus' => {
      Description => 'GPS-Empfänger-Status',
      PrintConv => {
        'Measurement Active' => 'Messung aktiv',
        'Measurement Void' => 'Messung ungültig',
      },
    },
   'GPSTimeStamp' => 'GPS-Zeit (Atomuhr)',
   'GPSTrack' => 'Bewegungsrichtung',
   'GPSTrackRef' => {
      Description => 'Referenz für Bewegungsrichtung',
      PrintConv => {
        'Magnetic North' => 'Magnetische Ausrichtung',
        'True North' => 'Geographische Ausrichtung',
      },
    },
   'GPSVersionID' => 'GPS-Tag-Version',
   'GainControl' => {
      Description => 'Belichtungsverstärkung',
      PrintConv => {
        'High gain down' => 'Hohe Helligkeitsminderung',
        'High gain up' => 'Hohe Helligkeitsverstärkung',
        'Low gain down' => 'Geringe Helligkeitsminderung',
        'Low gain up' => 'Geringe Helligkeitsverstärkung',
        'None' => 'Keine',
      },
    },
   'Gapless' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'GrayResponseUnit' => {
      PrintConv => {
        '0.0001' => 'Nummer stellt ein 1000tel einer Einheit dar',
        '0.001' => 'Nummer stellt ein 100tel einer Einheit dar',
        '0.1' => 'Nummer stellt ein 10tel einer Einheit dar',
        '1e-05' => 'Nummer stellt ein 10000tel einer Einheit dar',
        '1e-06' => 'Nummer stellt ein 100000tel einer Einheit dar',
      },
    },
   'GrayTRC' => 'Grau-Tonwertwiedergabe-Kurve',
   'GreenMatrixColumn' => 'Grün-Matrixspalte',
   'GreenTRC' => 'Grün-Tonwertwiedergabe-Kurve',
   'GridDisplay' => {
      Description => 'Gitterlinien',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'Headline' => 'Überschrift',
   'HeightResolution' => 'Vertikale Bildauflösung',
   'HighISONoiseReduction' => {
      Description => 'Rauschunterdrückung bei hoher Empfindlichkeit',
      PrintConv => {
        'Disable' => 'Ausgeschaltet',
        'High' => 'Stärker',
        'Low' => 'Schwächer',
        'Off' => 'Aus',
        'On' => 'Ein',
        'Strong' => 'Stark',
        'Weak' => 'Gering',
        'Weakest' => 'Sehr gering',
      },
    },
   'HighlightTonePriority' => {
      Description => 'Tonwert Priorität',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'HometownCity' => 'Heimatort',
   'HometownCityCode' => 'Heimatort-Code',
   'HometownDST' => {
      Description => 'Heimatort Sommerzeit (DST)',
      PrintConv => {
        'No' => 'Deaktiviert',
        'Yes' => 'Aktiviert',
      },
    },
   'HueAdjustment' => 'Farbtonkorrektur',
   'IPTC-NAA' => 'IPTC-NAA Metadaten',
   'ISO' => 'ISO-Empfindlichkeit',
   'ISO2' => 'ISO-Empfindlichkeit (2)',
   'ISOExpansion' => {
      Description => 'ISO-Erweiterung',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ISOExpansion2' => {
      PrintConv => {
        'Off' => 'Aus',
      },
    },
   'ISOFloor' => 'ISO-Untergrenze',
   'ISOSelection' => 'ISO-Auswahl',
   'ISOSetting' => {
      Description => 'ISO-Einstellung',
      PrintConv => {
        '200 (Zone Matching High)' => '200 (Zonenabgleich High)',
        '80 (Zone Matching Low)' => '80 (Zonenabgleich Low)',
        'Auto' => 'Automatisch',
        'Manual' => 'Manuell',
      },
    },
   'ISOSpeedExpansion' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'ISOSpeedIncrements' => {
      Description => 'ISO-Schrittweite',
      PrintConv => {
        '1 Stop' => '1 LW',
        '1/3 Stop' => '1/3 LW',
      },
    },
   'ISOSpeedRange' => {
      Description => 'Einstellung ISO-Bereich',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'ISOStepSize' => {
      Description => 'ISO-Schrittweite',
      PrintConv => {
        '1 EV' => '1 LW',
        '1/2 EV' => '1/2 LW',
        '1/3 EV' => '1/3 LW',
      },
    },
   'Illumination' => {
      Description => 'Displaybeleuchtung',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ImageAdjustment' => 'Bildanpassung',
   'ImageAreaOffset' => 'Bildbereichsoffset',
   'ImageAuthentication' => {
      Description => 'Bild-Authentifikation',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'An',
      },
    },
   'ImageBoundary' => 'Bildbegrenzung',
   'ImageByteCount' => 'Anzahl Bytes der Bilddaten',
   'ImageCount' => 'Bildzähler',
   'ImageDataDiscard' => {
      Description => 'Verworfene Bilddaten',
      PrintConv => {
        'Flexbits Discarded' => 'FlexBits verworfen',
        'Full Resolution' => 'Volle Auflösung',
        'HighPass Frequency Data Discarded' => 'Hochpass-Frequenz-Daten verworfen',
        'Highpass and LowPass Frequency Data Discarded' => 'Hochpass- und Tiefpass-Frequenz-Daten verworfen',
      },
    },
   'ImageDataSize' => 'Bilddatengröße',
   'ImageDescription' => 'Bildtitel',
   'ImageDustOff' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ImageHeight' => 'Bildhöhe',
   'ImageHistory' => 'Bild-Historie',
   'ImageNumber' => 'Bildnummer',
   'ImageNumber2' => 'Bildnummer (2)',
   'ImageOffset' => 'Bilddatenposition',
   'ImageOptimization' => 'Bildoptimierung',
   'ImageOrientation' => {
      Description => 'Bildausrichtung',
      PrintConv => {
        'Landscape' => 'Querformat',
        'Portrait' => 'Porträt',
        'Square' => 'Quadratisch',
      },
    },
   'ImageProcessing' => {
      Description => 'Bildverarbeitung',
      PrintConv => {
        'Color Filter' => 'Farbfilter',
        'Cropped' => 'Beschnitten',
        'Digital Filter' => 'Digitalfilter',
        'Frame Synthesis?' => 'Rahmen?',
        'Unprocessed' => 'Unbearbeitet',
      },
    },
   'ImageProcessingCount' => 'Bildverarbeitungszähler',
   'ImageQuality' => {
      Description => 'Bildqualität',
      PrintConv => {
        'High' => 'Hoch',
      },
    },
   'ImageQuality2' => 'Bildqualität 2',
   'ImageReview' => {
      Description => 'Bildkontrolle',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ImageReviewTime' => 'Ausschaltzeit Bildkontrolle',
   'ImageRotated' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'ImageSize' => 'Bildgröße',
   'ImageStabilization' => {
      Description => 'Bildstabilisierung',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ImageTone' => {
      Description => 'Farbdynamik',
      PrintConv => {
        'Bright' => 'Leuchtend',
        'Landscape' => 'Landschaft',
        'Monochrome' => 'Monochrom',
        'Natural' => 'Natürlich',
        'Portrait' => 'Porträt',
      },
    },
   'ImageType' => 'Bildtyp',
   'ImageUniqueID' => 'Eindeutige Bild-ID',
   'ImageWidth' => 'Bildbreite',
   'InfoButtonWhenShooting' => {
      Description => 'INFO-Taste bei Aufnahme',
      PrintConv => {
        'Displays camera settings' => 'Anzeige Kameradaten',
        'Displays shooting functions' => 'Anzeige Aufnahmedaten',
      },
    },
   'InitialZoomSetting' => {
      Description => 'Erste Vergrößerungsstufe',
      PrintConv => {
        'High Magnification' => 'Starke Vergrößerung',
        'Low Magnification' => 'Geringe Vergrößerung',
        'Medium Magnification' => 'Mittlere Vergrößerung',
      },
    },
   'IntensityStereo' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'InternalFlash' => {
      Description => 'Integriertes Blitzgerät',
      PrintConv => {
        'Commander Mode' => 'Master-Steuerung',
        'Fired' => 'Blitz wurde ausgelöst',
        'Manual' => 'Manuell',
        'No' => 'Blitz wurde nicht ausgelöst',
        'Off' => 'Aus',
        'On' => 'Ein',
        'Repeating Flash' => 'Stroboskopblitz',
      },
    },
   'InternalFlashMode' => {
      Description => 'Slave-Blitz-Messfeld 2',
      PrintConv => {
        'Off, (Unknown 0xf4)' => 'Aus (Unbekannt 0xF4?)',
        'Off, Auto' => 'Aus, Auto',
        'Off, Auto, Red-eye reduction' => 'Aus, Auto, Rote-Augen-Reduzierung',
        'Off, Normal' => 'Aus, Normal',
        'Off, Red-eye reduction' => 'Aus, Rote-Augen-Reduzierung',
        'Off, Slow-sync' => 'Aus, Langzeit-Synchronisation',
        'Off, Slow-sync, Red-eye reduction' => 'Aus, Langzeit-Synchronisation, Rote-Augen-Reduzierung',
        'Off, Trailing-curtain Sync' => 'Aus, 2. Verschlussvorhang',
        'Off, Wireless (Control)' => 'Aus, Drahtlos (Steuerblitz)',
        'Off, Wireless (Master)' => 'Aus, Drahtlos (Hauptblitz)',
        'On' => 'Ein',
        'On, Auto' => 'Ein, Auto',
        'On, Auto, Red-eye reduction' => 'Ein, Auto, Rote-Augen-Reduzierung',
        'On, Red-eye reduction' => 'Ein, Rote-Augen-Reduzierung',
        'On, Slow-sync' => 'Ein, Langzeit-Synchronisation',
        'On, Slow-sync, Red-eye reduction' => 'Ein, Langzeit-Synchronisation, Rote-Augen-Reduzierung',
        'On, Trailing-curtain Sync' => 'Ein, 2. Verschlussvorhang',
        'On, Wireless (Control)' => 'Ein, Drahtlos (Steuerblitz)',
        'On, Wireless (Master)' => 'Ein, Drahtlos (Hauptblitz)',
        'n/a - Off-Auto-Aperture' => 'K/A - Blendenring nicht auf A',
      },
    },
   'InternalFlashStrength' => 'Slave-Blitz-Messfeld 4',
   'InternalSerialNumber' => 'Interne Seriennummer',
   'InteropIndex' => {
      Description => 'Interoperabilitäts-Identifikation',
      PrintConv => {
        'R03 - DCF option file (Adobe RGB)' => 'R03: DCF Option-Format (Adobe RGB)',
        'R98 - DCF basic file (sRGB)' => 'R98: DCF Basic-Format (sRGB)',
        'THM - DCF thumbnail file' => 'THM: DCF Miniaturbild-Format',
      },
    },
   'InteropVersion' => 'Interoperabilitäts-Version',
   'IntervalLength' => 'Intervallänge',
   'IntervalMode' => {
      Description => 'Interval-Modus',
      PrintConv => {
        'Still Image' => 'Standbild',
        'Time-lapse Movie' => 'Zeitraffer-Film',
      },
    },
   'IntervalNumber' => 'Intervalnummer',
   'JFIFVersion' => 'JFIF-Version',
   'JPEGQuality' => 'JPEG-Qualität',
   'JobID' => 'Job-ID',
   'JpgRecordedPixels' => 'JPEG-Auflösung',
   'Keywords' => 'Schlüsselwort',
   'LC1' => 'Objektiv-Wert',
   'LC10' => 'Mv\' nv\'-Daten',
   'LC11' => 'AVC 1/EXP-Wert',
   'LC12' => 'Mv1 Avminsif-Wert',
   'LC14' => 'UNT_12 UNT_6-Wert',
   'LC15' => 'Incorporated Flash Suited END-Wert',
   'LC2' => 'Entfernungscode',
   'LC3' => 'K-Wert',
   'LC4' => 'Wert für Aberrationskorrektur im Nahbereich',
   'LC5' => 'Wert für Aberrationskorrektur heller Farben',
   'LC6' => 'Wert für Aberrationskorrektur bei offener Blende',
   'LC7' => 'AF Minimum Actuation Condition-Wert',
   'LCDDisplayAtPowerOn' => {
      Description => 'LCD-Display bei Kamera Ein',
      PrintConv => {
        'Retain power off status' => 'Aus-Status beibehalten',
      },
    },
   'LCDDisplayReturnToShoot' => {
      Description => 'LC-Display->Zurück zur Aufn.',
      PrintConv => {
        'Also with * etc.' => 'Auch mit * etc.',
        'With Shutter Button only' => 'Nur mit Auslöser',
      },
    },
   'LCDIllumination' => {
      Description => 'Displaybeleuchtung',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'LCDIlluminationDuringBulb' => {
      Description => 'LCD-Beleuchtung bei Langzeitaufnahme',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'LCDPanels' => 'LCD oben/LCD Rückwand',
   'LCHEditor' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'LanguageIdentifier' => 'Sprachkennung',
   'LastFileNumber' => 'Letzte Dateinummer',
   'Lens' => 'Objektiv',
   'Lens35efl' => 'Objektiv',
   'LensAFStopButton' => {
      Description => 'Funktion Objektiv-AF-Stopptaste',
      PrintConv => {
        'AE lock' => 'AE-Speicherung',
        'AE lock while metering' => 'AE-Sperre b. aktiv. Messung',
        'AF Stop' => 'AF-Stopp',
        'AF point: M->Auto/Auto->ctr' => 'AF-Messf: M->Aut./Aut.->Ctr',
        'AF start' => 'AF-Start',
        'AF stop' => 'AF-Stopp',
        'IS start' => 'Start Bildstabilisierung',
        'Switch to registered AF point' => 'Auf gesp. AF-Messf. schalten',
      },
    },
   'LensDriveNoAF' => {
      Description => 'Schärfensuche wenn AF unmöglich',
      PrintConv => {
        'Focus search off' => 'Schärfensuche aus',
        'Focus search on' => 'Schärfensuche ein',
      },
    },
   'LensFStops' => 'Objektiv-Blendenstufen',
   'LensFirmwareVersion' => 'Objektiv-Firmware-Version',
   'LensKind' => 'Objektivtyp / Version (LC0)',
   'LensModel' => 'Objektiv-Typ',
   'LensProperties' => 'Objektivfunktionen?',
   'LensSerialNumber' => 'Objektiv-Seriennummer',
   'LensSpec' => 'Objektiv',
   'LensType' => 'Objektivtyp',
   'LicenseType' => {
      PrintConv => {
        'Unknown' => 'Unbekannt',
      },
    },
   'LightReading' => 'Helligkeitsauswertung',
   'LightSource' => {
      Description => 'Lichtquelle',
      PrintConv => {
        'Cloudy' => 'Bewölkt',
        'Cool White Fluorescent' => 'Kühle weiße Leuchtstofflampe',
        'Day White Fluorescent' => 'Tageslicht-Weiß Leuchtstofflampe',
        'Daylight' => 'Tageslicht',
        'Daylight Fluorescent' => 'Tageslicht-Leuchtstofflampe',
        'Fine Weather' => 'Unbewölkt',
        'Flash' => 'Blitz',
        'Fluorescent' => 'Fluoreszierend',
        'ISO Studio Tungsten' => 'ISO Studio-Kunstlicht (Glühbirne)',
        'Other' => 'Andere Lichtquelle',
        'Shade' => 'Schatten',
        'Standard Light A' => 'Standard-Licht A',
        'Standard Light B' => 'Standard-Licht B',
        'Standard Light C' => 'Standard-Licht C',
        'Tungsten' => 'Kunstlicht (Glühbirne)',
        'Unknown' => 'Unbekannt',
        'White Fluorescent' => 'Warme weiße Leuchtstofflampe',
      },
    },
   'LightSourceSpecial' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'LinearizationTable' => 'Linearisierungstabelle',
   'Lit' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'LiveViewExposureSimulation' => {
      Description => 'Livebild-Belichtungssimulator',
      PrintConv => {
        'Disable (LCD auto adjust)' => 'Inaktiv (automatische LCD-Anzeige)',
        'Enable (simulates exposure)' => 'Aktiv (simuliert Belichtung)',
      },
    },
   'LiveViewShooting' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'LocalizedCameraModel' => 'Lokalisiertes Kameramodell',
   'LockMicrophoneButton' => {
      Description => 'Mikrofone-Tastenfunktion',
      PrintConv => {
        'Protect (holding:sound rec.)' => 'Geschützt (drücken:Tonaufnahme)',
        'Sound rec. (protect:disable)' => 'Tonaufnahme (ungeschützt)',
      },
    },
   'LongExposureNoiseReduction' => {
      Description => 'Langzeit-Rauschminderung',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'LongFocal' => 'Größte Brennweite',
   'Luminance' => 'Luminanz',
   'LuminanceNoiseReduction' => {
      PrintConv => {
        'High' => 'Hoch',
        'Low' => 'Leicht',
        'Off' => 'Aus',
      },
    },
   'MB-D10Batteries' => {
      Description => 'Akku-/Batterietyp',
      PrintConv => {
        'FR6 (AA lithium)' => 'FR6 (Mignon, Lithium)',
        'HR6 (AA Ni-MH)' => 'HR6 (Mignon, NiMH)',
        'LR6 (AA alkaline)' => 'LR6 (Mignon, Alkaline)',
        'ZR6 (AA Ni-Mn)' => 'ZR6 (Mignon, NiMn)',
      },
    },
   'MB-D80Batteries' => {
      Description => '[32] Akku-/Batterietyp',
      PrintConv => {
        'FR6 (AA Lithium)' => 'FR6 (Mignon-Lithium)',
        'HR6 (AA Ni-MH)' => 'HR6 (Mignon-Ni-MH)',
        'LR6 (AA Alkaline)' => 'LR6 (Mignon-Alkaline)',
        'ZR6 (AA Ni-Mg)' => 'ZR6 (Mignon-Ni-Mg)',
      },
    },
   'MIEVersion' => 'MIE-Version',
   'MIMEType' => 'MIME-Typ',
   'MSStereo' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'Macro' => {
      Description => 'Makro',
      PrintConv => {
        'Macro' => 'Makro',
        'Manual' => 'Manuell',
        'Off' => 'Aus',
        'On' => 'Ein',
        'Super Macro' => 'Super-Makro',
      },
    },
   'MacroMode' => {
      Description => 'Makro-Modus',
      PrintConv => {
        'Macro' => 'Makro',
        'Off' => 'Aus',
        'On' => 'Ein',
        'Super Macro' => 'Super-Makro',
      },
    },
   'MagnifiedView' => {
      Description => 'Lupenfunktion',
      PrintConv => {
        'Image playback only' => 'Nur bei Bildwiedergabe',
        'Image review and playback' => 'Sofortbild u. Wiedergabe',
      },
    },
   'MainDialExposureComp' => {
      Description => 'Main Dial Belichtungskorrektur',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'Make' => 'Gerätehersteller',
   'MakeAndModel' => 'Hersteller und Modell',
   'MakerNoteSafety' => {
      Description => 'Sicherheit der Hersteller-Informationsdaten',
      PrintConv => {
        'Safe' => 'Sicher',
        'Unsafe' => 'Unsicher',
      },
    },
   'MakerNoteVersion' => 'MakerNote-Version',
   'ManometerPressure' => 'Gemessener Luft- bzw. Wasserdruck',
   'ManometerReading' => 'Berechnete Höhe oder Tauchtiefe',
   'ManualFlashOutput' => {
      Description => 'Manuelle Blitzstärke',
      PrintConv => {
        'Full' => 'Voll',
        'Low' => 'Gering',
        'Medium' => 'Mittel',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'ManualFocusDistance' => 'Manuelle Fokusdistanz',
   'ManualTv' => {
      Description => 'Man. Tv/Av-Einst. für M. Bel.',
      PrintConv => {
        'Tv=Control/Av=Main' => 'Tv=Schnelleinstellrad/Av=Haupt-Wahlrad',
        'Tv=Main/Av=Control' => 'Tv=Haupt-Wahlrad/Av=Schnelleinstellrad',
      },
    },
   'ManufactureDate' => 'Herstellungsdatum?',
   'MasterDocumentID' => 'ID des Originaldokuments',
   'MaxAperture' => 'Größte Blende',
   'MaxApertureAtCurrentFocal' => 'Größte Blende bei aktueller Brennweite',
   'MaxApertureAtMaxFocal' => 'Größte Blende bei größter Brennweite',
   'MaxApertureAtMinFocal' => 'Größte Blende bei geringster Brennweite',
   'MaxApertureValue' => 'Größtmögliche Blende',
   'MaxContinuousRelease' => 'Max. Bildanzahl pro Serie',
   'MaxFocalLength' => 'Größte Brennweite',
   'MeasuredEV' => 'Gemessener LW',
   'MeasurementGeometry' => {
      PrintConv => {
        '0/45 or 45/0' => '0/45 oder 45/0',
        '0/d or d/0' => '0/d oder d/0',
      },
    },
   'MediaBlackPoint' => 'Medium-Schwarzpunkt',
   'MediaWhitePoint' => 'Medium-Weißpunkt',
   'MenuButtonDisplayPosition' => {
      Description => 'Positionsanzeige Menuetaste',
      PrintConv => {
        'Previous' => 'Vorherige Anzeige',
        'Previous (top if power off)' => 'Vorherige (Anfang nach AUS)',
        'Top' => 'Anfang',
      },
    },
   'MenuButtonReturn' => {
      PrintConv => {
        'Previous' => 'Vorherige Anzeige',
        'Top' => 'Oben',
      },
    },
   'Metering' => {
      Description => 'Belichtungsmessung',
      PrintConv => {
        'Center-weighted' => 'Mittenbetont',
        'Matrix' => 'Matrixmessung',
        'Spot' => 'Spotmessung',
      },
    },
   'MeteringMode' => {
      Description => 'Belichtungsmessmethode',
      PrintConv => {
        'Average' => 'Durchschnitt',
        'Center-weighted average' => 'Mittenbetont',
        'Evaluative' => 'Mehrfeldmessung',
        'Multi-segment' => 'Multi-Segment',
        'Other' => 'Andere',
        'Partial' => 'Teilbild',
        'Spot' => 'Spotmessung',
        'Unknown' => 'Unbekannt',
      },
    },
   'MeteringMode2' => {
      Description => 'Belichtungs-Messmethode 2',
      PrintConv => {
        'Multi-segment' => 'Multi-Segment',
      },
    },
   'MeteringMode3' => {
      Description => 'Belichtungs-Messmethode (3)',
      PrintConv => {
        'Multi-segment' => 'Multi-Segment',
      },
    },
   'MeteringTime' => 'Ausschaltzeit Belichtungsmesser',
   'MinAperture' => 'Kleinste Blende',
   'MinFocalLength' => 'Geringste Brennweite',
   'MinoltaCameraSettings2' => 'Kameraeinstellungen 2',
   'MinoltaDate' => 'Minolta-Datum',
   'MinoltaImageSize' => {
      Description => 'Minolta-Bildgröße',
      PrintConv => {
        'Full' => 'Volle Größe',
        'Large' => 'Groß',
        'Medium' => 'Mittelgroß',
        'Small' => 'Klein',
      },
    },
   'MinoltaModelID' => 'Minolta-Modell',
   'MinoltaQuality' => {
      Description => 'Minolta-Bildqualität',
      PrintConv => {
        'Extra Fine' => 'Extra-Fein',
        'Fine' => 'Fein',
        'Super Fine' => 'Super-Fein',
        'Superfine' => 'Superfein',
      },
    },
   'MinoltaTime' => 'Minolta-Zeit',
   'MirrorLockup' => {
      Description => 'Spiegelverriegelung',
      PrintConv => {
        'Disable' => 'Ausgeschaltet',
        'Enable' => 'Eingeschaltet',
        'Enable: Down with Set' => 'Eingeschaltet: Abwärts mit SET (Taste)',
      },
    },
   'Model' => 'Kameramodell',
   'Model2' => 'Kameramodell (2)',
   'ModelingFlash' => {
      Description => 'Einstelllicht',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ModifiedPictureStyle' => {
      PrintConv => {
        'Landscape' => 'Landschaft',
        'Monochrome' => 'Monochrom',
        'None' => 'Keine',
        'Portrait' => 'Porträt',
      },
    },
   'ModifiedSaturation' => {
      PrintConv => {
        'Off' => 'Aus',
      },
    },
   'ModifiedSharpnessFreq' => {
      PrintConv => {
        'High' => 'Hoch',
        'Highest' => 'Höchste',
        'Low' => 'Leicht',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'ModifiedToneCurve' => {
      PrintConv => {
        'Custom' => 'Benutzerdefiniert',
        'Manual' => 'Manuell',
      },
    },
   'ModifiedWhiteBalance' => {
      PrintConv => {
        'Auto' => 'Automatisch',
        'Black & White' => 'Schwarz/Weiß',
        'Cloudy' => 'Bewölkt',
        'Custom' => 'Benutzerdefiniert',
        'Custom 1' => 'Benutzerdefiniert 1',
        'Custom 2' => 'Benutzerdefiniert 2',
        'Custom 3' => 'Benutzerdefiniert 3',
        'Custom 4' => 'Benutzerdefiniert 4',
        'Daylight' => 'Tageslicht',
        'Daylight Fluorescent' => 'Tageslicht-Leuchtstofflampe',
        'Flash' => 'Blitz',
        'Fluorescent' => 'Fluoreszierend',
        'Manual Temperature (Kelvin)' => 'Manuelle Temperatur (Kelvin)',
        'Shade' => 'Schatten',
        'Tungsten' => 'Kunstlicht (Glühbirne)',
        'Underwater' => 'Tauchen',
      },
    },
   'ModifyDate' => 'Dateiänderungsdatum',
   'MoireFilter' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'MonitorOffTime' => 'Ausschaltzeit des Monitors',
   'MonochromeFilterEffect' => {
      PrintConv => {
        'Green' => 'Grün',
        'None' => 'Keine',
        'Red' => 'Rot',
        'Yellow' => 'Gelb',
      },
    },
   'MonochromeLinear' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'MonochromeToningEffect' => {
      PrintConv => {
        'Blue' => 'Blau',
        'Green' => 'Grün',
        'None' => 'Keine',
        'Purple' => 'Lila',
      },
    },
   'MultiExposureAutoGain' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'MultiExposureMode' => {
      PrintConv => {
        'Off' => 'Aus',
      },
    },
   'MultiSelector' => {
      Description => '[f2] Multifunktionswähler',
      PrintConv => {
        'Do Nothing' => 'Ohne Funktion',
        'Reset Meter-off Delay' => 'Ruhezustand verzögern',
      },
    },
   'MultiSelectorPlaybackMode' => {
      Description => 'Mitteltaste > Bei Wiedergabe',
      PrintConv => {
        'Choose Folder' => 'Ordner auswählen',
        'Thumbnail On/Off' => 'Bildindex ein/aus',
        'View Histograms' => 'Histogramme anzeigen',
        'Zoom On/Off' => 'Ausschnitt ein/aus',
      },
    },
   'MultiSelectorShootMode' => {
      Description => 'Mitteltaste > Bei Aufnahme',
      PrintConv => {
        'Highlight Active Focus Point' => 'AF-Messfeld hervorheben',
        'Not Used' => 'Ohne Funktion',
        'Select Center Focus Point' => 'Mittleres AF-Messfeld',
      },
    },
   'MultipleExposureSet' => {
      Description => 'Mehrfachbelichtung',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'Mute' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'MyColorMode' => {
      PrintConv => {
        'B&W' => 'Schwarz-Weiß',
        'Custom' => 'Benutzerdefiniert',
        'Off' => 'Aus',
      },
    },
   'NDFilter' => {
      Description => 'ND-Filter',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'NEFCompression' => {
      PrintConv => {
        'Uncompressed' => 'Nicht komprimiert',
      },
    },
   'NewsPhotoVersion' => 'IPTC-Modell-3-Version',
   'NikonCaptureVersion' => 'Nikon Capture-Version',
   'NikonICCProfile' => 'Nikon ICC-Profil-Zeiger',
   'NoMemoryCard' => {
      Description => 'Auslösesperre',
      PrintConv => {
        'Enable Release' => 'Aus',
        'Release Locked' => 'Ein',
      },
    },
   'Noise' => 'Bildrauschen',
   'NoiseFilter' => {
      PrintConv => {
        'High' => 'Hoch',
        'Low' => 'Leicht',
        'Off' => 'Aus',
      },
    },
   'NoiseReduction' => {
      Description => 'Rauschreduktion',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Low' => 'Gering',
        'Off' => 'Aus',
        'On' => 'Ein',
        'On 1' => 'Ein (Modus 1)',
        'On 2' => 'Ein (Modus 2)',
      },
    },
   'NominalMaxAperture' => 'Nominaler AVmin',
   'NominalMinAperture' => 'Nominaler AVmax',
   'NumAFPoints' => 'Anzahl der AF-Punkte',
   'ObjectAttributeReference' => 'Gattung',
   'ObjectCycle' => {
      Description => 'Objektzyklus',
      PrintConv => {
        'Both Morning and Evening' => 'Beides',
        'Evening' => 'Abends',
        'Morning' => 'Morgens',
      },
    },
   'ObjectFileType' => {
      PrintConv => {
        'None' => 'Keine',
        'Unknown' => 'Unbekannt',
      },
    },
   'ObjectName' => 'Titel',
   'ObjectPreviewData' => 'Objektdatenvorschau',
   'ObjectPreviewFileFormat' => 'Dateiformat der Objektdatenvorschau',
   'ObjectPreviewFileVersion' => 'Dateiformatversion der Objektdatenvorschau',
   'ObjectTypeReference' => 'Objekttypreferenz',
   'OffsetSchema' => 'Offset-Schema',
   'OldSubfileType' => 'Unterdatei-Typ',
   'OneTouchWB' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'An',
        'On (Preset)' => 'An (Preset)',
      },
    },
   'OpticalZoomCode' => 'Optischer Zoom-Code',
   'OpticalZoomOn' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'Opto-ElectricConvFactor' => 'Optoelektronischer Umrechnungsfaktor',
   'OrderNumber' => 'Auftragsnummer',
   'Orientation' => {
      Description => 'Ausrichtung des Bildes',
      PrintConv => {
        'Horizontal (normal)' => '0° (oben/links)',
        'Mirror horizontal' => 'Horizontal gespiegelt',
        'Mirror horizontal and rotate 270 CW' => 'Horizontal gespiegelt und 90° gegen den Uhrzeigersinn gedreht',
        'Mirror horizontal and rotate 90 CW' => 'Horizontal gespiegelt und 90° im Uhrzeigersinn gedreht',
        'Mirror vertical' => 'Vertikal gespiegelt',
        'Rotate 180' => '180° (unten/rechts)',
        'Rotate 270 CW' => '90° im Uhrzeigersinn (links/unten)',
        'Rotate 90 CW' => '90° gegen den Uhrzeigersinn (rechts/oben)',
      },
    },
   'OriginalRawFileData' => 'Original Raw Daten',
   'OriginalRawFileName' => 'Original Raw Dateiname',
   'OriginalTransmissionReference' => 'Jobkennung',
   'OriginatingProgram' => 'Erstellungsprogramm',
   'OwnerID' => 'Besitzer-ID',
   'OwnerName' => 'Name des Besitzers',
   'PEFVersion' => 'PEF-Version',
   'Padding' => 'Platzhalter',
   'PageName' => 'Seitenname',
   'PageNumber' => 'Seitenummer',
   'PanasonicTitle' => 'Titel',
   'PanoramaDirection' => 'Panorama-Richtung',
   'PanoramaFrameNumber' => 'Panorama-Bild',
   'PentaxImageSize' => {
      Description => 'Pentax-Bildgröße',
      PrintConv => {
        '2304x1728 or 2592x1944' => '2304 x 1728 oder 2592 x 1944',
        '2560x1920 or 2304x1728' => '2560 x 1920 oder 2304 x 1728',
        '2816x2212 or 2816x2112' => '2816 x 2212 oder 2816 x 2112',
        '3008x2008 or 3040x2024' => '3008 x 2008 oder 3040 x 2024',
        'Full' => 'Voll',
      },
    },
   'PentaxModelID' => 'Pentax-Modell',
   'PentaxVersion' => 'Pentax-Version',
   'PhotoEffect' => {
      Description => 'Foto-Effekt',
      PrintConv => {
        'B&W' => 'Schwarz-Weiß',
        'Custom' => 'Benutzerdefiniert',
        'Off' => 'Aus',
      },
    },
   'PhotoEffects' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'PhotoEffectsType' => {
      Description => 'Bildeffekt-Methode',
      PrintConv => {
        'B&W' => 'Schwarz-Weiß',
        'None' => 'Keine',
        'Tinted' => 'Getont',
      },
    },
   'PhotoInfoPlayback' => {
      Description => 'Bildinfos & Wiedergabe',
      PrintConv => {
        'Info Left-right, Playback Up-down' => 'Info <> / Wiedergabe',
        'Info Up-down, Playback Left-right' => 'Info / Wiedergabe <>',
      },
    },
   'PhotometricInterpretation' => {
      Description => 'Pixel-Schema',
      PrintConv => {
        'BlackIsZero' => 'Schwarz ist Null',
        'Color Filter Array' => 'CFA (Farbfiltermatrix)',
        'Pixar LogL' => 'CIE Log2(L) (Log Luminanz)',
        'Pixar LogLuv' => 'CIE Log2(L)(u\',v\') (Log Luminanz und Chrominanz)',
        'Transparency Mask' => 'Transparenzmaske',
        'WhiteIsZero' => 'Weiß ist Null',
      },
    },
   'PictureControl' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'PictureControlActive' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'PictureControlAdjust' => {
      Description => 'Bildoptimierung-Anpassung',
      PrintConv => {
        'Default Settings' => 'Standardeinstellungen',
        'Full Control' => 'Manuelle Einstellung',
        'Quick Adjust' => 'Schnelleinstellung',
      },
    },
   'PictureControlQuickAdjust' => 'Bildoptimierung-Schnelleinstellung',
   'PictureFinish' => {
      PrintConv => {
        'Evening Scene' => 'Abendszene',
        'Monochrome' => 'Monochrom',
        'Natural' => 'Natürlich',
        'Night Portrait' => 'Nachtporträt',
        'Night Scene' => 'Nachtszene',
        'Portrait' => 'Porträt',
        'Wind Scene' => 'Windszene',
      },
    },
   'PictureMode' => {
      Description => 'Motivprogramm',
      PrintConv => {
        '1/2 EV steps' => '1/2 LW Schritte',
        '1/3 EV steps' => '1/3 LW Schitte',
        'Anti-blur' => 'Motivschärfe-Modus',
        'Aperture Priority' => 'Zeitautomatik',
        'Aperture Priority, Off-Auto-Aperture' => 'Zeitautomatik (Blendenring nicht auf A)',
        'Aperture-priority AE' => 'Blendenpriorität',
        'Auto' => 'Automatisch',
        'Auto PICT (Landscape)' => 'Auto PICT (Landschaft)',
        'Auto PICT (Macro)' => 'Auto PICT (Makro)',
        'Auto PICT (Portrait)' => 'Auto PICT (Porträt)',
        'Auto PICT (Sport)' => 'Auto PICT (Motiv in Bewegung)',
        'Auto PICT (Standard)' => 'Auto PICT (Normal)',
        'Autumn' => 'Herbst',
        'Beach' => 'Strand',
        'Beach & Snow' => 'Strand & Schnee',
        'Blur Reduction' => 'Digital SR (Unschärfereduktion)',
        'Bulb' => 'Bulb-Modus',
        'Bulb, Off-Auto-Aperture' => 'Bulb (Blendenring nicht auf A)',
        'Candlelight' => 'Kerzenlicht',
        'DOF Program' => 'Schärfentiefe-Priorität',
        'DOF Program (HyP)' => 'Schärfentiefe-Priorität (Hyper-Programm)',
        'Dark Pet' => 'Haustier (Dunkel)',
        'Digital Filter' => 'Digitalfilter',
        'Fireworks' => 'Feuerwerk',
        'Flash X-Sync Speed AE' => 'Blitz X-synch. Zeit',
        'Flower' => 'Blumen',
        'Food' => 'Lebensmittel',
        'Frame Composite' => 'Rahmen',
        'Green Mode' => 'Grüner Modus',
        'Half-length Portrait' => 'Brustbild',
        'Hi-speed Program' => 'HS-Priorität',
        'Hi-speed Program (HyP)' => 'HS-Priorität (Hyper-Programm)',
        'Illustrations' => 'Dokument',
        'Kids' => 'Kinder',
        'Landscape' => 'Landschaft',
        'Light Pet' => 'Haustier (Hell)',
        'MTF Program' => 'MTF-Priorität',
        'MTF Program (HyP)' => 'MTF-Priorität (Hyper-Programm)',
        'Macro' => 'Makro',
        'Manual' => 'Manuell',
        'Manual, Off-Auto-Aperture' => 'Manuell (Blendenring nicht auf A)',
        'Medium Pet' => 'Haustier (Neutrale Helligkeit)',
        'Natural Light' => 'Umgebungslicht',
        'Natural Light & Flash' => 'Umgebungslicht & Blitz',
        'Natural Skin Tone' => 'Nat. Hautton',
        'Night Scene' => 'Nachtszene',
        'Night Scene Portrait' => 'Nacht-Porträt',
        'No Flash' => 'Kein Blitz',
        'Pet' => 'Haustier',
        'Portrait' => 'Porträt',
        'Program' => 'Programm',
        'Program (HyP)' => 'Programmautomatik (Hyper-Programm)',
        'Program AE' => 'Programmautomatik',
        'Program Av Shift' => 'Av Shift-Belichtungsprogramm',
        'Program Tv Shift' => 'Tv Shift-Belichtungsprogramm',
        'Self Portrait' => 'Selbstporträt',
        'Sensitivity Priority AE' => 'Blenden- & Zeitautomatik (Sv, ISO-Vorgabe)',
        'Shutter & Aperture Priority AE' => 'Empfindlichkeitsautomatik (TAv, Zeit-/Blendenvorgabe)',
        'Shutter Speed Priority' => 'Verschlusspriorität',
        'Shutter speed priority AE' => 'Verschlusspriorität',
        'Snow' => 'Schnee',
        'Soft' => 'Soft (Weichzeichnung)',
        'Sports' => 'Sport',
        'Sunset' => 'Sonnenuntergang',
        'Surf & Snow' => 'Surf + Schnee',
        'Synchro Sound Record' => 'Synchr. Sprachnotiz',
        'Underwater' => 'Tauchen',
      },
    },
   'PictureMode2' => {
      Description => 'Motivprogramm 2',
      PrintConv => {
        'Aperture Priority' => 'Blendenpriorität',
        'Aperture Priority, Off-Auto-Aperture' => 'Zeitautomatik (Blendenring nicht auf A)',
        'Bulb' => 'Bulb-Modus',
        'Bulb, Off-Auto-Aperture' => 'Bulb (Blendenring nicht auf A)',
        'Flash X-Sync Speed AE' => 'Blitz X-synch. Zeit',
        'Green Mode' => '"Grünes" AE-Programm',
        'Manual' => 'Manuell',
        'Manual, Off-Auto-Aperture' => 'Manuell (Blendenring nicht auf A)',
        'Program AE' => 'Programmautomatik',
        'Program Av Shift' => 'Av Shift-Belichtungsprogramm',
        'Program Tv Shift' => 'Tv Shift-Belichtungsprogramm',
        'Scene Mode' => 'Motivprogramm',
        'Sensitivity Priority AE' => 'Blenden- & Zeitautomatik (Sv, ISO-Vorgabe)',
        'Shutter & Aperture Priority AE' => 'Empfindlichkeitsautomatik (TAv, Zeit-/Blendenvorgabe)',
        'Shutter Speed Priority' => 'Verschlusspriorität',
      },
    },
   'PictureModeBWFilter' => {
      PrintConv => {
        'Green' => 'Grün',
        'Red' => 'Rot',
        'Yellow' => 'Gelb',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'PictureModeTone' => {
      PrintConv => {
        'Blue' => 'Blau',
        'Green' => 'Grün',
        'Purple' => 'Lila',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'PictureStyle' => {
      PrintConv => {
        'Faithful' => 'Natürlich',
        'High Saturation' => 'Hohe Farbsättigung',
        'Landscape' => 'Landschaft',
        'Low Saturation' => 'Geringe Farbsättigung',
        'Monochrome' => 'Monochrom',
        'None' => 'Keine',
        'Portrait' => 'Porträt',
      },
    },
   'PixelFormat' => {
      Description => 'Pixel-Format',
      PrintConv => {
        'Black & White' => 'Schwarz/Weiß',
      },
    },
   'PixelUnits' => {
      PrintConv => {
        'Unknown' => 'Unbekannt',
      },
    },
   'PlanarConfiguration' => 'Bilddatenausrichtung',
   'PowerSource' => {
      Description => 'Stromquelle',
      PrintConv => {
        'Body Battery' => 'Batterie im Body',
        'External Power Supply' => 'Externe Stromversorgung',
        'Grip Battery' => 'Batterie im Griff',
      },
    },
   'Predictor' => {
      Description => 'Prädiktor',
      PrintConv => {
        'Horizontal differencing' => 'Horizontale Differenzierung',
        'None' => 'Kein Prädiktor-Schema in Benutzung',
      },
    },
   'Preview0' => 'Vorschau 0',
   'Preview1' => 'Vorschau 1',
   'Preview2' => 'Vorschau 2',
   'PreviewColorSpace' => {
      PrintConv => {
        'Unknown' => 'Unbekannt',
      },
    },
   'PreviewHeight' => 'Vorschaubild-Höhe',
   'PreviewImage' => 'Vorschaubild',
   'PreviewImageBorders' => 'Vorschaubild-Ränder',
   'PreviewImageHeight' => 'Vorschaubild-Höhe',
   'PreviewImageLength' => 'Vorschaubild-Datenlänge',
   'PreviewImageSize' => 'Vorschaubild-Größe',
   'PreviewImageStart' => 'Vorschaubild-Datenposition',
   'PreviewImageValid' => {
      Description => 'Vorschaubild gültig',
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'PreviewImageWidth' => 'Vorschaubild-Breite',
   'PreviewQuality' => {
      Description => 'Vorschaubild-Qualität',
      PrintConv => {
        'Fine' => 'Fein',
        'Superfine' => 'Superfein',
      },
    },
   'PreviewWidth' => 'Vorschaubild-Breite',
   'PrimaryAFPoint' => 'Primärer AF-Punkt',
   'PrimaryChromaticities' => 'Chromatizität der Primärfarben',
   'PrimaryPlatform' => 'Hauptplattform',
   'ProcessingSoftware' => 'Verarbeitungssoftware',
   'ProductID' => 'Produkt-ID',
   'ProductionCode' => 'Kamera war beim Kundendienst?',
   'ProfileCMMType' => 'Profil CMM-Typ',
   'ProfileClass' => {
      Description => 'Profil-Klasse',
      PrintConv => {
        'Abstract Profile' => 'Abstract-Profil',
        'ColorSpace Conversion Profile' => 'Farbraum-Konvertierungsprofile',
        'DeviceLink Profile' => 'DeviceLink-Profil',
        'Display Device Profile' => 'Bildschirm-Geräteprofil',
        'Input Device Profile' => 'Eingabe-Geräteprofil',
        'NamedColor Profile' => 'Named Color-Profil',
        'Nikon Input Device Profile (NON-STANDARD!)' => 'Nikon-Profil ("nkpf")',
        'Output Device Profile' => 'Ausgabe-Geräteprofil',
      },
    },
   'ProfileConnectionSpace' => 'Profil-Verbindungsfarbraum',
   'ProfileCopyright' => 'Urheberrechtsvermerk',
   'ProfileCreator' => 'Profil-Ersteller',
   'ProfileDateTime' => 'Profil-Erstellungszeit',
   'ProfileDescription' => 'Profil-Beschreibung',
   'ProfileDescriptionML' => 'Profil-Beschreibung ML',
   'ProfileFileSignature' => 'Profil-Datei-Signatur',
   'ProfileID' => 'Profile-ID',
   'ProfileSequenceDesc' => 'Profilsequenz-Beschreibung',
   'ProfileVersion' => 'Profil-Version',
   'ProgramLine' => {
      Description => 'Belichtungsprogrammtyp',
      PrintConv => {
        'Depth' => 'Schärfentiefe-Priorität',
        'Hi Speed' => 'HS-Priorität',
        'MTF' => 'MTF-Priorität',
      },
    },
   'ProgramMode' => {
      PrintConv => {
        'Night Portrait' => 'Nachtporträt',
        'None' => 'Keine',
        'Portrait' => 'Porträt',
        'Sports' => 'Sport',
        'Sunset' => 'Sonnenuntergang',
      },
    },
   'ProgramShift' => 'Programmverschiebung',
   'ProgramVersion' => 'Programmversion',
   'Protect' => 'Schutz',
   'Province-State' => 'Bundesland/Kanton',
   'Quality' => {
      Description => 'Bildqualität',
      PrintConv => {
        'Best' => 'Optimal',
        'Better' => 'Besser',
        'Compressed RAW' => 'Komprimiertes RAW',
        'Compressed RAW + JPEG' => 'Komprimiertes RAW + JPEG',
        'Extra Fine' => 'Extra-Fein',
        'Fine' => 'Fein',
        'Good' => 'Gut',
        'High' => 'Hoch',
        'Low' => 'Leicht',
        'Super Fine' => 'Super-Fein',
        'Superfine' => 'Superfein',
      },
    },
   'QualityMode' => {
      PrintConv => {
        'Fine' => 'Fein',
      },
    },
   'QuickControlDialInMeter' => {
      Description => 'Schnelleinstellrad bei Messung',
      PrintConv => {
        'AF point selection' => 'Auswahl des AF-Messfelds',
        'Exposure comp/Aperture' => 'Belichtungskorrektur/Blende',
        'ISO speed' => 'ISO-Empfindlichkeit',
      },
    },
   'QuickShot' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'RAFVersion' => 'RAF-Version',
   'RasterizedCaption' => 'Rasterbeschreibung',
   'Rating' => 'Bewertung',
   'RatingPercent' => 'Bewertung in Prozent',
   'RawAndJpgRecording' => {
      Description => 'Dateiformat und JPEG-Qualität',
      PrintConv => {
        'JPEG (Best)' => 'JPEG (Optimal)',
        'JPEG (Better)' => 'JPEG (Besser)',
        'JPEG (Good)' => 'JPEG (Gut)',
        'RAW (DNG, Best)' => 'RAW (DNG, Optimal)',
        'RAW (DNG, Better)' => 'RAW (DNG, Besser)',
        'RAW (DNG, Good)' => 'RAW (DNG, Gut)',
        'RAW (PEF, Best)' => 'RAW (PEF, Optimal)',
        'RAW (PEF, Better)' => 'RAW (PEF, Besser)',
        'RAW (PEF, Good)' => 'RAW (PEF, Gut)',
        'RAW+JPEG (DNG, Best)' => 'RAW+JPEG (DNG, Optimal)',
        'RAW+JPEG (DNG, Better)' => 'RAW+JPEG (DNG, Besser)',
        'RAW+JPEG (DNG, Good)' => 'RAW+JPEG (DNG, Gut)',
        'RAW+JPEG (PEF, Best)' => 'RAW+JPEG (PEF, Optimal)',
        'RAW+JPEG (PEF, Better)' => 'RAW+JPEG (PEF, Besser)',
        'RAW+JPEG (PEF, Good)' => 'RAW+JPEG (PEF, Gut)',
        'RAW+Large/Fine' => 'RAW+Groß/Fein',
        'RAW+Large/Normal' => 'RAW+Groß/Normal',
        'RAW+Medium/Fine' => 'RAW+Mittel/Fein',
        'RAW+Medium/Normal' => 'RAW+Mittel/Normal',
        'RAW+Small/Fine' => 'RAW+Klein/Fein',
        'RAW+Small/Normal' => 'RAW+Klein/Normal',
      },
    },
   'RawColorAdj' => {
      PrintConv => {
        'Custom' => 'Benutzerdefiniert',
      },
    },
   'RawDevAutoGradation' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'RawDevPMPictureTone' => {
      PrintConv => {
        'Blue' => 'Blau',
        'Green' => 'Grün',
        'Purple' => 'Lila',
      },
    },
   'RawDevPM_BWFilter' => {
      PrintConv => {
        'Green' => 'Grün',
        'Red' => 'Rot',
        'Yellow' => 'Gelb',
      },
    },
   'RawDevPictureMode' => {
      PrintConv => {
        'Natural' => 'Natürlich',
      },
    },
   'RawDevWhiteBalance' => {
      PrintConv => {
        'Color Temperature' => 'Farbtemperatur',
      },
    },
   'RawImageCenter' => 'RAW-Bildmitte',
   'RawImageSize' => 'RAW-Bildgröße',
   'RawJpgQuality' => {
      Description => 'RAW JPEG-Qualität',
      PrintConv => {
        'Fine' => 'Fein',
        'Superfine' => 'Superfein',
      },
    },
   'RawJpgSize' => {
      Description => 'RAW JPEG-Größe',
      PrintConv => {
        'Large' => 'Groß',
        'Medium' => 'Mittelgroß',
        'Medium 1' => 'Mittelgroß 1',
        'Medium 2' => 'Mittelgroß 2',
        'Medium 3' => 'Mittelgroß 3',
        'Medium Movie' => 'Mittelgroßer Film',
        'Postcard' => 'Postkarte',
        'Small' => 'Klein',
        'Small Movie' => 'Kleiner Film',
        'Widescreen' => 'Breitbild',
      },
    },
   'RawLinear' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'RecordMode' => {
      Description => 'Dateityp',
      PrintConv => {
        'Aperture Priority' => 'Blendenpriorität',
        'Manual' => 'Manuell',
        'Shutter Priority' => 'Verschlusspriorität',
      },
    },
   'RecordingMode' => {
      PrintConv => {
        'Auto' => 'Automatisch',
        'Landscape' => 'Landschaft',
        'Manual' => 'Manuell',
        'Night Scene' => 'Nachtszene',
        'Portrait' => 'Porträt',
      },
    },
   'RedBalance' => 'Rot-Balance',
   'RedEyeCorrection' => {
      PrintConv => {
        'Automatic' => 'Automatisch',
        'Off' => 'Aus',
      },
    },
   'RedEyeReduction' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'RedMatrixColumn' => 'Rot-Matrixspalte',
   'RedTRC' => 'Rot-Tonwertwiedergabe-Kurve',
   'ReductionMatrix1' => 'Reduktionsmatrix 1',
   'ReductionMatrix2' => 'Reduktionsmatrix 2',
   'ReferenceBlackWhite' => 'Schwarz/Weiß-Referenzpunkte',
   'ReferenceDate' => 'Referenzdatum',
   'ReferenceNumber' => 'Referenznummer',
   'ReferenceService' => 'Referenzdienst',
   'RelatedImageFileFormat' => 'Dateiformat der Bilddaten',
   'RelatedImageHeight' => 'Bildhöhe',
   'RelatedImageWidth' => 'Bildbreite',
   'RelatedSoundFile' => 'Zugehörige Audio-Datei',
   'ReleaseButtonToUseDial' => {
      Description => 'Tastenverhalten',
      PrintConv => {
        'No' => 'Gedrückt halten',
        'Yes' => 'Ein & aus',
      },
    },
   'ReleaseDate' => 'Veröffentlichungsdatum',
   'ReleaseTime' => 'Veröffentlichungszeit',
   'RemoteOnDuration' => 'Fernauslöser',
   'RenderingIntent' => {
      Description => 'Umrechnungsmethode',
      PrintConv => {
        'ICC-Absolute Colorimetric' => 'Absolut farbmetrisch',
        'Media-Relative Colorimetric' => 'Relativ farbmetrisch',
        'Perceptual' => 'Wahrnehmungsorientiert (perzeptiv, fotografisch)',
        'Saturation' => 'Sättigungserhaltend',
      },
    },
   'RepeatingFlashCount' => 'Stroboskopblitz > Anzahl',
   'RepeatingFlashOutput' => 'Stroboskopblitz Leistung',
   'RepeatingFlashRate' => 'Stroboskopblitz > Freq.',
   'ResampleParamsQuality' => {
      PrintConv => {
        'High' => 'Hoch',
        'Low' => 'Leicht',
      },
    },
   'Resaved' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'Resolution' => 'Bildauflösung',
   'ResolutionUnit' => {
      Description => 'Einheit der X- und Y-Auflösung',
      PrintConv => {
        'None' => 'Keine',
      },
    },
   'RetouchHistory' => {
      Description => 'Bildbearbeitungsschritte',
      PrintConv => {
        'B & W' => 'Schwarzweiß',
        'Color Custom' => 'Farbabgleich',
        'Cyanotype' => 'Blauton',
        'Image Overlay' => 'Bildmontage',
        'None' => 'Keine',
        'Red Eye' => 'Rote-Augen-Korrektur',
        'Sky Light' => 'Skylight',
        'Small Picture' => 'Kompaktbild',
        'Trim' => 'Beschneiden',
        'Warm Tone' => 'Warmer Farbton',
      },
    },
   'ReverseIndicators' => 'Skalen spiegeln',
   'Rotation' => {
      Description => 'Ausrichtung',
      PrintConv => {
        'Horizontal' => '0° (oben/links)',
        'Horizontal (Normal)' => '0° (oben/links)',
        'Horizontal (normal)' => '0° (oben/links)',
        'Rotate 180' => '180° (unten/rechts)',
        'Rotate 270 CW' => '90° im Uhrzeigersinn (links/unten)',
        'Rotate 90 CW' => '90° gegen den Uhrzeigersinn (rechts/oben)',
        'Rotated 180' => '180° (unten/rechts)',
        'Rotated 270 CW' => '90° im Uhrzeigersinn (links/unten)',
        'Rotated 90 CW' => '90° gegen den Uhrzeigersinn (rechts/oben)',
      },
    },
   'RowsPerStrip' => 'Anzahl der Bild-Zeilen',
   'SPIFFVersion' => 'SPIFF-Version',
   'SRAWQuality' => {
      PrintConv => {
        'n/a' => 'Nicht gesetzt',
      },
    },
   'SRActive' => {
      Description => 'Bildstabilisator',
      PrintConv => {
        'No' => 'Deaktiviert',
        'Yes' => 'Aktiviert',
      },
    },
   'SRFocalLength' => 'SR Brennweite',
   'SRHalfPressTime' => 'Auslöseverzögerung',
   'SRResult' => {
      Description => 'Bildstabilisator',
      PrintConv => {
        'Not stabilized' => 'Nicht stabilisiert',
      },
    },
   'SVGVersion' => 'SVG-Version',
   'SafetyShift' => {
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable (ISO speed)' => 'Möglich (ISO Empfindlichkeit)',
        'Enable (Tv/Av)' => 'Möglich (Tv/Av)',
      },
    },
   'SafetyShiftInAvOrTv' => {
      Description => 'Safety Shift in AV oder TV',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'SampleFormat' => {
      PrintConv => {
        'Complex integer' => 'Komplexer Integer',
        'IEEE floating point' => 'Fließkommawert',
        'Two\'s complement signed integer' => 'Vorzeichenbehafteter Integer',
        'Undefined' => 'Nicht definiert',
        'Unsigned integer' => 'Vorzeichenloser Integer',
      },
    },
   'SamplesPerPixel' => 'Anzahl der Komponenten',
   'Saturation' => {
      Description => 'Farbsättigung',
      PrintConv => {
        'Film Simulation' => 'Film-Simulation',
        'High' => 'Hohe Farbsättigung',
        'Low' => 'Geringe Farbsättigung',
        'Med High' => 'Leicht erhöht',
        'Med Low' => 'Leicht verringert',
        'Medium High' => 'Mittel-Hoch',
        'Medium Low' => 'Mittel-Gering',
        'None' => 'Nicht gesetzt',
        'None (B&W)' => 'Keine (S&W)',
        'Normal' => 'Standard',
        'Very High' => 'Sehr hoch',
        'Very Low' => 'Sehr gering',
      },
    },
   'ScanImageEnhancer' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'SceneAssist' => 'Szenen-Assistent',
   'SceneCaptureType' => {
      Description => 'Szenenaufnahmetyp',
      PrintConv => {
        'Landscape' => 'Landschaft',
        'Night' => 'Nachtszene',
        'Portrait' => 'Porträt',
      },
    },
   'SceneMode' => {
      Description => 'Szenen-Modus',
      PrintConv => {
        'Aperture Priority' => 'Blendenpriorität',
        'Auto' => 'Automatisch',
        'Beach' => 'Strand',
        'Candlelight' => 'Kerzenlicht',
        'Fireworks' => 'Feuerwerk',
        'Landscape' => 'Landschaft',
        'Macro' => 'Makro',
        'Manual' => 'Manuell',
        'Night Portrait' => 'Nachtporträt',
        'Night Scene' => 'Nachtszene',
        'Night View/Portrait' => 'Abendszene/Nachtporträt',
        'Off' => 'Aus',
        'Portrait' => 'Porträt',
        'Program' => 'Programm',
        'Shutter Priority' => 'Verschlusspriorität',
        'Snow' => 'Schnee',
        'Sports' => 'Sport',
        'Spot' => 'Spotmessung',
        'Sunset' => 'Sonnenuntergang',
        'Super Macro' => 'Super-Makro',
        'Underwater' => 'Tauchen',
      },
    },
   'SceneModeUsed' => {
      Description => 'Szenen-Modus',
      PrintConv => {
        'Aperture Priority' => 'Blendenpriorität',
        'Beach' => 'Strand',
        'Candlelight' => 'Kerzenlicht',
        'Fireworks' => 'Feuerwerk',
        'Landscape' => 'Landschaft',
        'Macro' => 'Makro',
        'Manual' => 'Manuell',
        'Night Portrait' => 'Nachtporträt',
        'Portrait' => 'Porträt',
        'Program' => 'Programm',
        'Shutter Priority' => 'Verschlusspriorität',
        'Snow' => 'Schnee',
        'Sunset' => 'Sonnenuntergang',
      },
    },
   'SceneSelect' => {
      PrintConv => {
        'Night' => 'Nachtszene',
        'Off' => 'Aus',
      },
    },
   'SceneType' => {
      Description => 'Szenentyp',
      PrintConv => {
        'Directly photographed' => 'Direkt aufgenommenes Bild',
      },
    },
   'SecurityClassification' => {
      Description => 'Sicherheitsklassifizierung',
      PrintConv => {
        'Confidential' => 'Vertraulich',
        'Restricted' => 'Eingeschränkt',
        'Secret' => 'Geheim',
        'Top Secret' => 'Streng geheim',
        'Unclassified' => 'Nicht klassifiziert',
      },
    },
   'SelectableAFPoint' => {
      Description => 'Wählbares AF-Feld',
      PrintConv => {
        '19 points' => '19 Felder',
        'Inner 9 points' => 'Innere 9 Felder',
        'Outer 9 points' => 'Äußere 9 Felder',
      },
    },
   'SelfTimer' => {
      Description => 'Selbstauslöserzeit',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'SelfTimer2' => 'Selbstauslöser (2)',
   'SelfTimerMode' => 'Selbstauslösermodus',
   'SelfTimerTime' => 'Selbstauslöser-Vorlaufzeit',
   'SensingMethod' => {
      Description => 'Messmethode',
      PrintConv => {
        'Color sequential area' => 'Color-Sequential-Area-Sensor',
        'Color sequential linear' => 'Color-Sequential-Linear-Sensor',
        'Monochrome area' => 'Monochrom-Sensor',
        'Monochrome linear' => 'Monochrom-linearer Sensor',
        'Not defined' => 'Nicht definiert',
        'One-chip color area' => 'Ein-Chip-Farbsensor',
        'Three-chip color area' => 'Drei-Chip-Farbsensor',
        'Trilinear' => 'Trilinearer Sensor',
        'Two-chip color area' => 'Zwei-Chip-Farbsensor',
      },
    },
   'SensitivityAdjust' => 'ISO-Empfindlichkeitsanpassung',
   'SensitivitySteps' => {
      Description => 'Empfindlichkeits-Schritte',
      PrintConv => {
        '1 EV Steps' => '1 LW-Schritte',
        'As EV Steps' => 'Wie LW-Schritte',
      },
    },
   'SensorBlueLevel' => 'Sensor Blau-Level',
   'SensorCleaning' => {
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'SensorPixelSize' => 'Sensor-Pixelgröße',
   'SensorRedLevel' => 'Sensor Rot-Level',
   'SequenceNumber' => 'Bildsequenznummer',
   'SequentialShot' => {
      PrintConv => {
        'None' => 'Keine',
      },
    },
   'SerialNumber' => 'Seriennummer',
   'SerialNumberFormat' => 'Seriennummer-Format',
   'ServiceIdentifier' => 'Service-ID',
   'SetButtonCrossKeysFunc' => {
      Description => 'SET Taste/Kreuztaste Funkt.',
      PrintConv => {
        'Cross keys: AF point select' => 'Kreuztaste:AF Feld Auswahl',
        'Set: Flash Exposure Comp' => 'SET:Blitzbe. Korr.',
        'Set: Parameter' => 'SET:Parameter ändern',
        'Set: Picture Style' => 'SET:Bildstil',
        'Set: Playback' => 'SET:Wiedergabe',
        'Set: Quality' => 'SET:Qualität',
      },
    },
   'SetButtonFunction' => 'Funktion SET-Taste b. Aufnahme',
   'SetButtonWhenShooting' => {
      Description => 'SET-Taste bei Aufnahme',
      PrintConv => {
        'Change parameters' => 'Parameter ändern',
        'Default (no function)' => 'Normal (gesperrt)',
        'Disabled' => 'Gesperrt',
        'Flash exposure compensation' => 'Blitzbelichtungskorrektur',
        'ISO speed' => 'ISO-Empfindlichkeit',
        'Image playback' => 'Bildwiedergabe',
        'Image quality' => 'Qualität ändern',
        'Image size' => 'Bildgröße',
        'LCD monitor On/Off' => 'LCD-Monitor Ein/Aus',
        'Menu display' => 'Menüanzeige',
        'Normal (disabled)' => 'Normal (gesperrt)',
        'Picture style' => 'Bildstil',
        'Quick control screen' => 'Schnelleinstell.bildschirm',
        'Record func. + media/folder' => 'Aufnahme-Funktion + Medium/Ordner',
        'Record movie (Live View)' => 'Movie-Aufnahme (Livebild)',
        'White balance' => 'Weißabgleich',
      },
    },
   'SetFunctionWhenShooting' => {
      Description => 'SET-Taste bei Aufnahme',
      PrintConv => {
        'Change Parameters' => 'Parameter ändern',
        'Change Picture Style' => 'Bildstil',
        'Change quality' => 'Qualität ändern',
        'Default (no function)' => 'Normal (gesperrt)',
        'Image replay' => 'Bildwiedergabe',
        'Menu display' => 'Menüanzeige',
      },
    },
   'ShadingCompensation' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ShadingCompensation2' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ShakeReduction' => {
      Description => 'Bildstabilisator (Einstellung)',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'Sharpness' => {
      Description => 'Schärfe',
      PrintConv => {
        'Film Simulation' => 'Film-Simulation',
        'Hard' => 'Stark',
        'Hard2' => 'Hart2',
        'Med Hard' => 'Leicht erhöht',
        'Med Soft' => 'Leicht verringert',
        'Medium Hard' => 'Mittel-Hart',
        'Medium Soft' => 'Mittel-Weich',
        'Normal' => 'Standard',
        'Soft' => 'Leicht',
        'Soft2' => 'Weich 2',
        'Very Hard' => 'Sehr hoch',
        'Very Soft' => 'Sehr weich',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'SharpnessFrequency' => {
      PrintConv => {
        'High' => 'Hoch',
        'Highest' => 'Höchste',
        'Low' => 'Leicht',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'ShootingInfoDisplay' => {
      Description => 'Aufnahmeinfo-Ansicht',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Manual (dark on light)' => 'Manuell - Dunkel auf Hell',
        'Manual (light on dark)' => 'Manuell - Hell auf dunkel',
      },
    },
   'ShootingMode' => {
      Description => 'Aufnahmemodus',
      PrintConv => {
        'Aperture Priority' => 'Blendenpriorität',
        'Beach' => 'Strand',
        'Candlelight' => 'Kerzenlicht',
        'Fireworks' => 'Feuerwerk',
        'Macro' => 'Makro',
        'Manual' => 'Manuell',
        'Night Portrait' => 'Nachtporträt',
        'Portrait' => 'Porträt',
        'Program' => 'Programm',
        'Shutter Priority' => 'Verschlusspriorität',
        'Snow' => 'Schnee',
        'Sports' => 'Sport',
        'Spot' => 'Spotmessung',
        'Sunset' => 'Sonnenuntergang',
        'Underwater' => 'Tauchen',
      },
    },
   'ShootingModeSetting' => {
      Description => 'Messfeldsteuerung',
      PrintConv => {
        'Continuous' => 'Serienaufnahme',
        'Delayed Remote' => 'Fernauslöser m. Vorlauf',
        'Quick-response Remote' => 'Fernauslöser',
        'Self-timer' => 'Selbstauslöser',
        'Single Frame' => 'Einzelbild',
      },
    },
   'ShortDocumentID' => 'Kurze Bild-ID',
   'ShortFocal' => 'Kleinste Brennweite',
   'ShortReleaseTimeLag' => {
      Description => 'Verkürzte Auslöseverzögerung',
      PrintConv => {
        'Disable' => 'Ausgeschaltet',
        'Enable' => 'Eingeschaltet',
      },
    },
   'ShotInfoVersion' => 'Aufnahmeinfo-Version',
   'Shutter-AELock' => {
      Description => 'Auslöser/AE-Speicherung',
      PrintConv => {
        'AE lock/AF' => 'AE-Speicherung/AF',
        'AE/AF, No AE lock' => 'AE/AF, keine AE-Spei.',
        'AF/AE lock' => 'AF/AE-Speicherung',
        'AF/AF lock' => 'AF/AF-Speicherung',
        'AF/AF lock, No AE lock' => 'AF/AF-Spei.keine AE-Spei.',
      },
    },
   'ShutterAELButton' => 'Auslöser/AE-Speichertaste',
   'ShutterButtonAFOnButton' => {
      Description => 'Auslöser/AF-Starttaste',
      PrintConv => {
        'AE lock/Metering + AF start' => 'AESpeicherung/Messung+AFStart',
        'Metering + AF start' => 'Messung+AFStart',
        'Metering + AF start / disable' => 'Messung+AFStart/Deaktiviert',
        'Metering + AF start/AF stop' => 'Messung+AFStart / AFStopp',
        'Metering start/Meter + AF start' => 'Messung Start/Mess.+AFStart',
      },
    },
   'ShutterCount' => 'Anzahl der Auslösungen',
   'ShutterCurtainSync' => {
      Description => 'Verschluss-Synchronisation',
      PrintConv => {
        '1st-curtain sync' => '1. Verschlussvorhang',
        '2nd-curtain sync' => '2. Verschlussvorhang',
      },
    },
   'ShutterMode' => {
      PrintConv => {
        'Aperture Priority' => 'Blendenpriorität',
        'Auto' => 'Automatisch',
      },
    },
   'ShutterReleaseButtonAE-L' => {
      Description => 'Belichtungsspeicher',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ShutterReleaseNoCFCard' => {
      Description => 'Verschlussausl. ohne Karte',
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'ShutterSpeed' => 'Belichtungsdauer',
   'ShutterSpeedRange' => {
      Description => 'Einstellung Blendenbereich',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'ShutterSpeedValue' => 'Belichtungszeit',
   'SimilarityIndex' => 'Bildgleichheits-Index',
   'SlaveFlashMeteringSegments' => 'Slave-Blitz-Messfeld',
   'SlideShow' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'SlowShutter' => {
      Description => 'Langzeitbelichtungseinstellung',
      PrintConv => {
        'Night Scene' => 'Nachtszene',
        'None' => 'Keine',
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'SlowSync' => {
      Description => 'Slow-Synchro',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'An',
      },
    },
   'Source' => 'Quelle',
   'SpecialEffectsOpticalFilter' => {
      PrintConv => {
        'None' => 'Keine',
      },
    },
   'SpecialInstructions' => 'Anweisungen',
   'SpectralSensitivity' => 'Spektralempfindlichkeit',
   'SpotFocusPointX' => 'Spot-Fokuspunkt X',
   'SpotFocusPointY' => 'Spot-Fokuspunkt Y',
   'SpotMeterLinkToAFPoint' => {
      Description => 'Spotmessung AF-Feld verknüpft',
      PrintConv => {
        'Disable (use center AF point)' => 'Deaktiviert (zentrales AF-Feld)',
        'Enable (use active AF point)' => 'Aktiviert (aktives AF-Feld)',
      },
    },
   'SpotMeteringMode' => {
      Description => 'Spot-Messmethode',
      PrintConv => {
        'Center' => 'Mitte',
      },
    },
   'StripByteCounts' => 'Anzahl Bytes pro komprimierter Bildabschnitt',
   'StripOffsets' => 'Bilddatenposition',
   'Sub-location' => 'Ort des Motivs',
   'SubSecCreateDate' => 'Datum der Digitaldatengenerierung',
   'SubSecDateTimeOriginal' => 'Datum der Originaldatengenerierung',
   'SubSecModifyDate' => 'Dateiänderungsdatum',
   'SubSecTime' => 'DateTime 1/100 Sekunden',
   'SubSecTimeDigitized' => 'DateTimeDigitized 1/100 Sekunden',
   'SubSecTimeOriginal' => 'DateTimeOriginal 1/100 Sekunden',
   'SubfileType' => {
      Description => 'Neuer Unterdatei-Typ',
      PrintConv => {
        'Thumbnail image' => 'Miniaturbild',
      },
    },
   'SubimageColor' => {
      PrintConv => {
        'Monochrome' => 'Monochrom',
      },
    },
   'Subject' => 'Subjekt',
   'SubjectDistance' => 'Objektentfernung',
   'SubjectDistanceRange' => {
      Description => 'Objektdistanzbereich',
      PrintConv => {
        'Close' => 'Nahaufnahme',
        'Distant' => 'Fernaufnahme',
        'Macro' => 'Makro',
        'Unknown' => 'Unbekannt',
      },
    },
   'SubjectLocation' => 'Hauptobjektposition',
   'SubjectProgram' => {
      Description => 'Szenenauswahl',
      PrintConv => {
        'Night portrait' => 'Nachtporträt',
        'None' => 'Keine',
        'Portrait' => 'Porträt',
        'Sports action' => 'Sportereignis',
        'Sunset' => 'Sonnenuntergang',
      },
    },
   'SubjectReference' => 'Themencode',
   'Subsystem' => {
      PrintConv => {
        'Unknown' => 'Unbekannt',
      },
    },
   'SuperMacro' => {
      Description => 'Super Makro',
      PrintConv => {
        'Off' => 'Aus',
      },
    },
   'SuperimposedDisplay' => {
      Description => 'Eingeblendete Anzeige',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'SupplementalCategories' => 'Zus. Kategorien',
   'SvISOSetting' => 'Sv ISO-Einstellung',
   'SwitchToRegisteredAFPoint' => {
      Description => 'Auf gesp. AF-Messf. schalten',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'T4Options' => 'Füllbits hinzugefügt',
   'T6Options' => 'T6 Optionen',
   'TTL_DA_ADown' => 'Slave-Blitz-Messfeld 6',
   'TTL_DA_AUp' => 'Slave-Blitz-Messfeld 5',
   'TTL_DA_BDown' => 'Slave-Blitz-Messfeld 8',
   'TTL_DA_BUp' => 'Slave-Blitz-Messfeld 7',
   'Tagged' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'TargetAperture' => 'Zielblendenwert',
   'TargetExposureTime' => 'Zielbelichtungszeit',
   'Technology' => {
      Description => 'Technologie',
      PrintConv => {
        'Active Matrix Display' => 'Aktives Matrix-Display',
        'Cathode Ray Tube Display' => 'Kathodenstrahlröhrenbildschirm',
        'Digital Camera' => 'Digitalkamera',
        'Dye Sublimation Printer' => 'Thermosublimationsdrucker',
        'Electrophotographic Printer' => 'Laserdrucker',
        'Electrostatic Printer' => 'Elektrostatischer Drucker',
        'Film Scanner' => 'Film-Scanner',
        'Film Writer' => 'Film-Writer',
        'Flexography' => 'Flexographie',
        'Gravure' => 'Gravur',
        'Ink Jet Printer' => 'Tintenstrahldrucker',
        'Offset Lithography' => 'Offset Lithographie',
        'Passive Matrix Display' => 'Passives Matrix-Display',
        'Photo CD' => 'Photo-CD',
        'Photo Image Setter' => 'Foto-Filmbelichter',
        'Photographic Paper Printer' => 'Fotopapierdrucker',
        'Projection Television' => 'Projektionsfernsehgerät',
        'Reflective Scanner' => 'Reflexionsscanner',
        'Thermal Wax Printer' => 'Thermowachsdrucker',
        'Video Camera' => 'Videokamera',
        'Video Monitor' => 'Video-Monitor',
      },
    },
   'Teleconverter' => {
      PrintConv => {
        'None' => 'Keine',
      },
    },
   'TextStamp' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ThumbnailFileName' => 'Miniaturbild-Dateiname',
   'ThumbnailFormat' => 'Miniaturbild-Format',
   'ThumbnailHeight' => 'Miniaturbild-Höhe',
   'ThumbnailImage' => 'Miniaturbild',
   'ThumbnailImageSize' => 'Miniaturbild-Größe',
   'ThumbnailImageType' => 'Miniaturbild-Typ',
   'ThumbnailImageValidArea' => 'Gültiger Bereich des Miniaturbildes',
   'ThumbnailLength' => 'Miniaturbild-Datenlänge',
   'ThumbnailOffset' => 'Miniaturbild-Datenposition',
   'ThumbnailWidth' => 'Miniaturbild-Breite',
   'Time' => 'Zeit',
   'TimeCreated' => 'Erstellungszeit',
   'TimeScaleParamsQuality' => {
      PrintConv => {
        'High' => 'Hoch',
        'Low' => 'Leicht',
      },
    },
   'TimeSent' => 'Absendezeit',
   'TimeStamp' => 'Zeitstempel',
   'TimeStamp1' => 'Zeitstempel (1)',
   'TimeZoneOffset' => 'Zeitzonen-Offset',
   'TimerFunctionButton' => {
      Description => 'Funktionstaste',
      PrintConv => {
        'ISO' => 'ISO-Empfindlichkeit',
        'Image Quality/Size' => 'Bildqualität/-größe',
        'Self-timer' => 'Selbstauslöser',
        'Shooting Mode' => 'Aufnahmebetriebsart',
        'White Balance' => 'Weißabgleich',
      },
    },
   'TimerLength' => {
      Description => 'Intervalldauer für Timer',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'Title' => 'Titel',
   'ToneComp' => 'Tonwertkorrektur',
   'ToneCurve' => {
      Description => 'Ton-Kurve',
      PrintConv => {
        'Custom' => 'Benutzerdefiniert',
        'Manual' => 'Manuell',
      },
    },
   'ToneCurveActive' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'ToneCurveName' => {
      PrintConv => {
        'Custom' => 'Benutzerdefiniert',
      },
    },
   'ToneCurves' => 'Ton-Kurven',
   'ToningEffect' => {
      Description => 'Tönungs-Effekt',
      PrintConv => {
        'B&W' => 'Schwarz-Weiß',
        'Blue' => 'Blau',
        'Green' => 'Grün',
        'None' => 'Keiner',
        'Purple' => 'Lila',
        'Red' => 'Rot',
        'Yellow' => 'Gelb',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'ToningEffectMonochrome' => {
      PrintConv => {
        'Blue' => 'Blau',
        'Green' => 'Grün',
        'None' => 'Keine',
        'Purple' => 'Lila',
      },
    },
   'ToningSaturation' => 'Tönungssättigung',
   'TransferFunction' => 'Transformationsfunktion',
   'Transformation' => {
      PrintConv => {
        'Horizontal (normal)' => '0° (oben/links)',
        'Mirror horizontal' => 'Horizontal gespiegelt',
        'Mirror horizontal and rotate 270 CW' => 'Horizontal gespiegelt und 90° gegen den Uhrzeigersinn gedreht',
        'Mirror horizontal and rotate 90 CW' => 'Horizontal gespiegelt und 90° im Uhrzeigersinn gedreht',
        'Mirror vertical' => 'Vertikal gespiegelt',
        'Rotate 180' => '180° (unten/rechts)',
        'Rotate 270 CW' => '90° im Uhrzeigersinn (links/unten)',
        'Rotate 90 CW' => '90° gegen den Uhrzeigersinn (rechts/oben)',
      },
    },
   'Trapped' => {
      PrintConv => {
        'Unknown' => 'Unbekannt',
      },
    },
   'TvExposureTimeSetting' => 'Tv Belichtungszeit-Einstellung',
   'USMLensElectronicMF' => {
      Description => 'USM-Objektiv, elektr. MF',
      PrintConv => {
        'Disable after one-shot AF' => 'Nicht mögl. nach One-Shot AF',
        'Disable in AF mode' => 'Nicht möglich im AF-Modus',
        'Enable after one-shot AF' => 'Möglich nach One-Shot AF',
      },
    },
   'Uncompressed' => {
      Description => 'Unkomprimiert',
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'UniqueCameraModel' => 'Eindeutige Kamerabezeichnung',
   'UniqueDocumentID' => 'Eindeutige Bild-ID',
   'Unsharp1Color' => {
      PrintConv => {
        'Blue' => 'Blau',
        'Green' => 'Grün',
        'Red' => 'Rot',
        'Yellow' => 'Gelb',
      },
    },
   'Unsharp2Color' => {
      PrintConv => {
        'Blue' => 'Blau',
        'Green' => 'Grün',
        'Red' => 'Rot',
        'Yellow' => 'Gelb',
      },
    },
   'Unsharp3Color' => {
      PrintConv => {
        'Blue' => 'Blau',
        'Green' => 'Grün',
        'Red' => 'Rot',
        'Yellow' => 'Gelb',
      },
    },
   'Unsharp4Color' => {
      PrintConv => {
        'Blue' => 'Blau',
        'Green' => 'Grün',
        'Red' => 'Rot',
        'Yellow' => 'Gelb',
      },
    },
   'UnsharpMask' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'Urgency' => {
      Description => 'Dringlichkeit',
      PrintConv => {
        '0 (reserved)' => '0 (Reserviert für zukünftige Verwendung)',
        '1 (most urgent)' => '1 (sehr wichtig)',
        '5 (normal urgency)' => '5 (normale Wichtigkeit)',
        '8 (least urgent)' => '8 (geringe Wichtigkeit)',
        '9 (user-defined priority)' => '9 (Reserviert für zukünftige Verwendung)',
      },
    },
   'UsableMeteringModes' => {
      Description => 'Wahl nutzbarer Messmethoden',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'UsableShootingModes' => {
      Description => 'Wahl nutzbarer Aufnahmemodi',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'UserComment' => 'Benutzerkommentar',
   'UserDef1PictureStyle' => {
      PrintConv => {
        'Landscape' => 'Landschaft',
        'Monochrome' => 'Monochrom',
        'Portrait' => 'Porträt',
      },
    },
   'UserDef2PictureStyle' => {
      PrintConv => {
        'Landscape' => 'Landschaft',
        'Monochrome' => 'Monochrom',
        'Portrait' => 'Porträt',
      },
    },
   'UserDef3PictureStyle' => {
      PrintConv => {
        'Landscape' => 'Landschaft',
        'Monochrome' => 'Monochrom',
        'Portrait' => 'Porträt',
      },
    },
   'VRDVersion' => 'VRD-Version',
   'VR_0x66' => {
      PrintConv => {
        'Off' => 'Aus',
        'On (active)' => 'Ein (Aktiv)',
        'On (normal)' => 'Ein (Normal)',
      },
    },
   'ValidAFPoints' => 'Gültige AF-Punke',
   'VariProgram' => 'Aufnahmeprogramm',
   'VibrationReduction' => {
      Description => 'Bildstabilisation',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
        'On (1)' => 'Ein (1)',
        'On (2)' => 'Ein (2)',
        'On (3)' => 'Ein (3)',
        'n/a' => 'Nicht gesetzt',
      },
    },
   'ViewInfoDuringExposure' => {
      Description => 'Sucherinfo bei Belichtung',
      PrintConv => {
        'Disable' => 'Nicht möglich',
        'Enable' => 'Möglich',
      },
    },
   'ViewfinderWarning' => {
      Description => 'Warnsymbol im Sucher',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'VignetteControl' => {
      Description => 'Vignettierungskorrektur',
      PrintConv => {
        'High' => 'Hoch',
        'Low' => 'Schwach',
        'Normal' => 'Mittel',
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'VignetteControlIntensity' => 'Vignettierungskorrektur Stärke',
   'VoiceMemo' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'WBAdjLighting' => {
      PrintConv => {
        'Daylight' => 'Tageslicht',
        'Flash' => 'Blitz',
        'Incandescent' => 'Aufnahme bei Glühlampenlicht (Kunstlicht)',
        'None' => 'Keine',
      },
    },
   'WBBracketMode' => {
      Description => 'Weißabgleich Belichtungsreihen-Modus',
      PrintConv => {
        'Off' => 'Aus',
        'On (shift AB)' => 'Ein (AB-Verschiebung)',
        'On (shift GM)' => 'Ein (GM-Verschiebung)',
      },
    },
   'WBBracketValueAB' => 'Weißabgleich AB-Belichtungsreihen-Wert',
   'WBBracketValueGM' => 'Weißabgleich GM-Belichtungsreihen-Wert',
   'WBFineTuneActive' => {
      PrintConv => {
        'No' => 'Nein',
        'Yes' => 'Ja',
      },
    },
   'WBMediaImageSizeSetting' => {
      Description => 'WB+Media/Bildgrößeneinstellung',
      PrintConv => {
        'LCD monitor' => 'LCD-Monitor',
        'Rear LCD panel' => 'Hinteres LCD-Panel',
      },
    },
   'WBMode' => {
      PrintConv => {
        'Auto' => 'Automatisch',
      },
    },
   'WBShiftAB' => 'Weißabgleich AB-Korrektur',
   'WBShiftGM' => 'Weißabgleich GM-Korrektur',
   'WBShiftMG' => 'Weißabgleich GM-Korrektur',
   'WB_GBRGLevels' => 'Weißabgleich GBRG-Farbverteilung',
   'WB_GRBGLevels' => 'Weißabgleich GRBG-Farbverteilung',
   'WB_GRGBLevels' => 'Weißabgleich GRGB-Farbverteilung',
   'WB_RBGGLevels' => 'Weißabgleich RBGG-Farbverteilung',
   'WB_RBLevels' => 'Weißabgleich RB-Farbverteilung',
   'WB_RBLevels3000K' => 'Weißabgleich RB-Farbverteilung 3000K',
   'WB_RBLevels3300K' => 'Weißabgleich RB-Farbverteilung 3300K',
   'WB_RBLevels3600K' => 'Weißabgleich RB-Farbverteilung 3600K',
   'WB_RBLevels3900K' => 'Weißabgleich RB-Farbverteilung 3800K',
   'WB_RBLevels4000K' => 'Weißabgleich RB-Farbverteilung 4000K',
   'WB_RBLevels4300K' => 'Weißabgleich RB-Farbverteilung 4300K',
   'WB_RBLevels4500K' => 'Weißabgleich RB-Farbverteilung 4500K',
   'WB_RBLevels4800K' => 'Weißabgleich RB-Farbverteilung 4800K',
   'WB_RBLevels5300K' => 'Weißabgleich RB-Farbverteilung 5300K',
   'WB_RBLevels6000K' => 'Weißabgleich RB-Farbverteilung 6000K',
   'WB_RBLevels6600K' => 'Weißabgleich RB-Farbverteilung 6600K',
   'WB_RBLevels7500K' => 'Weißabgleich RB-Farbverteilung 7500K',
   'WB_RBLevelsCloudy' => 'Weißabgleich RB-Farbverteilung Bewölkt',
   'WB_RBLevelsShade' => 'Weißabgleich RB-Farbverteilung Schatten',
   'WB_RBLevelsTungsten' => 'Weißabgleich RB-Farbverteilung Glühbirne',
   'WB_RGBGLevels' => 'Weißabgleich RGBG-Farbverteilung',
   'WB_RGBLevels' => 'Weißabgleich RGB-Farbverteilung',
   'WB_RGBLevelsCloudy' => 'Weißabgleich RGB-Farbverteilung Bewölkt',
   'WB_RGBLevelsDaylight' => 'Weißabgleich RGB-Farbverteilung Tageslicht',
   'WB_RGBLevelsFlash' => 'Weißabgleich RGB-Farbverteilung Blitz',
   'WB_RGBLevelsFluorescent' => 'Weißabgleich RGB-Farbverteilung Neonlicht',
   'WB_RGBLevelsShade' => 'Weißabgleich RGB-Farbverteilung Schatten',
   'WB_RGBLevelsTungsten' => 'Weißabgleich RGB-Farbverteilung Glühbirne',
   'WB_RGGBLevels' => 'Weißabgleich RGGB-Farbverteilung',
   'WB_RGGBLevelsCloudy' => 'Weißabgleich RGGB-Farbverteilung Bewölkt',
   'WB_RGGBLevelsDaylight' => 'Weißabgleich RGGB-Farbverteilung Tageslicht',
   'WB_RGGBLevelsFlash' => 'Weißabgleich RGGB-Farbverteilung Blitz',
   'WB_RGGBLevelsFluorescent' => 'Weißabgleich RGGB-Farbverteilung Neonlicht',
   'WB_RGGBLevelsFluorescentD' => 'Weißabgleich RGGB-Farbverteilung Neonlicht D',
   'WB_RGGBLevelsFluorescentN' => 'Weißabgleich RGGB-Farbverteilung Neonlicht N',
   'WB_RGGBLevelsFluorescentW' => 'Weißabgleich RGGB-Farbverteilung Neonlicht W',
   'WB_RGGBLevelsShade' => 'Weißabgleich RGGB-Farbverteilung Schatten',
   'WB_RGGBLevelsTungsten' => 'Weißabgleich RGGB-Farbverteilung Glühbirne',
   'WCSProfiles' => 'Windows Color System-Profil',
   'Warning' => 'Warnung',
   'WhiteBalance' => {
      Description => 'Weißabgleich',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Black & White' => 'Schwarz/Weiß',
        'Cloudy' => 'Bewölkt',
        'Color Temperature/Color Filter' => 'Farbtemperatur/Farbfilter',
        'Custom' => 'Benutzerdefiniert',
        'Custom 1' => 'Benutzerdefiniert 1',
        'Custom 2' => 'Benutzerdefiniert 2',
        'Custom 3' => 'Benutzerdefiniert 3',
        'Custom 4' => 'Benutzerdefiniert 4',
        'Custom2' => 'Benutzerdefiniert 2',
        'Custom3' => 'Benutzerdefiniert 3',
        'Custom4' => 'Benutzerdefiniert 4',
        'Custom5' => 'Benutzerdefiniert 5',
        'Day White Fluorescent' => 'Tageslicht-Weiß Leuchtstofflampe',
        'Daylight' => 'Tageslicht',
        'Daylight Fluorescent' => 'Tageslicht-Leuchtstofflampe',
        'DaylightFluorescent' => 'Tageslicht-Leuchtstofflampe',
        'DaywhiteFluorescent' => 'Neonlicht (neutralweiß)',
        'Flash' => 'Blitz',
        'Fluorescent' => 'Fluoreszierend',
        'Incandescent' => 'Aufnahme bei Glühlampenlicht (Kunstlicht)',
        'Living Room Warm White Fluorescent' => 'Aufnahme bei Neon-/Fluoreszenzlicht (Wohnzimmer-warmes Weiß)',
        'Manual' => 'Manuell',
        'Manual Temperature (Kelvin)' => 'Manuelle Temperatur (Kelvin)',
        'Shade' => 'Schatten',
        'Shadow' => 'Schatten',
        'Tungsten' => 'Kunstlicht (Glühbirne)',
        'Underwater' => 'Tauchen',
        'Unknown' => 'Unbekannt',
        'User-Selected' => 'Benutzerdefiniert',
        'Warm White Fluorescent' => 'Aufnahme bei Neon-/Fluoreszenzlicht (warmes Weiß)',
        'White Fluorescent' => 'Warme weiße Leuchtstofflampe',
        'WhiteFluorescent' => 'Warme weiße Leuchtstofflampe',
      },
    },
   'WhiteBalance2' => {
      PrintConv => {
        'Auto' => 'Automatisch',
      },
    },
   'WhiteBalanceAdj' => {
      PrintConv => {
        'Auto' => 'Automatisch',
        'Cloudy' => 'Bewölkt',
        'Daylight' => 'Tageslicht',
        'Flash' => 'Blitz',
        'Fluorescent' => 'Fluoreszierend',
        'Off' => 'Aus',
        'On' => 'Ein',
        'Shade' => 'Schatten',
        'Tungsten' => 'Kunstlicht (Glühbirne)',
      },
    },
   'WhiteBalanceBlue' => 'Weißabgleich Blau',
   'WhiteBalanceFineTune' => 'Weißabgleichsfeineinstellung',
   'WhiteBalanceMode' => {
      Description => 'Weißabgleich-Modus',
      PrintConv => {
        'Auto (Cloudy)' => 'Automatisch (Wolkig)',
        'Auto (Daylight)' => 'Automatisch (Tageslicht)',
        'Auto (DaylightFluorescent)' => 'Automatisch (Neonlicht, Tageslicht)',
        'Auto (DaywhiteFluorescent)' => 'Automatisch (Neonlicht, neutralweiß)',
        'Auto (Flash)' => 'Automatisch (Blitz)',
        'Auto (Shade)' => 'Automatisch (Schatten)',
        'Auto (Tungsten)' => 'Automatisch (Glühlampenlicht)',
        'Auto (WhiteFluorescent)' => 'Automatisch (Neonlicht, weiß)',
        'Unknown' => 'Unbekannt',
        'User-Selected' => 'Benutzerdefiniert',
      },
    },
   'WhiteBalanceRed' => 'Weißabgleich Rot',
   'WhiteBalanceSet' => {
      Description => 'Eingestellter Weißabgleich',
      PrintConv => {
        'Auto' => 'Automatisch',
        'Cloudy' => 'Bewölkt',
        'Daylight' => 'Tageslicht',
        'DaylightFluorescent' => 'Tageslicht-Leuchtstofflampe',
        'DaywhiteFluorescent' => 'Neonlicht (neutralweiß)',
        'Flash' => 'Blitz',
        'Manual' => 'Manuell',
        'Set Color Temperature 1' => 'Farbtemperatur-Einstellung 1',
        'Set Color Temperature 2' => 'Farbtemperatur-Einstellung 2',
        'Set Color Temperature 3' => 'Farbtemperatur-Einstellung 3',
        'Shade' => 'Schatten',
        'Tungsten' => 'Kunstlicht (Glühbirne)',
        'WhiteFluorescent' => 'Warme weiße Leuchtstofflampe',
      },
    },
   'WhitePoint' => 'Weißpunkt-Chromatizität',
   'WideFocusZone' => {
      Description => 'Zone des großen AF-Messfeldes',
      PrintConv => {
        'Center zone (horizontal orientation)' => 'Mittlere Zone (horizontale Ausrichtung)',
        'Center zone (vertical orientation)' => 'Mittlere Zone (vertikale Ausrichtung)',
        'Left zone' => 'Linke Zone',
        'No zone' => 'Keine Zone',
        'Right zone' => 'Rechte Zone',
      },
    },
   'WideRange' => {
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'WidthResolution' => 'Horizontale Bildauflösung',
   'WorldTimeLocation' => {
      Description => 'Weltzeit-Position',
      PrintConv => {
        'Destination' => 'Zielort',
        'Hometown' => 'Heimatort',
      },
    },
   'Writer-Editor' => 'Verfasser der Beschreibung',
   'XPAuthor' => 'Autor',
   'XPComment' => 'Kommentar',
   'XPKeywords' => 'Stichwörter',
   'XPSubject' => 'Betreff',
   'XPTitle' => 'Titel',
   'XResolution' => 'Horizontale Bildauflösung',
   'YCbCrCoefficients' => 'YCbCr-Koeffizienten',
   'YCbCrPositioning' => {
      Description => 'Y und C Ausrichtung',
      PrintConv => {
        'Centered' => 'Zentriert',
        'Co-sited' => 'Benachbart',
      },
    },
   'YCbCrSubSampling' => 'Subsampling Rate von Y bis C',
   'YResolution' => 'Vertikale Bildauflösung',
   'Year' => 'Jahr',
   'ZoneMatching' => {
      Description => 'Zonenabgleich',
      PrintConv => {
        'ISO Setting Used' => 'Aus (ISO-Einstellung verwendet)',
      },
    },
   'ZoneMatchingOn' => {
      Description => 'Zonenabgleich',
      PrintConv => {
        'Off' => 'Aus',
        'On' => 'Ein',
      },
    },
   'ZoomSourceWidth' => 'Vergrößerungs-Ursprungsgröße',
   'ZoomTargetWidth' => 'Vergrößerungs-Endgröße',
);

1;  # end


__END__

=head1 NAME

Image::ExifTool::Lang::de.pm - ExifTool German language translations

=head1 DESCRIPTION

This file is used by Image::ExifTool to generate localized tag descriptions
and values.

=head1 AUTHOR

Copyright 2003-2009, Phil Harvey (phil at owl.phy.queensu.ca)

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 ACKNOWLEDGEMENTS

Thanks to Jens Duttke for providing this translation.

=head1 SEE ALSO

L<Image::ExifTool(3pm)|Image::ExifTool>,
L<Image::ExifTool::TagInfoXML(3pm)|Image::ExifTool::TagInfoXML>

=cut
