#------------------------------------------------------------------------------
# File:         fr.pm
#
# Description:  ExifTool French language translations
#
# Notes:        This file generated automatically by Image::ExifTool::TagInfoXML
#------------------------------------------------------------------------------

package Image::ExifTool::Lang::fr;

use vars qw($VERSION);

$VERSION = '1.06';

%Image::ExifTool::Lang::fr::Translate = (
   'AEAperture' => 'Ouverture AE',
   'AEBAutoCancel' => {
      Description => 'Annulation bracketing auto',
      PrintConv => {
        'Off' => 'Arrêt',
        'On' => 'Marche',
      },
    },
   'AEBSequence' => 'Séquence de bracketing',
   'AEBSequenceAutoCancel' => {
      Description => 'Séquence auto AEB/annuler',
      PrintConv => {
        '-,0,+/Disabled' => '-,0,+/Désactivé',
        '-,0,+/Enabled' => '-,0,+/Activé',
        '0,-,+/Disabled' => '0,-,+/Désactivé',
        '0,-,+/Enabled' => '0,-,+/Activé',
      },
    },
   'AEBShotCount' => 'Nombre de vues bracketées',
   'AEBXv' => 'Compensation d\'expo. auto en bracketing',
   'AEExposureTime' => 'Temps d\'exposition AE',
   'AEExtra' => 'Suppléments AE',
   'AELock' => {
      Description => 'Verrouillage AE',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'AEMaxAperture' => 'Ouverture maxi AE',
   'AEMaxAperture2' => 'Ouverture maxi AE (2)',
   'AEMeteringMode' => {
      Description => 'Mode de mesure AE',
      PrintConv => {
        'Multi-segment' => 'Multizone',
      },
    },
   'AEMeteringSegments' => 'Segments de mesure AE',
   'AEMinAperture' => 'Ouverture mini AE',
   'AEMinExposureTime' => 'Temps d\'exposition mini AE',
   'AEProgramMode' => {
      Description => 'Mode programme AE',
      PrintConv => {
        'Av, B or X' => 'Av, B ou X',
        'Candlelight' => 'Bougie',
        'DOF Program' => 'Programme PdC',
        'DOF Program (P-Shift)' => 'Programme PdC (décalage P)',
        'Hi-speed Program' => 'Programme grande vitesse',
        'Hi-speed Program (P-Shift)' => 'Programme grande vitesse (décalage P)',
        'Kids' => 'Enfants',
        'Landscape' => 'Paysage',
        'M, P or TAv' => 'M, P ou TAv',
        'MTF Program' => 'Programme FTM',
        'MTF Program (P-Shift)' => 'Programme FTM (décalage P)',
        'Museum' => 'Musée',
        'Night Scene' => 'Nocturne',
        'Night Scene Portrait' => 'Portrait nocturne',
        'No Flash' => 'Sans flash',
        'Pet' => 'Animaux de compagnie',
        'Sunset' => 'Coucher de soleil',
        'Surf & Snow' => 'Surf et neige',
        'Sv or Green Mode' => 'Sv ou mode vert',
        'Text' => 'Texte',
      },
    },
   'AEXv' => 'Compensation d\'exposition auto',
   'AE_ISO' => 'Sensibilité ISO AE',
   'AFAdjustment' => 'Ajustement AF',
   'AFAreaIllumination' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'AFAssist' => {
      Description => 'Faisceau d\'assistance AF',
      PrintConv => {
        'Does not emit/Fires' => 'N\'émet pas/Se déclenche',
        'Emits/Does not fire' => 'Emet/Ne se déclenche pas',
        'Emits/Fires' => 'Emet/Se déclenche',
        'Off' => 'Désactivé',
        'On' => 'Activé',
        'Only ext. flash emits/Fires' => 'Flash ext émet/Se déclenche',
      },
    },
   'AFAssistBeam' => {
      Description => 'Faisceau d\'assistance AF',
      PrintConv => {
        'Does not emit' => 'Désactivé',
        'Emits' => 'Activé',
        'Only ext. flash emits' => 'Uniquement par flash ext.',
      },
    },
   'AFAssistIlluminator' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'AFDefocus' => 'Défocalisation AF',
   'AFDuringLiveView' => {
      Description => 'AF pendant la visée directe',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activé',
        'Live mode' => 'Mode visée directe',
        'Quick mode' => 'Mode rapide',
      },
    },
   'AFIntegrationTime' => 'Temps d\'intégration AF',
   'AFMicroAdjActive' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'AFMicroadjustment' => {
      Description => 'Micro-ajustement de l\'AF',
      PrintConv => {
        'Adjust all by same amount' => 'Ajuster idem tous obj',
        'Adjust by lens' => 'Ajuster par objectif',
        'Disable' => 'Désactivé',
      },
    },
   'AFMode' => {
      Description => 'Mode AF',
      PrintConv => {
        'Face Detect AF' => 'Dét. visage',
      },
    },
   'AFOnAELockButtonSwitch' => {
      Description => 'Permutation touche AF/Mémo',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activé',
      },
    },
   'AFPoint' => {
      PrintConv => {
        'Bottom' => 'Bas',
        'Center' => 'Centre',
        'Left' => 'Gauche',
        'None' => 'Aucune',
        'Right' => 'Droit',
        'Top' => 'Haut',
      },
    },
   'AFPointActivationArea' => {
      Description => 'Zone activation collimateurs AF',
      PrintConv => {
        'Automatic expanded (max. 13)' => 'Expansion auto (13 max.)',
        'Expanded (TTL. of 7 AF points)' => 'Expansion (TTL 7 collimat.)',
        'Single AF point' => 'Un seul collimateur AF',
      },
    },
   'AFPointAreaExpansion' => {
      Description => 'Extension de la zone AF',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activé',
        'Enable (left/right assist points)' => 'Activé (gauche/droite collimateurs autofocus d\'assistance)',
        'Enable (surrounding assist points)' => 'Activée (Collimateurs autofocus d\'assistance environnants)',
      },
    },
   'AFPointAutoSelection' => {
      Description => 'Sélecition des collimateurs automatique',
      PrintConv => {
        'Control-direct:disable/Main:disable' => 'Contrôle rapide-Directe:désactivé/Principale:désactivé',
        'Control-direct:disable/Main:enable' => 'Contrôle rapide-Directe:désactivé/Principale:activé',
        'Control-direct:enable/Main:enable' => 'Contrôle rapide-Directe:activé/Principale:activé',
      },
    },
   'AFPointBrightness' => {
      Description => 'Intensité d\'illumination AF',
      PrintConv => {
        'Brighter' => 'Forte',
        'Normal' => 'Normale',
      },
    },
   'AFPointDisplayDuringFocus' => {
      Description => 'Affichage de point AF pendant mise au point',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
        'On (when focus achieved)' => 'Activé (si mise au point effectuée)',
      },
    },
   'AFPointIllumination' => {
      Description => 'Eclairage des collimateurs AF',
      PrintConv => {
        'Brighter' => 'Plus brillant',
        'Off' => 'Désactivé',
        'On' => 'Activé',
        'On without dimming' => 'Activé sans atténuation',
      },
    },
   'AFPointMode' => 'Mode de mise au point AF',
   'AFPointRegistration' => {
      Description => 'Validation du point AF',
      PrintConv => {
        'Automatic' => 'Auto',
        'Bottom' => 'Bas',
        'Center' => 'Centre',
        'Extreme Left' => 'Extrême gauche',
        'Extreme Right' => 'Extrême droite',
        'Left' => 'Gauche',
        'Right' => 'Droit',
        'Top' => 'Haut',
      },
    },
   'AFPointSelected' => {
      Description => 'Point AF sélectionné',
      PrintConv => {
        'Automatic Tracking AF' => 'AF en suivi auto',
        'Bottom' => 'Bas',
        'Center' => 'Centre',
        'Face Recognition AF' => 'AF en reconnaissance de visage',
        'Fixed Center' => 'Fixe au centre',
        'Left' => 'Gauche',
        'Lower-left' => 'Bas gauche',
        'Lower-right' => 'Bas droit',
        'Mid-left' => 'Milieu gauche',
        'Mid-right' => 'Milieu droit',
        'Right' => 'Droit',
        'Top' => 'Haut',
        'Upper-left' => 'Haut gauche',
        'Upper-right' => 'Haut droite',
      },
    },
   'AFPointSelected2' => 'Point AF sélectionné 2',
   'AFPointSelection' => 'Méthode sélect. collimateurs AF',
   'AFPointSelectionMethod' => {
      Description => 'Méthode sélection collim. AF',
      PrintConv => {
        'Multi-controller direct' => 'Multicontrôleur direct',
        'Normal' => 'Normale',
        'Quick Control Dial direct' => 'Molette AR directe',
      },
    },
   'AFPointSpotMetering' => {
      Description => 'Nombre collimateurs/mesure spot',
      PrintConv => {
        '11/Active AF point' => '11/collimateur AF actif',
        '11/Center AF point' => '11/collimateur AF central',
        '45/Center AF point' => '45/collimateur AF central',
        '9/Active AF point' => '9/collimateur AF actif',
      },
    },
   'AFPointsInFocus' => {
      Description => 'Points AF nets',
      PrintConv => {
        'All' => 'Tous',
        'Bottom' => 'Bas',
        'Bottom, Center' => 'Bas + centre',
        'Bottom-center' => 'Bas centre',
        'Bottom-left' => 'Bas gauche',
        'Bottom-right' => 'Bas droit',
        'Center' => 'Centre',
        'Center (horizontal)' => 'Centre (horizontal)',
        'Center (vertical)' => 'Centre (vertical)',
        'Center+Right' => 'Centre+droit',
        'Fixed Center or Multiple' => 'Centre fixe ou multiple',
        'Left' => 'Gauche',
        'Left+Center' => 'Gauch+centre',
        'Left+Right' => 'Gauche+droit',
        'Lower-left, Bottom' => 'Bas gauche + bas',
        'Lower-left, Mid-left' => 'Bas gauche + milieu gauche',
        'Lower-right, Bottom' => 'Bas droit + bas',
        'Lower-right, Mid-right' => 'Bas droit + milieu droit',
        'Mid-left' => 'Milieu gauche',
        'Mid-left, Center' => 'Milieu gauche + centre',
        'Mid-right' => 'Milieu droit',
        'Mid-right, Center' => 'Milieu droit + centre',
        'None' => 'Aucune',
        'None (MF)' => 'Aucune (MF)',
        'Right' => 'Droit',
        'Top' => 'Haut',
        'Top, Center' => 'Haut + centre',
        'Top-center' => 'Haut centre',
        'Top-left' => 'Haut gauche',
        'Top-right' => 'Haut droit',
        'Upper-left, Mid-left' => 'Haut gauche + milieu gauche',
        'Upper-left, Top' => 'Haut gauche + haut',
        'Upper-right, Mid-right' => 'Haut droit + milieu droit',
        'Upper-right, Top' => 'Haut droit + haut',
      },
    },
   'AFPointsUnknown1' => {
      PrintConv => {
        'All' => 'Tous',
        'Central 9 points' => '9 points centraux',
      },
    },
   'AFPointsUnknown2' => 'Points AF inconnus 2',
   'AFPredictor' => 'Prédicteur AF',
   'AIServoContinuousShooting' => 'Priorité vit. méca. AI Servo',
   'AIServoImagePriority' => {
      Description => '1er Servo Ai/2e priorité déclenchement',
      PrintConv => {
        '1: AF, 2: Drive speed' => 'Priorité AF/Priorité cadence vues',
        '1: AF, 2: Tracking' => 'Priorité AF/Priorité suivi AF',
        '1: Release, 2: Drive speed' => 'Déclenchement/Priorité cadence vues',
      },
    },
   'AIServoTrackingMethod' => {
      Description => 'Méthode de suivi autofocus AI Servo',
      PrintConv => {
        'Continuous AF track priority' => 'Priorité suivi AF en continu',
        'Main focus point priority' => 'Priorité point AF principal',
      },
    },
   'AIServoTrackingSensitivity' => {
      Description => 'Sensibili. de suivi AI Servo',
      PrintConv => {
        'Fast' => 'Schnell',
        'Medium Fast' => 'Moyenne rapide',
        'Medium Slow' => 'Moyenne lent',
        'Moderately fast' => 'Moyennement rapide',
        'Moderately slow' => 'Moyennement lent',
        'Slow' => 'Lent',
      },
    },
   'APEVersion' => 'Version APE',
   'ARMIdentifier' => 'Identificateur ARM',
   'ARMVersion' => 'Version ARM',
   'ActionAdvised' => {
      Description => 'Action conseillée',
      PrintConv => {
        'Object Kill' => 'Destruction d\'objet',
        'Object Reference' => 'Référence d\'objet',
        'Object Replace' => 'Remplacement d\'objet',
        'Ojbect Append' => 'Ajout d\'objet',
      },
    },
   'ActiveArea' => 'Zone active',
   'ActiveD-Lighting' => {
      PrintConv => {
        'Low' => 'Bas',
        'Normal' => 'Normale',
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ActiveD-LightingMode' => {
      PrintConv => {
        'Low' => 'Bas',
        'Normal' => 'Normale',
        'Off' => 'Désactivé',
      },
    },
   'AddAspectRatioInfo' => {
      Description => 'Ajouter info ratio d\'aspect',
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'AddOriginalDecisionData' => {
      Description => 'Aj. données décis. origine',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'AdditionalModelInformation' => 'Modele d\'Information additionnel',
   'Address' => 'Adresse',
   'AdultContentWarning' => {
      PrintConv => {
        'Unknown' => 'Inconnu',
      },
    },
   'AdvancedRaw' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'Advisory' => 'Adversité',
   'AnalogBalance' => 'Balance analogique',
   'Annotations' => 'Annotations Photoshop',
   'Anti-Blur' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'n/a' => 'Non établie',
      },
    },
   'AntiAliasStrength' => 'Puissance relative du filtre anticrénelage de l\'appareil',
   'Aperture' => 'Nombre F',
   'ApertureRange' => {
      Description => 'Régler gamme d\'ouvertures',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activée',
      },
    },
   'ApertureRingUse' => {
      Description => 'Utilisation de la bague de diaphragme',
      PrintConv => {
        'Permitted' => 'Autorisée',
        'Prohibited' => 'Interdite',
      },
    },
   'ApertureValue' => 'Ouverture',
   'ApplicationRecordVersion' => 'Version d\'enregistrement',
   'ApplyShootingMeteringMode' => {
      Description => 'Appliquer mode de prise de vue/de mesure',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activée',
      },
    },
   'Artist' => 'Artiste',
   'ArtworkCopyrightNotice' => 'Notice copyright de l\'Illustration',
   'ArtworkCreator' => 'Créateur de l\'Illustration',
   'ArtworkDateCreated' => 'Date de création de l\'Illustration',
   'ArtworkSource' => 'Source de l\'Illustration',
   'ArtworkSourceInventoryNo' => 'No d\'Inventaire du source de l\'Illustration',
   'ArtworkTitle' => 'Titre de l\'Illustration',
   'AsShotICCProfile' => 'Profil ICC à la prise de vue',
   'AsShotNeutral' => 'Balance neutre à la prise de vue',
   'AsShotPreProfileMatrix' => 'Matrice de pré-profil à la prise de vue',
   'AsShotProfileName' => 'Nom du profil du cliché',
   'AsShotWhiteXY' => 'Balance blanc X-Y à la prise de vue',
   'AssignFuncButton' => {
      Description => 'Changer fonct. touche FUNC.',
      PrintConv => {
        'Exposure comp./AEB setting' => 'Correct. expo/réglage AEB',
        'Image jump with main dial' => 'Saut image par molette principale',
        'Image quality' => 'Changer de qualité',
        'LCD brightness' => 'Luminosité LCD',
        'Live view function settings' => 'Réglages Visée par l’écran',
      },
    },
   'AssistButtonFunction' => {
      Description => 'Touche de fonction rapide',
      PrintConv => {
        'Av+/- (AF point by QCD)' => 'Av+/- (AF par mol. AR)',
        'FE lock' => 'Mémo expo. au flash',
        'Normal' => 'Normale',
        'Select HP (while pressing)' => 'Sélect. HP (en appuyant)',
        'Select Home Position' => 'Sélect. position origine',
      },
    },
   'Audio' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'AudioDuration' => 'Durée audio',
   'AudioOutcue' => 'Queue audio',
   'AudioSamplingRate' => 'Taux d\'échantillonnage audio',
   'AudioSamplingResolution' => 'Résolution d\'échantillonnage audio',
   'AudioType' => {
      Description => 'Type audio',
      PrintConv => {
        'Mono Actuality' => 'Actualité (audio mono (1 canal))',
        'Mono Music' => 'Musique, transmise par elle-même (audio mono (1 canal))',
        'Mono Question and Answer Session' => 'Question et réponse (audio mono (1 canal))',
        'Mono Raw Sound' => 'Son brut (audio mono (1 canal))',
        'Mono Response to a Question' => 'Réponse à une question (audio mono (1 canal))',
        'Mono Scener' => 'Scener (audio mono (1 canal))',
        'Mono Voicer' => 'Voix (audio mono (1 canal))',
        'Mono Wrap' => 'Wrap (audio mono (1 canal))',
        'Stereo Actuality' => 'Actualité (audio stéréo (2 canaux))',
        'Stereo Music' => 'Musique, transmise par elle-même (audio stéréo (2 canaux))',
        'Stereo Question and Answer Session' => 'Question et réponse (audio stéréo (2 canaux))',
        'Stereo Raw Sound' => 'Son brut (audio stéréo (2 canaux))',
        'Stereo Response to a Question' => 'Réponse à une question (audio stéréo (2 canaux))',
        'Stereo Scener' => 'Scener (audio stéréo (2 canaux))',
        'Stereo Voicer' => 'Voix (audio stéréo (2 canaux))',
        'Stereo Wrap' => 'Wrap (audio stéréo (2 canaux))',
        'Text Only' => 'Texte seul (pas de données d\'objet)',
      },
    },
   'Author' => 'Auteur',
   'AuthorsPosition' => 'Titre du créateur',
   'AutoAperture' => {
      Description => 'Auto-diaph',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'AutoBracketRelease' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'AutoBracketing' => {
      Description => 'Bracketing auto',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'AutoExposureBracketing' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'AutoFP' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'AutoFocus' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'AutoISO' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'AutoLightingOptimizer' => {
      Description => 'Correction auto de luminosité',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Actif',
        'Low' => 'Faible',
        'Off' => 'Désactivé',
        'Strong' => 'Importante',
        'n/a' => 'Non établie',
      },
    },
   'AutoLightingOptimizerOn' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'AutoRedEye' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'AutoRotate' => {
      Description => 'Rotation automatique',
      PrintConv => {
        'None' => 'Aucune',
        'Rotate 180' => '180° (bas/droit)',
        'Rotate 270 CW' => '90° sens horaire (gauche/bas)',
        'Rotate 90 CW' => '90° sens antihoraire (droit/haut)',
        'Unknown' => 'Inconnu',
      },
    },
   'AvApertureSetting' => 'Réglage d\'ouverture Av',
   'AvSettingWithoutLens' => {
      Description => 'Réglage Av sans objectif',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activé',
      },
    },
   'BWMode' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'BackgroundColorIndicator' => 'Indicateur de couleur d\'arrière-plan',
   'BackgroundColorValue' => 'Valeur de couleur d\'arrière-plan',
   'BackgroundTiling' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'BadFaxLines' => 'Mauvaises lignes de Fax',
   'BannerImageType' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'BaseExposureCompensation' => 'Compensation d\'exposition de base',
   'BaseURL' => 'URL de base',
   'BaselineExposure' => 'Exposition de base',
   'BaselineNoise' => 'Bruit de base',
   'BaselineSharpness' => 'Accentuation de base',
   'BatteryADBodyLoad' => 'Tension accu boîtier en charge',
   'BatteryADBodyNoLoad' => 'Tension accu boîtier à vide',
   'BatteryADGripLoad' => 'Tension accu poignée en charge',
   'BatteryADGripNoLoad' => 'Tension accu poignée à vide',
   'BatteryLevel' => 'Niveau de batterie',
   'BatteryStates' => {
      Description => 'Etat des accus',
      PrintConv => {
        'Body Battery Almost Empty' => 'Accu boîtier : presque vide',
        'Body Battery Empty or Missing' => 'Accu boîtier : vide ou absent',
        'Body Battery Full' => 'Accu boîtier : plein',
        'Body Battery Running Low' => 'Accu boîtier : en baisse',
        'Grip Battery Almost Empty' => 'Accu poignée : presque vide',
        'Grip Battery Empty or Missing' => 'Accu poignée : vide ou absent',
        'Grip Battery Full' => 'Accu poignée : plein',
        'Grip Battery Running Low' => 'Accu poignée : en baisse',
      },
    },
   'BayerGreenSplit' => 'Séparation de vert Bayer',
   'Beep' => {
      PrintConv => {
        'High' => 'Bruyant',
        'Low' => 'Calme',
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'BestQualityScale' => 'Echelle de meilleure qualité',
   'BitsPerComponent' => 'Bits par composante',
   'BitsPerExtendedRunLength' => 'Bits par « Run Length » étendue',
   'BitsPerRunLength' => 'Bits par « Run Length »',
   'BitsPerSample' => 'Nombre de bits par échantillon',
   'BlackLevel' => 'Niveau noir',
   'BlackLevelDeltaH' => 'Delta H du niveau noir',
   'BlackLevelDeltaV' => 'Delta V du niveau noir',
   'BlackLevelRepeatDim' => 'Dimension de répétition du niveau noir',
   'BlackPoint' => 'Point noir',
   'BlueBalance' => 'Balance bleue',
   'BlueMatrixColumn' => 'Colonne de matrice bleue',
   'BlueTRC' => 'Courbe de reproduction des tons bleus',
   'BlurWarning' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'BracketMode' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'BracketShotNumber' => {
      Description => 'Numéro de cliché en bracketing',
      PrintConv => {
        '1 of 3' => '1 sur 3',
        '1 of 5' => '1 sur 5',
        '2 of 3' => '2 sur 3',
        '2 of 5' => '2 sur 5',
        '3 of 3' => '3 sur 3',
        '3 of 5' => '3 sur 5',
        '4 of 5' => '4 sur 5',
        '5 of 5' => '5 sur 5',
        'n/a' => 'Non établie',
      },
    },
   'BrightnessValue' => 'Luminosité',
   'BulbDuration' => 'Durée du pose longue',
   'BurstMode' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ButtonFunctionControlOff' => {
      Description => 'Fonction de touche si Contrôle Rapide OFF',
      PrintConv => {
        'Disable main, Control, Multi-control' => 'Désactivés principale, Contrôle rapide, Multicontrôleur',
        'Normal (enable)' => 'Normale (activée)',
      },
    },
   'By-line' => 'Créateur',
   'By-lineTitle' => 'Fonction du créateur',
   'CFALayout' => {
      Description => 'Organisation CFA',
      PrintConv => {
        'Even columns offset down 1/2 row' => 'Organisation décalée A : les colonnes paires sont décalées vers le bas d\'une demi-rangée.',
        'Even columns offset up 1/2 row' => 'Organisation décalée B : les colonnes paires sont décalées vers le haut d\'une demi-rangée.',
        'Even rows offset left 1/2 column' => 'Organisation décalée D : les rangées paires sont décalées vers la gauche d\'une demi-colonne.',
        'Even rows offset right 1/2 column' => 'Organisation décalée C : les rangées paires sont décalées vers la droite d\'une demi-colonne.',
        'Rectangular' => 'Plan rectangulaire (ou carré)',
      },
    },
   'CFAPattern' => 'Matrice de filtrage couleur',
   'CFAPattern2' => 'Modèle CFA 2',
   'CFAPlaneColor' => 'Couleur de plan CFA',
   'CFARepeatPatternDim' => 'Dimension du modèle de répétition CFA',
   'CMMFlags' => 'Drapeaux CMM',
   'CMYKEquivalent' => 'Equivalent CMJK',
   'CPUFirmwareVersion' => 'Version de firmware de CPU',
   'CPUType' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'CalibrationDateTime' => 'Date et heure de calibration',
   'CalibrationIlluminant1' => {
      Description => 'Illuminant de calibration 1',
      PrintConv => {
        'Cloudy' => 'Temps nuageux',
        'Cool White Fluorescent' => 'Fluorescente type soft',
        'Day White Fluorescent' => 'Fluorescente type blanc',
        'Daylight' => 'Lumière du jour',
        'Daylight Fluorescent' => 'Fluorescente type jour',
        'Fine Weather' => 'Beau temps',
        'Fluorescent' => 'Fluorescente',
        'ISO Studio Tungsten' => 'Tungstène studio ISO',
        'Other' => 'Autre source de lumière',
        'Shade' => 'Ombre',
        'Standard Light A' => 'Lumière standard A',
        'Standard Light B' => 'Lumière standard B',
        'Standard Light C' => 'Lumière standard C',
        'Tungsten' => 'Tungstène (lumière incandescente)',
        'Unknown' => 'Inconnu',
        'White Fluorescent' => 'Fluorescent blanc',
      },
    },
   'CalibrationIlluminant2' => {
      Description => 'Illuminant de calibration 2',
      PrintConv => {
        'Cloudy' => 'Temps nuageux',
        'Cool White Fluorescent' => 'Fluorescente type soft',
        'Day White Fluorescent' => 'Fluorescente type blanc',
        'Daylight' => 'Lumière du jour',
        'Daylight Fluorescent' => 'Fluorescente type jour',
        'Fine Weather' => 'Beau temps',
        'Fluorescent' => 'Fluorescente',
        'ISO Studio Tungsten' => 'Tungstène studio ISO',
        'Other' => 'Autre source de lumière',
        'Shade' => 'Ombre',
        'Standard Light A' => 'Lumière standard A',
        'Standard Light B' => 'Lumière standard B',
        'Standard Light C' => 'Lumière standard C',
        'Tungsten' => 'Tungstène (lumière incandescente)',
        'Unknown' => 'Inconnu',
        'White Fluorescent' => 'Fluorescent blanc',
      },
    },
   'CameraCalibration1' => 'Calibration d\'appareil 1',
   'CameraCalibration2' => 'Calibration d\'appareil 2',
   'CameraCalibrationSig' => 'Signature de calibration de l\'appareil',
   'CameraOrientation' => {
      Description => 'Orientation de l\'image',
      PrintConv => {
        'Horizontal (normal)' => '0° (haut/gauche)',
        'Rotate 270 CW' => '90° sens horaire (gauche/bas)',
        'Rotate 90 CW' => '90° sens antihoraire (droit/haut)',
      },
    },
   'CameraSerialNumber' => 'Numéro de série de l\'appareil',
   'CameraTemperature' => 'Température de l\'appareil',
   'CameraType' => 'Type d\'objectif Pentax',
   'CanonExposureMode' => {
      PrintConv => {
        'Aperture-priority AE' => 'Priorité ouverture',
        'Bulb' => 'Pose B',
        'Manual' => 'Manuelle',
        'Program AE' => 'Programme d\'exposition automatique',
        'Shutter speed priority AE' => 'Priorité vitesse',
      },
    },
   'CanonFirmwareVersion' => 'Version de firmware',
   'CanonFlashMode' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
        'Red-eye reduction' => 'Réduction yeux rouges',
      },
    },
   'CanonImageSize' => {
      PrintConv => {
        'Large' => 'Grande',
        'Medium' => 'Moyenne',
        'Medium 1' => 'Moyenne 1',
        'Medium 2' => 'Moyenne 2',
        'Medium 3' => 'Moyenne 3',
        'Small' => 'Petite',
      },
    },
   'Caption-Abstract' => 'Légende / Description',
   'CaptionWriter' => 'Rédacteur',
   'CaptureXResolutionUnit' => {
      PrintConv => {
        'um' => 'µm (micromètre)',
      },
    },
   'CaptureYResolutionUnit' => {
      PrintConv => {
        'um' => 'µm (micromètre)',
      },
    },
   'Categories' => 'Catégories',
   'Category' => 'Catégorie',
   'CellLength' => 'Longueur de cellule',
   'CellWidth' => 'Largeur de cellule',
   'CenterWeightedAreaSize' => {
      PrintConv => {
        'Average' => 'Moyenne',
      },
    },
   'Certificate' => 'Certificat',
   'CharTarget' => 'Cible caractère',
   'ChromaBlurRadius' => 'Rayon de flou de chromatisme',
   'ChromaticAdaptation' => 'Adaptation chromatique',
   'ChrominanceNR_TIFF_JPEG' => {
      PrintConv => {
        'Low' => 'Bas',
        'Off' => 'Désactivé',
      },
    },
   'ChrominanceNoiseReduction' => {
      PrintConv => {
        'Low' => 'Bas',
        'Off' => 'Désactivé',
      },
    },
   'CircleOfConfusion' => 'Cercle de confusion',
   'City' => 'Ville',
   'ClassifyState' => 'Etat de classification',
   'CleanFaxData' => 'Données de Fax propres',
   'ClipPath' => 'Chemin de rognage',
   'CodedCharacterSet' => 'Jeu de caractères codé',
   'ColorAberrationControl' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ColorAdjustmentMode' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ColorBalanceAdj' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ColorBooster' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ColorCalibrationMatrix' => 'Table de matrice de calibration de couleur',
   'ColorCharacterization' => 'Caractérisation de couleur',
   'ColorComponents' => 'Composants colorimétriques',
   'ColorEffect' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'ColorFilter' => {
      PrintConv => {
        'Blue' => 'Bleu',
        'Green' => 'Vert',
        'Off' => 'Désactivé',
        'Red' => 'Rouge',
        'Yellow' => 'Jaune',
      },
    },
   'ColorMap' => 'Charte de couleur',
   'ColorMatrix1' => 'Matrice de couleur 1',
   'ColorMatrix2' => 'Matrice de couleur 2',
   'ColorMode' => {
      Description => 'Mode colorimétrique',
      PrintConv => {
        'Evening' => 'Soir',
        'Landscape' => 'Paysage',
        'Natural' => 'Naturel',
        'Night Scene' => 'Nocturne',
        'Normal' => 'Normale',
        'Off' => 'Désactivé',
        'RGB' => 'RVB',
        'Sunset' => 'Coucher de soleil',
      },
    },
   'ColorMoireReduction' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ColorMoireReductionMode' => {
      PrintConv => {
        'Low' => 'Bas',
        'Off' => 'Désactivé',
      },
    },
   'ColorPalette' => 'Palette de couleur',
   'ColorRepresentation' => {
      Description => 'Représentation de couleur',
      PrintConv => {
        '3 Components, Frame Sequential in Multiple Objects' => 'Trois composantes, Vue séquentielle dans différents objets',
        '3 Components, Frame Sequential in One Object' => 'Trois composantes, Vue séquentielle dans un objet',
        '3 Components, Line Sequential' => 'Trois composantes, Ligne séquentielle',
        '3 Components, Pixel Sequential' => 'Trois composantes, Pixel séquentiel',
        '3 Components, Single Frame' => 'Trois composantes, Vue unique',
        '3 Components, Special Interleaving' => 'Trois composantes, Entrelacement spécial',
        '4 Components, Frame Sequential in Multiple Objects' => 'Quatre composantes, Vue séquentielle dans différents objets',
        '4 Components, Frame Sequential in One Object' => 'Quatre composantes, Vue séquentielle dans un objet',
        '4 Components, Line Sequential' => 'Quatre composantes, Ligne séquentielle',
        '4 Components, Pixel Sequential' => 'Quatre composantes, Pixel séquentiel',
        '4 Components, Single Frame' => 'Quatre composantes, Vue unique',
        '4 Components, Special Interleaving' => 'Quatre composantes, Entrelacement spécial',
        'Monochrome, Single Frame' => 'Monochrome, Vue unique',
        'No Image, Single Frame' => 'Pas d\'image, Vue unique',
      },
    },
   'ColorResponseUnit' => 'Unité de réponse couleur',
   'ColorSequence' => 'Séquence de couleur',
   'ColorSpace' => {
      Description => 'Espace colorimétrique',
      PrintConv => {
        'RGB' => 'RVB',
        'Uncalibrated' => 'Non calibré',
      },
    },
   'ColorSpaceData' => 'Espace de couleur de données',
   'ColorTable' => 'Tableau de couleurs',
   'ColorTemperature' => 'Température de couleur',
   'ColorTone' => {
      Description => 'Teinte couleur',
      PrintConv => {
        'Normal' => 'Normale',
      },
    },
   'ColorType' => {
      PrintConv => {
        'RGB' => 'RVB',
      },
    },
   'ColorantOrder' => 'Ordre de colorant',
   'ColorimetricReference' => 'Référence colorimétrique',
   'CommandDialsChangeMainSub' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'CommandDialsMenuAndPlayback' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'CommandDialsReverseRotation' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'CommanderGroupAMode' => {
      PrintConv => {
        'Manual' => 'Manuelle',
        'Off' => 'Désactivé',
      },
    },
   'CommanderGroupBMode' => {
      PrintConv => {
        'Manual' => 'Manuelle',
        'Off' => 'Désactivé',
      },
    },
   'CommanderInternalFlash' => {
      PrintConv => {
        'Manual' => 'Manuelle',
        'Off' => 'Désactivé',
      },
    },
   'Comment' => 'Commentaire',
   'Comments' => 'Commentaires',
   'Compilation' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'ComponentsConfiguration' => 'Signification de chaque composante',
   'CompressedBitsPerPixel' => 'Mode de compression d\'image',
   'Compression' => {
      Description => 'Schéma de compression',
      PrintConv => {
        'Epson ERF Compressed' => 'Compression Epson ERF',
        'JBIG Color' => 'JBIG Couleur',
        'JPEG (old-style)' => 'JPEG (ancien style)',
        'Kodak DCR Compressed' => 'Compression Kodak DCR',
        'Kodak KDC Compressed' => 'Compression Kodak KDC',
        'Next' => 'Encodage NeXT 2 bits',
        'Nikon NEF Compressed' => 'Compression Nikon NEF',
        'None' => 'Aucune',
        'Pentax PEF Compressed' => 'Compression Pentax PEF',
        'SGILog' => 'Encodage Log luminance SGI 32 bits',
        'SGILog24' => 'Encodage Log luminance SGI 24 bits',
        'Sony ARW Compressed' => 'Compression Sony ARW',
        'Thunderscan' => 'Encodage ThunderScan 4 bits',
        'Uncompressed' => 'Non compressé',
      },
    },
   'CompressionType' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'ConditionalFEC' => 'Compensation exposition flash',
   'ConnectionSpaceIlluminant' => 'Illuminant d\'espace de connexion',
   'ConsecutiveBadFaxLines' => 'Mauvaises lignes de Fax consécutives',
   'ContentLocationCode' => 'Code du lieu du contenu',
   'ContentLocationName' => 'Nom du lieu du contenu',
   'ContentType' => {
      PrintConv => {
        'Normal' => 'Normale',
      },
    },
   'ContinuousDrive' => {
      PrintConv => {
        'Movie' => 'Vidéo',
      },
    },
   'ContinuousShootingSpeed' => {
      Description => 'Vitesse de prise de vues en continu',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activée',
      },
    },
   'ContinuousShotLimit' => {
      Description => 'Limiter nombre de vues en continu',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activée',
      },
    },
   'Contrast' => {
      Description => 'Contraste',
      PrintConv => {
        'High' => 'Dur',
        'Low' => 'Doux',
        'Med High' => 'Assez fort',
        'Med Low' => 'Assez faible',
        'Normal' => 'Normale',
        'Very High' => 'Très fort',
        'Very Low' => 'Très faible',
      },
    },
   'Contributor' => 'Contributeur',
   'ControlMode' => {
      PrintConv => {
        'n/a' => 'Non établie',
      },
    },
   'ConversionLens' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'Copyright' => 'Propriétaire du copyright',
   'CopyrightNotice' => 'Mention de copyright',
   'CopyrightStatus' => {
      PrintConv => {
        'Unknown' => 'Inconnu',
      },
    },
   'Country' => 'Pays',
   'Country-PrimaryLocationCode' => 'Code de pays ISO',
   'Country-PrimaryLocationName' => 'Pays',
   'CountryCode' => 'Code pays',
   'Coverage' => 'Couverture',
   'CreateDate' => 'Date de la création des données numériques',
   'CreationDate' => 'Date de création',
   'Creator' => 'Créateur',
   'CreatorAddress' => 'Adresse du créateur',
   'CreatorCity' => 'Lieu d\'Habitation du créateur',
   'CreatorCountry' => 'Pays du créateur',
   'CreatorPostalCode' => 'Code postal du créateur',
   'CreatorRegion' => 'Région du créateur',
   'CreatorTool' => 'Outil de création',
   'CreatorWorkEmail' => 'Courriel professionnel du créateur',
   'CreatorWorkTelephone' => 'Téléphone professionnel créateur',
   'CreatorWorkURL' => 'URL professionnelle du créateur',
   'Credit' => 'Fournisseur',
   'CropActive' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'CropUnit' => {
      PrintConv => {
        'inches' => 'Pouce',
      },
    },
   'CropUnits' => {
      PrintConv => {
        'inches' => 'Pouce',
      },
    },
   'CurrentICCProfile' => 'Profil ICC actuel',
   'CurrentIPTCDigest' => 'Sommaire courant IPTC',
   'CurrentPreProfileMatrix' => 'Matrice de pré-profil actuelle',
   'Curves' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'CustomRendered' => {
      Description => 'Traitement d\'image personnalisé',
      PrintConv => {
        'Custom' => 'Traitement personnalisé',
        'Normal' => 'Traitement normal',
      },
    },
   'D-LightingHQ' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'D-LightingHQSelected' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'D-LightingHS' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'DNGBackwardVersion' => 'Version DNG antérieure',
   'DNGLensInfo' => 'Distance focale minimale',
   'DNGVersion' => 'Version DNG',
   'DOF' => 'Profondeur de champ',
   'DSPFirmwareVersion' => 'Version de firmware de DSP',
   'DataCompressionMethod' => 'Fournisseur/propriétaire de l\'algorithme de compression de données',
   'DataDump' => 'Vidage données',
   'DataImprint' => {
      PrintConv => {
        'None' => 'Aucune',
        'Text' => 'Texte',
      },
    },
   'DataType' => 'Type de données',
   'DateCreated' => 'Date de création',
   'DateSent' => 'Date d\'envoi',
   'DateStampMode' => {
      PrintConv => {
        'Date & Time' => 'Date et heure',
        'Off' => 'Désactivé',
      },
    },
   'DateTime' => 'Date de modification du fichier',
   'DateTimeCreated' => 'Date/heure de création',
   'DateTimeDigitized' => 'Date/heure de la numérisation',
   'DateTimeOriginal' => 'Date de la création des données originales',
   'DaylightSavings' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'DefaultCropOrigin' => 'Origine de rognage par défaut',
   'DefaultCropSize' => 'Taille de rognage par défaut',
   'DefaultScale' => 'Echelle par défaut',
   'DestinationCity' => 'Ville de destination',
   'DestinationCityCode' => 'Code ville de destination',
   'DestinationDST' => {
      Description => 'Heure d\'été de destination',
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'DeviceAttributes' => 'Attributs d\'appareil',
   'DeviceManufacturer' => 'Fabricant de l\'appareil',
   'DeviceMfgDesc' => 'Description du fabricant d\'appareil',
   'DeviceModel' => 'Modèle de l\'appareil',
   'DeviceModelDesc' => 'Description du modèle d\'appareil',
   'DeviceSettingDescription' => 'Description des réglages du dispositif',
   'DialDirectionTvAv' => {
      Description => 'Drehung Wählrad bei Tv/Av',
      PrintConv => {
        'Normal' => 'Normale',
        'Reversed' => 'Sens inversé',
      },
    },
   'DigitalCreationDate' => 'Date de numérisation',
   'DigitalCreationTime' => 'Heure de numérisation',
   'DigitalImageGUID' => 'GUID de l\'image numérique',
   'DigitalSourceFileType' => 'Type de fichier de la source numérique',
   'DigitalZoom' => {
      Description => 'Zoom numérique',
      PrintConv => {
        'None' => 'Aucune',
        'Off' => 'Désactivé',
      },
    },
   'DigitalZoomOn' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'DigitalZoomRatio' => 'Rapport de zoom numérique',
   'Directory' => 'Dossier',
   'DisplaySize' => {
      PrintConv => {
        'Normal' => 'Normale',
      },
    },
   'DisplayUnits' => {
      PrintConv => {
        'inches' => 'Pouce',
      },
    },
   'DisplayXResolutionUnit' => {
      PrintConv => {
        'um' => 'µm (micromètre)',
      },
    },
   'DisplayYResolutionUnit' => {
      PrintConv => {
        'um' => 'µm (micromètre)',
      },
    },
   'DisplayedUnitsX' => {
      PrintConv => {
        'inches' => 'Pouce',
      },
    },
   'DisplayedUnitsY' => {
      PrintConv => {
        'inches' => 'Pouce',
      },
    },
   'DistortionCorrection' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'DistortionCorrection2' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'DjVuVersion' => 'Version DjVu',
   'DocumentHistory' => 'Historique du document',
   'DocumentName' => 'Nom du document',
   'DocumentNotes' => 'Remarques sur le document',
   'DotRange' => 'Étendue de points',
   'DriveMode' => {
      Description => 'Mode de prise de vue',
      PrintConv => {
        'Burst' => 'Rafale',
        'Continuous' => 'Continu',
        'Continuous (Hi)' => 'Continu (ultrarapide)',
        'Continuous shooting' => 'Prise de vues en continu',
        'Multiple Exposure' => 'Exposition multiple',
        'No Timer' => 'Pas de retardateur',
        'Off' => 'Désactivé',
        'Remote Control' => 'Télécommande',
        'Remote Control (3 s delay)' => 'Télécommande (retard 3 s)',
        'Self-timer (12 s)' => 'Retardateur (12 s)',
        'Self-timer (2 s)' => 'Retardateur (2 s)',
        'Self-timer Operation' => 'Retardateur',
        'Shutter Button' => 'Déclencheur',
        'Single Exposure' => 'Exposition unique',
        'Single-frame' => 'Vue par vue',
        'Single-frame shooting' => 'Prise de vue unique',
      },
    },
   'DriveMode2' => {
      Description => 'Exposition multiple',
      PrintConv => {
        'Single-frame' => 'Vue par vue',
      },
    },
   'Duration' => 'Durée',
   'DynamicRangeExpansion' => {
      Description => 'Expansion de la dynamique',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'DynamicRangeOptimizer' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'E-DialInProgram' => {
      PrintConv => {
        'P Shift' => 'Décalage P',
        'Tv or Av' => 'Tv ou Av',
      },
    },
   'ETTLII' => {
      PrintConv => {
        'Average' => 'Moyenne',
        'Evaluative' => 'Évaluative',
      },
    },
   'EVSteps' => {
      Description => 'Pas IL',
      PrintConv => {
        '1/2 EV Steps' => 'Pas de 1/2 IL',
        '1/2 EV steps' => 'Pas de 1/2 IL',
        '1/3 EV Steps' => 'Pas de 1/3 IL',
        '1/3 EV steps' => 'Pas de 1/3 IL',
      },
    },
   'EasyExposureCompensation' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'EasyMode' => {
      PrintConv => {
        'Beach' => 'Plage',
        'Color Accent' => 'Couleur contrastée',
        'Color Swap' => 'Permuter couleur',
        'Fireworks' => 'Feu d\'artifice',
        'Foliage' => 'Feuillages',
        'Indoor' => 'Intérieur',
        'Kids & Pets' => 'Enfants & animaux',
        'Landscape' => 'Paysage',
        'Manual' => 'Manuelle',
        'Night' => 'Scène de nuit',
        'Night Snapshot' => 'Mode Nuit',
        'Snow' => 'Neige',
        'Sports' => 'Sport',
        'Super Macro' => 'Super macro',
        'Underwater' => 'Sous-marin',
      },
    },
   'EdgeNoiseReduction' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'EditStatus' => 'Statut d\'édition',
   'EditorialUpdate' => {
      Description => 'Mise à jour éditoriale',
      PrintConv => {
        'Additional language' => 'Langues supplémentaires',
      },
    },
   'EffectiveLV' => 'Indice de lumination effectif',
   'Emphasis' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'EncodingProcess' => {
      Description => 'Procédé de codage',
      PrintConv => {
        'Baseline DCT, Huffman coding' => 'Baseline DCT, codage Huffman',
        'Extended sequential DCT, Huffman coding' => 'Extended sequential DCT, codage Huffman',
        'Extended sequential DCT, arithmetic coding' => 'Extended sequential DCT, codage arithmétique',
        'Lossless, Differential Huffman coding' => 'Lossless, codage Huffman différentiel',
        'Lossless, Huffman coding' => 'Lossless, codage Huffman',
        'Lossless, arithmetic coding' => 'Lossless, codage arithmétique',
        'Lossless, differential arithmetic coding' => 'Lossless, codage arithmétique différentiel',
        'Progressive DCT, Huffman coding' => 'Progressive DCT, codage Huffman',
        'Progressive DCT, arithmetic coding' => 'Progressive DCT, codage arithmétique',
        'Progressive DCT, differential Huffman coding' => 'Progressive DCT, codage Huffman différentiel',
        'Progressive DCT, differential arithmetic coding' => 'Progressive DCT, codage arithmétique différentiel',
        'Sequential DCT, differential Huffman coding' => 'Sequential DCT, codage Huffman différentiel',
        'Sequential DCT, differential arithmetic coding' => 'Sequential DCT, codage arithmétique différentiel',
      },
    },
   'Encryption' => 'Chiffrage',
   'EndPoints' => 'Points de terminaison',
   'EnhanceDarkTones' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'Enhancement' => {
      PrintConv => {
        'Blue' => 'Bleu',
        'Green' => 'Vert',
        'Off' => 'Désactivé',
        'Red' => 'Rouge',
      },
    },
   'EnvelopeNumber' => 'Numéro d\'enveloppe',
   'EnvelopePriority' => {
      Description => 'Priorité d\'enveloppe',
      PrintConv => {
        '0 (reserved)' => '0 (réservé pour utilisation future)',
        '1 (most urgent)' => '1 (très urgent)',
        '5 (normal urgency)' => '5 (normalement urgent)',
        '8 (least urgent)' => '8 (moins urgent)',
        '9 (user-defined priority)' => '9 (priorité définie par l\'utilisateur)',
      },
    },
   'EnvelopeRecordVersion' => 'Version d\'enregistrement',
   'Error' => 'Erreur',
   'Event' => 'Evenement',
   'ExcursionTolerance' => {
      Description => 'Tolérance d\'excursion ',
      PrintConv => {
        'Allowed' => 'Possible',
        'Not Allowed' => 'Non permis (défaut)',
      },
    },
   'ExifByteOrder' => 'Indicateur d\'ordre des octets Exif',
   'ExifCameraInfo' => 'Info d\'appareil photo Exif',
   'ExifImageHeight' => 'Hauteur d\'image',
   'ExifImageWidth' => 'Largeur d\'image',
   'ExifToolVersion' => 'Version ExifTool',
   'ExifUnicodeByteOrder' => 'Indicateur d\'ordre des octets Unicode Exif',
   'ExifVersion' => 'Version Exif',
   'ExpandFilm' => 'Extension film',
   'ExpandFilterLens' => 'Extension lentille filtre',
   'ExpandFlashLamp' => 'Extension lampe flash',
   'ExpandLens' => 'Extension objectif',
   'ExpandScanner' => 'Extension Scanner',
   'ExpandSoftware' => 'Extension logiciel',
   'ExpirationDate' => 'Date d\'expiration',
   'ExpirationTime' => 'Heure d\'expiration',
   'ExposureBracketStepSize' => 'Intervalle de bracketing d\'exposition',
   'ExposureCompensation' => 'Décalage d\'exposition',
   'ExposureDelayMode' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ExposureIndex' => 'Indice d\'exposition',
   'ExposureLevelIncrements' => {
      Description => 'Paliers de réglage d\'expo',
      PrintConv => {
        '1-stop set, 1/3-stop comp.' => 'Réglage 1 valeur, correction 1/3 val.',
        '1/2 Stop' => 'Palier 1/2',
        '1/2-stop set, 1/2-stop comp.' => 'Réglage 1/2 valeur, correction 1/2 val.',
        '1/3 Stop' => 'Palier 1/3',
        '1/3-stop set, 1/3-stop comp.' => 'Réglage 1/3 valeur, correction 1/3 val.',
      },
    },
   'ExposureMode' => {
      Description => 'Mode d\'exposition',
      PrintConv => {
        'Aperture Priority' => 'Priorité ouverture',
        'Aperture-priority AE' => 'Priorité ouverture',
        'Auto' => 'Exposition automatique',
        'Auto bracket' => 'Bracketting auto',
        'Bulb' => 'Pose B',
        'Landscape' => 'Paysage',
        'Manual' => 'Exposition manuelle',
        'Night Scene' => 'Nocturne',
        'Shutter Priority' => 'Priorité vitesse',
        'Shutter speed priority AE' => 'Priorité vitesse',
      },
    },
   'ExposureModeInManual' => {
      Description => 'Mode d\'exposition manuelle',
      PrintConv => {
        'Center-weighted average' => 'Centrale pondérée',
        'Evaluative metering' => 'Mesure évaluativ',
        'Partial metering' => 'Partielle',
        'Specified metering mode' => 'Mode de mesure spécifié',
        'Spot metering' => 'Spot',
      },
    },
   'ExposureProgram' => {
      Description => 'Programme d\'exposition',
      PrintConv => {
        'Action (High speed)' => 'Programme action (orienté grandes vitesses d\'obturation)',
        'Aperture Priority' => 'Priorité ouverture',
        'Aperture-priority AE' => 'Priorité ouverture',
        'Creative (Slow speed)' => 'Programme créatif (orienté profondeur de champ)',
        'Landscape' => 'Mode paysage',
        'Manual' => 'Manuel',
        'Not Defined' => 'Non défini',
        'Portrait' => 'Mode portrait',
        'Program AE' => 'Programme normal',
        'Shutter Priority' => 'Priorité vitesse',
        'Shutter speed priority AE' => 'Priorité vitesse',
      },
    },
   'ExposureTime' => 'Temps de pose',
   'ExposureTime2' => 'Temps de pose 2',
   'ExtendedWBDetect' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ExtenderStatus' => {
      PrintConv => {
        'Attached' => 'Attaché',
        'Not attached' => 'Non attaché',
        'Removed' => 'Retiré',
      },
    },
   'ExternalFlash' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ExternalFlashBounce' => {
      Description => 'Réflexion flash externe',
      PrintConv => {
        'Bounce' => 'Avec réflecteur',
        'No' => 'Non',
        'Yes' => 'Oui',
        'n/a' => 'Non établie',
      },
    },
   'ExternalFlashExposureComp' => {
      Description => 'Compensation d\'exposition flash externe',
      PrintConv => {
        '-0.5' => '-0.5 IL',
        '-1.0' => '-1.0 IL',
        '-1.5' => '-1.5 IL',
        '-2.0' => '-2.0 IL',
        '-2.5' => '-2.5 IL',
        '-3.0' => '-3.0 IL',
        '0.0' => '0.0 IL',
        '0.5' => '0.5 IL',
        '1.0' => '1.0 IL',
        'n/a' => 'Non établie (éteint ou modes auto)',
        'n/a (Manual Mode)' => 'Non établie (mode manuel)',
      },
    },
   'ExternalFlashMode' => {
      Description => 'Segment de mesure flash esclave 3',
      PrintConv => {
        'Off' => 'Désactivé',
        'On, Auto' => 'En service, auto',
        'On, Contrast-control Sync' => 'En service, synchro contrôle des contrastes',
        'On, Flash Problem' => 'En service, problème de flash',
        'On, High-speed Sync' => 'En service, synchro haute vitesse',
        'On, Manual' => 'En service, manuel',
        'On, P-TTL Auto' => 'En service, auto P-TTL',
        'On, Wireless' => 'En service, sans cordon',
        'On, Wireless, High-speed Sync' => 'En service, sans cordon, synchro haute vitesse',
        'n/a - Off-Auto-Aperture' => 'N/c - auto-diaph hors service',
      },
    },
   'ExtraSamples' => 'Echantillons supplémentaires',
   'FNumber' => 'Nombre F',
   'FOV' => 'Champ de vision',
   'FastSeek' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'FaxProfile' => {
      PrintConv => {
        'Unknown' => 'Inconnu',
      },
    },
   'FaxRecvParams' => 'Paramètres de réception Fax',
   'FaxRecvTime' => 'Temps de réception Fax',
   'FaxSubAddress' => 'Sous-adresse Fax',
   'FileFormat' => 'Format de fichier',
   'FileModifyDate' => 'Date/heure de modification du fichier',
   'FileName' => 'Nom de fichier',
   'FileNumber' => 'Numéro de fichier',
   'FileNumberMemory' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'FileNumberSequence' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'FileSize' => 'Taille du fichier',
   'FileSource' => {
      Description => 'Source du fichier',
      PrintConv => {
        'Digital Camera' => 'Appareil photo numérique',
        'Film Scanner' => 'Scanner de film',
        'Reflection Print Scanner' => 'Scanner par réflexion',
      },
    },
   'FileType' => 'Type de fichier',
   'FileVersion' => 'Version de format de fichier',
   'FillFlashAutoReduction' => {
      Description => 'Mesure E-TTL',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activé',
      },
    },
   'FillOrder' => {
      Description => 'Ordre de remplissage',
      PrintConv => {
        'Normal' => 'Normale',
      },
    },
   'Filter' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'FilterEffect' => {
      Description => 'Effet de filtre',
      PrintConv => {
        'Green' => 'Vert',
        'None' => 'Aucune',
        'Off' => 'Désactivé',
        'Red' => 'Rouge',
        'Yellow' => 'Jaune',
        'n/a' => 'Non établie',
      },
    },
   'FilterEffectMonochrome' => {
      PrintConv => {
        'Green' => 'Vert',
        'None' => 'Aucune',
        'Red' => 'Rouge',
        'Yellow' => 'Jaune',
      },
    },
   'FinderDisplayDuringExposure' => {
      Description => 'Affich. viseur pendant expo.',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'FirmwareVersion' => 'Version de firmware',
   'FixtureIdentifier' => 'Identificateur d\'installation',
   'Flash' => {
      PrintConv => {
        'Auto, Did not fire' => 'Flash non déclenché, mode auto',
        'Auto, Did not fire, Red-eye reduction' => 'Auto, flash non déclenché, mode réduction yeux rouges',
        'Auto, Fired' => 'Flash déclenché, mode auto',
        'Auto, Fired, Red-eye reduction' => 'Flash déclenché, mode auto, mode réduction yeux rouges, lumière renvoyée détectée',
        'Auto, Fired, Red-eye reduction, Return detected' => 'Flash déclenché, mode auto, lumière renvoyée détectée, mode réduction yeux rouges',
        'Auto, Fired, Red-eye reduction, Return not detected' => 'Flash déclenché, mode auto, lumière renvoyée non détectée, mode réduction yeux rouges',
        'Auto, Fired, Return detected' => 'Flash déclenché, mode auto, lumière renvoyée détectée',
        'Auto, Fired, Return not detected' => 'Flash déclenché, mode auto, lumière renvoyée non détectée',
        'Did not fire' => 'Flash non déclenché',
        'Fired' => 'Flash déclenché',
        'Fired, Red-eye reduction' => 'Flash déclenché, mode réduction yeux rouges',
        'Fired, Red-eye reduction, Return detected' => 'Flash déclenché, mode réduction yeux rouges, lumière renvoyée détectée',
        'Fired, Red-eye reduction, Return not detected' => 'Flash déclenché, mode réduction yeux rouges, lumière renvoyée non détectée',
        'Fired, Return detected' => 'Lumière renvoyée sur le capteur détectée',
        'Fired, Return not detected' => 'Lumière renvoyée sur le capteur non détectée',
        'No Flash' => 'Flash non déclenché',
        'No flash function' => 'Pas de fonction flash',
        'Off' => 'Désactivé',
        'Off, Did not fire' => 'Flash non déclenché, mode flash forcé',
        'Off, Did not fire, Return not detected' => 'Éteint, flash non déclenché, lumière renvoyée non détectée',
        'Off, No flash function' => 'Éteint, pas de fonction flash',
        'Off, Red-eye reduction' => 'Éteint, mode réduction yeux rouges',
        'On' => 'Activé',
        'On, Did not fire' => 'Hors service, flash non déclenché',
        'On, Fired' => 'Flash déclenché, mode flash forcé',
        'On, Red-eye reduction' => 'Flash déclenché, mode forcé, mode réduction yeux rouges',
        'On, Red-eye reduction, Return detected' => 'Flash déclenché, mode forcé, mode réduction yeux rouges, lumière renvoyée détectée',
        'On, Red-eye reduction, Return not detected' => 'Flash déclenché, mode forcé, mode réduction yeux rouges, lumière renvoyée non détectée',
        'On, Return detected' => 'Flash déclenché, mode flash forcé, lumière renvoyée détectée',
        'On, Return not detected' => 'Flash déclenché, mode flash forcé, lumière renvoyée non détectée',
      },
    },
   'FlashCommanderMode' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'FlashCompensation' => 'Compensation flash',
   'FlashControlMode' => {
      PrintConv => {
        'Manual' => 'Manuelle',
        'Off' => 'Désactivé',
      },
    },
   'FlashDevice' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'FlashEnergy' => 'Énergie du flash',
   'FlashExposureComp' => 'Compensation d\'exposition au flash',
   'FlashExposureCompSet' => 'Réglage de compensation d\'exposition au flash',
   'FlashExposureLock' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'FlashFired' => {
      Description => 'Flash utilisé',
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'FlashFiring' => {
      Description => 'Émission de l\'éclair',
      PrintConv => {
        'Does not fire' => 'Désactivé',
        'Fires' => 'Activé',
      },
    },
   'FlashFunction' => 'Fonction flash',
   'FlashGroupAControlMode' => {
      PrintConv => {
        'Manual' => 'Manuelle',
        'Off' => 'Désactivé',
      },
    },
   'FlashGroupBControlMode' => {
      PrintConv => {
        'Manual' => 'Manuelle',
        'Off' => 'Désactivé',
      },
    },
   'FlashGroupCControlMode' => {
      PrintConv => {
        'Manual' => 'Manuelle',
        'Off' => 'Désactivé',
      },
    },
   'FlashIntensity' => {
      PrintConv => {
        'High' => 'Haut',
        'Low' => 'Bas',
        'Normal' => 'Normale',
        'Strong' => 'Forte',
      },
    },
   'FlashMeteringSegments' => 'Segments de mesure flash',
   'FlashMode' => {
      Description => 'Mode flash',
      PrintConv => {
        'Auto, Did not fire' => 'Auto, non déclenché',
        'Auto, Did not fire, Red-eye reduction' => 'Auto, non déclenché, réduction yeux rouges',
        'Auto, Fired' => 'Auto, déclenché',
        'Auto, Fired, Red-eye reduction' => 'Auto, déclenché, réduction yeux rouges',
        'External, Auto' => 'Externe, auto',
        'External, Contrast-control Sync' => 'Externe, synchro contrôle des contrastes',
        'External, Flash Problem' => 'Externe, problème de flash ?',
        'External, High-speed Sync' => 'Externe, synchro haute vitesse',
        'External, Manual' => 'Externe, manuel',
        'External, P-TTL Auto' => 'Externe, P-TTL',
        'External, Wireless' => 'Externe, sans cordon',
        'External, Wireless, High-speed Sync' => 'Externe, sans cordon, synchro haute vitesse',
        'Internal' => 'Interne',
        'Normal' => 'Normale',
        'Off' => 'Désactivé',
        'Off, Did not fire' => 'Hors service',
        'On' => 'Activé',
        'On, Did not fire' => 'En service, non déclenché',
        'On, Fired' => 'En service',
        'On, Red-eye reduction' => 'En service, réduction yeux rouges',
        'On, Slow-sync' => 'En service, synchro lente',
        'On, Slow-sync, Red-eye reduction' => 'En service, synchro lente, réduction yeux rouges',
        'On, Soft' => 'En service, doux',
        'On, Trailing-curtain Sync' => 'En service, synchro 2e rideau',
        'On, Wireless (Control)' => 'En service, sans cordon (esclave)',
        'On, Wireless (Master)' => 'En service, sans cordon (maître)',
        'Red-eye Reduction' => 'Réduction yeux rouges',
        'Red-eye reduction' => 'Réduction yeux rouges',
        'Unknown' => 'Inconnu',
        'n/a - Off-Auto-Aperture' => 'N/c - auto-diaph hors service',
      },
    },
   'FlashModel' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'FlashOptions' => {
      Description => 'Options de flash',
      PrintConv => {
        'Auto, Red-eye reduction' => 'Auto, réduction yeux rouges',
        'Normal' => 'Normale',
        'Red-eye reduction' => 'Réduction yeux rouges',
        'Slow-sync' => 'Synchro lente',
        'Slow-sync, Red-eye reduction' => 'Synchro lente, réduction yeux rouges',
        'Trailing-curtain Sync' => 'Synchro 2e rideau',
        'Wireless (Control)' => 'Sans cordon (contrôleur)',
        'Wireless (Master)' => 'Sans cordon (maître)',
      },
    },
   'FlashOptions2' => {
      Description => 'Options de flash (2)',
      PrintConv => {
        'Auto, Red-eye reduction' => 'Auto, réduction yeux rouges',
        'Normal' => 'Normale',
        'Red-eye reduction' => 'Réduction yeux rouges',
        'Slow-sync' => 'Synchro lente',
        'Slow-sync, Red-eye reduction' => 'Synchro lente, réduction yeux rouges',
        'Trailing-curtain Sync' => 'Synchro 2e rideau',
        'Wireless (Control)' => 'Sans cordon (contrôleur)',
        'Wireless (Master)' => 'Sans cordon (maître)',
      },
    },
   'FlashRedEyeMode' => 'Flash mode anti-yeux rouges',
   'FlashReturn' => {
      PrintConv => {
        'No return detection' => 'Pas de détection de retour',
        'Return detected' => 'Retour détecté',
        'Return not detected' => 'Retour non détecté',
      },
    },
   'FlashStatus' => {
      Description => 'Segment de mesure flash esclave 1',
      PrintConv => {
        'External, Did not fire' => 'Externe, non déclenché',
        'External, Fired' => 'Externe, déclenché',
        'Internal, Did not fire' => 'Interne, non déclenché',
        'Internal, Fired' => 'Interne, déclenché',
        'Off' => 'Désactivé',
      },
    },
   'FlashSyncSpeedAv' => {
      Description => 'Vitesse synchro en mode Av',
      PrintConv => {
        '1/200 Fixed' => '1/200 fixe',
        '1/250 Fixed' => '1/250 fixe',
        '1/300 Fixed' => '1/300 fixe',
      },
    },
   'FlashType' => {
      Description => 'Type de flash',
      PrintConv => {
        'Built-In Flash' => 'Intégré',
        'External' => 'Externe',
        'None' => 'Aucune',
      },
    },
   'FlashWarning' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'FlashpixVersion' => 'Version Flashpix supportée',
   'FlickerReduce' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'FlipHorizontal' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'FocalLength' => 'Focale de l\'objectif',
   'FocalLength35efl' => 'Focale de l\'objectif',
   'FocalLengthIn35mmFormat' => 'Distance focale sur film 35 mm',
   'FocalPlaneResolutionUnit' => {
      Description => 'Unité de résolution de plan focal',
      PrintConv => {
        'None' => 'Aucune',
        'inches' => 'Pouce',
        'um' => 'µm (micromètre)',
      },
    },
   'FocalPlaneXResolution' => 'Résolution X du plan focal',
   'FocalPlaneYResolution' => 'Résolution Y du plan focal',
   'Focus' => {
      PrintConv => {
        'Manual' => 'Manuelle',
      },
    },
   'FocusContinuous' => {
      PrintConv => {
        'Manual' => 'Manuelle',
      },
    },
   'FocusMode' => {
      Description => 'Mode mise au point',
      PrintConv => {
        'AF-C' => 'AF-C (prise de vue en rafale)',
        'AF-S' => 'AF-S (prise de vue unique)',
        'Infinity' => 'Infini',
        'Manual' => 'Manuelle',
        'Normal' => 'Normale',
        'Pan Focus' => 'Hyperfocale',
      },
    },
   'FocusMode2' => {
      Description => 'Mode mise au point 2',
      PrintConv => {
        'AF-C' => 'AF-C (prise de vue en rafale)',
        'AF-S' => 'AF-S (prise de vue unique)',
        'Manual' => 'Manuelle',
      },
    },
   'FocusModeSetting' => {
      PrintConv => {
        'AF-C' => 'AF-C (prise de vue en rafale)',
        'AF-S' => 'AF-S (prise de vue unique)',
        'Manual' => 'Manuelle',
      },
    },
   'FocusPosition' => 'Distance de mise au point',
   'FocusRange' => {
      PrintConv => {
        'Infinity' => 'Infini',
        'Manual' => 'Manuelle',
        'Normal' => 'Normale',
        'Pan Focus' => 'Hyperfocale',
        'Super Macro' => 'Super macro',
      },
    },
   'FocusTrackingLockOn' => {
      PrintConv => {
        'Normal' => 'Normale',
        'Off' => 'Désactivé',
      },
    },
   'FocusingScreen' => 'Verre de visée',
   'ForwardMatrix1' => 'Matrice forward 1',
   'ForwardMatrix2' => 'Matrice forward 2',
   'FrameNumber' => 'Numéro de vue',
   'FreeByteCounts' => 'Nombre d\'octets libres',
   'FreeOffsets' => 'Offsets libres',
   'FujiFlashMode' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
        'Red-eye reduction' => 'Réduction yeux rouges',
      },
    },
   'GIFVersion' => 'Version GIF',
   'GPSAltitude' => 'Altitude',
   'GPSAltitudeRef' => {
      Description => 'Référence d\'altitude',
      PrintConv => {
        'Above Sea Level' => 'Au-dessus du niveau de la mer',
        'Below Sea Level' => 'En-dessous du niveau de la mer',
      },
    },
   'GPSAreaInformation' => 'Nom de la zone GPS',
   'GPSDOP' => 'Précision de mesure',
   'GPSDateStamp' => 'Date GPS',
   'GPSDateTime' => 'Heure GPS (horloge atomique)',
   'GPSDestBearing' => 'Orientation de la destination',
   'GPSDestBearingRef' => {
      Description => 'Référence de l\'orientation de la destination',
      PrintConv => {
        'Magnetic North' => 'Nord magnétique',
        'True North' => 'Direction vraie',
      },
    },
   'GPSDestDistance' => 'Distance à la destination',
   'GPSDestDistanceRef' => {
      Description => 'Référence de la distance à la destination',
      PrintConv => {
        'Kilometers' => 'Kilomètres',
        'Nautical Miles' => 'Noeuds',
      },
    },
   'GPSDestLatitude' => 'Latitude de destination',
   'GPSDestLatitudeRef' => {
      Description => 'Référence de la latitude de destination',
      PrintConv => {
        'North' => 'Latitude nord',
        'South' => 'Latitude sud',
      },
    },
   'GPSDestLongitude' => 'Longitude de destination',
   'GPSDestLongitudeRef' => {
      Description => 'Référence de la longitude de destination',
      PrintConv => {
        'East' => 'Longitude est',
        'West' => 'Longitude ouest',
      },
    },
   'GPSDifferential' => {
      Description => 'Correction différentielle GPS',
      PrintConv => {
        'Differential Corrected' => 'Correction différentielle appliquée',
        'No Correction' => 'Mesure sans correction différentielle',
      },
    },
   'GPSImgDirection' => 'Direction de l\'image',
   'GPSImgDirectionRef' => {
      Description => 'Référence pour la direction l\'image',
      PrintConv => {
        'Magnetic North' => 'Direction magnétique',
        'True North' => 'Direction vraie',
      },
    },
   'GPSLatitude' => 'Latitude',
   'GPSLatitudeRef' => {
      Description => 'Latitude nord ou sud',
      PrintConv => {
        'North' => 'Latitude nord',
        'South' => 'Latitude sud',
      },
    },
   'GPSLongitude' => 'Longitude',
   'GPSLongitudeRef' => {
      Description => 'Longitude est ou ouest',
      PrintConv => {
        'East' => 'Longitude est',
        'West' => 'Longitude ouest',
      },
    },
   'GPSMapDatum' => 'Données de surveillance géodésique utilisées',
   'GPSMeasureMode' => {
      Description => 'Mode de mesure GPS',
      PrintConv => {
        '2-D' => 'Mesure à deux dimensions',
        '2-Dimensional' => 'Mesure à deux dimensions',
        '2-Dimensional Measurement' => 'Mesure à deux dimensions',
        '3-D' => 'Mesure à trois dimensions',
        '3-Dimensional' => 'Mesure à trois dimensions',
        '3-Dimensional Measurement' => 'Mesure à trois dimensions',
      },
    },
   'GPSPosition' => 'Position GPS',
   'GPSProcessingMethod' => 'Nom de la méthode de traitement GPS',
   'GPSSatellites' => 'Satellites GPS utilisés pour la mesure',
   'GPSSpeed' => 'Vitesse du récepteur GPS',
   'GPSSpeedRef' => {
      Description => 'Unité de vitesse',
      PrintConv => {
        'km/h' => 'Kilomètres par heure',
        'knots' => 'Noeuds',
        'mph' => 'Miles par heure',
      },
    },
   'GPSStatus' => {
      Description => 'État du récepteur GPS',
      PrintConv => {
        'Measurement Active' => 'Mesure active',
        'Measurement Void' => 'Mesure vide',
      },
    },
   'GPSTimeStamp' => 'Heure GPS (horloge atomique)',
   'GPSTrack' => 'Direction de déplacement',
   'GPSTrackRef' => {
      Description => 'Référence pour la direction de déplacement',
      PrintConv => {
        'Magnetic North' => 'Direction magnétique',
        'True North' => 'Direction vraie',
      },
    },
   'GPSVersionID' => 'Version de tag GPS',
   'GainControl' => {
      Description => 'Contrôle de gain',
      PrintConv => {
        'High gain down' => 'Forte atténuation',
        'High gain up' => 'Fort gain',
        'Low gain down' => 'Faible atténuation',
        'Low gain up' => 'Faible gain',
        'None' => 'Aucune',
      },
    },
   'GammaCompensatedValue' => 'Valeur de compensation gamma',
   'Gapless' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'GeoTiffAsciiParams' => 'Tag de paramètres Ascii GeoTiff',
   'GeoTiffDirectory' => 'Tag de répertoire de clé GeoTiff',
   'GeoTiffDoubleParams' => 'Tag de paramètres doubles GeoTiff',
   'GrayResponseCurve' => 'Courbe de réponse du gris',
   'GrayResponseUnit' => {
      Description => 'Unité de réponse en gris',
      PrintConv => {
        '0.0001' => 'Le nombre représente des millièmes d\'unité',
        '0.001' => 'Le nombre représente des centièmes d\'unité',
        '0.1' => 'Le nombre représente des dixièmes d\'unité',
        '1e-05' => 'Le nombre représente des dix-millièmes d\'unité',
        '1e-06' => 'Le nombre représente des cent-millièmes d\'unité',
      },
    },
   'GrayTRC' => 'Courbe de reproduction des tons gris',
   'GreenMatrixColumn' => 'Colonne de matrice verte',
   'GreenTRC' => 'Courbe de reproduction des tons verts',
   'GridDisplay' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'HCUsage' => 'Usage HC',
   'HalftoneHints' => 'Indications sur les demi-treintes',
   'Headline' => 'Titre principal',
   'HighISONoiseReduction' => {
      Description => 'Réduction du bruit en haute sensibilité ISO',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Low' => 'Bas',
        'Normal' => 'Normale',
        'Off' => 'Désactivé',
        'On' => 'Activé',
        'Strong' => 'Importante',
        'Weak' => 'Faible',
        'Weakest' => 'La plus faible',
      },
    },
   'HighlightTonePriority' => {
      Description => 'Priorité hautes lumières',
      PrintConv => {
        'Disable' => 'Désactivée',
        'Enable' => 'Activée',
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'History' => 'Récapitulatif',
   'HometownCity' => 'Ville de résidence',
   'HometownCityCode' => 'Code ville de résidence',
   'HometownDST' => {
      Description => 'Heure d\'été de résidence',
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'HostComputer' => 'Ordinateur hôte',
   'HyperfocalDistance' => 'Distanace hyperfocale',
   'ICCProfileName' => 'Nom du profil ICC',
   'ICC_Profile' => 'Profil de couleur ICC d\'entrée',
   'ID3Size' => 'Taille ID3',
   'IPTC-NAA' => 'Métadonnées IPTC-NAA',
   'IPTCBitsPerSample' => 'Nombre de bits par échantillon',
   'IPTCImageHeight' => 'Nombre de lignes',
   'IPTCImageRotation' => {
      Description => 'Rotation d\'image',
      PrintConv => {
        '0' => 'Pas de rotation',
        '180' => 'Rotation de 180 degrés',
        '270' => 'Rotation de 270 degrés',
        '90' => 'Rotation de 90 degrés',
      },
    },
   'IPTCImageWidth' => 'Pixels par ligne',
   'IPTCPictureNumber' => 'Numéro d\'image',
   'IPTCPixelHeight' => 'Taille de pixel perpendiculairement à la direction de scan',
   'IPTCPixelWidth' => 'Taille de pixel dans la direction de scan',
   'ISO' => 'Sensibilité ISO',
   'ISOExpansion' => {
      Description => 'Extension sensibilité ISO',
      PrintConv => {
        'Off' => 'Arrêt',
        'On' => 'Marche',
      },
    },
   'ISOExpansion2' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'ISOFloor' => 'Seuil ISO',
   'ISOSetting' => {
      PrintConv => {
        'Manual' => 'Manuelle',
      },
    },
   'ISOSpeedExpansion' => {
      Description => 'Extension de sensibilité ISO',
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'ISOSpeedIncrements' => {
      Description => 'Incréments de sensibilité ISO',
      PrintConv => {
        '1/3 Stop' => 'Palier 1/3',
      },
    },
   'ISOSpeedRange' => {
      Description => 'Régler l\'extension de sensibilité ISO',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activée',
      },
    },
   'IT8Header' => 'En-tête IT8',
   'Identifier' => 'Identifiant',
   'Illumination' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ImageAreaOffset' => 'Décalage de zone d\'image',
   'ImageAuthentication' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ImageColorIndicator' => 'Indicateur de couleur d\'image',
   'ImageColorValue' => 'Valeur de couleur d\'image',
   'ImageDepth' => 'Profondeur d\'image',
   'ImageDescription' => 'Description d\'image',
   'ImageDustOff' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ImageHeight' => 'Hauteur d\'image',
   'ImageHistory' => 'Historique de l\'image',
   'ImageID' => 'ID d\'image',
   'ImageLayer' => 'Couche image',
   'ImageNumber' => 'Numéro d\'image',
   'ImageOrientation' => {
      Description => 'Orientation d\'image',
      PrintConv => {
        'Landscape' => 'Paysage',
        'Square' => 'Carré',
      },
    },
   'ImageProcessing' => {
      Description => 'Traitement de l\'image',
      PrintConv => {
        'Color Filter' => 'Filtre de couleur',
        'Cropped' => 'Recadré',
        'Digital Filter' => 'Filtre numérique',
        'Frame Synthesis?' => 'Synthèse de vue ?',
        'Unprocessed' => 'Aucun',
      },
    },
   'ImageProcessingCount' => 'Compteur de traitement d\'image',
   'ImageQuality' => {
      PrintConv => {
        'Normal' => 'Normale',
      },
    },
   'ImageReview' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ImageRotated' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'ImageSize' => 'Taille de l\'Image',
   'ImageSourceData' => 'Données source d\'image',
   'ImageStabilization' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ImageTone' => {
      Description => 'Ton de l\'image',
      PrintConv => {
        'Bright' => 'Brillant',
        'Landscape' => 'Paysage',
        'Natural' => 'Naturel',
      },
    },
   'ImageType' => 'Type d\'image',
   'ImageUniqueID' => 'Identificateur unique d\'image',
   'ImageWidth' => 'Largeur d\'image',
   'Indexed' => 'Indexé',
   'InfoButtonWhenShooting' => {
      Description => 'Touche INFO au déclenchement',
      PrintConv => {
        'Displays camera settings' => 'Affiche les réglages en cours',
        'Displays shooting functions' => 'Affiche les fonctions',
      },
    },
   'InkNames' => 'Nom des encres',
   'InkSet' => 'Encrage',
   'IntellectualGenre' => 'Genre intellectuel',
   'IntensityStereo' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'InterchangeColorSpace' => {
      PrintConv => {
        'CMY (K) Device Dependent' => 'CMY(K) dépendant de l\'appareil',
        'RGB Device Dependent' => 'RVB dépendant de l\'appareil',
      },
    },
   'IntergraphMatrix' => 'Tag de matrice intergraphe',
   'Interlace' => 'Entrelacement',
   'InternalFlash' => {
      PrintConv => {
        'Fired' => 'Flash déclenché',
        'Manual' => 'Manuelle',
        'No' => 'Flash non déclenché',
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'InternalFlashMode' => {
      Description => 'Segment de mesure flash esclave 2',
      PrintConv => {
        'Off, (Unknown 0xf4)' => 'Hors service (inconnue 0xF4)',
        'Off, Auto' => 'Hors service, auto',
        'Off, Auto, Red-eye reduction' => 'Hors service, auto, réduction yeux rouges',
        'Off, Normal' => 'Hors service, normal',
        'Off, Red-eye reduction' => 'Hors service, réduction yeux rouges',
        'Off, Slow-sync' => 'Hors service, synchro lente',
        'Off, Slow-sync, Red-eye reduction' => 'Hors service, synchro lente, réduction yeux rouges',
        'Off, Trailing-curtain Sync' => 'Hors service, synchro 2e rideau',
        'Off, Wireless (Control)' => 'Hors service, sans cordon (contrôleur)',
        'Off, Wireless (Master)' => 'Hors service, sans cordon (maître)',
        'On' => 'Activé',
        'On, Auto' => 'En service, auto',
        'On, Auto, Red-eye reduction' => 'En service, auto, réduction yeux rouges',
        'On, Red-eye reduction' => 'En service, réduction yeux rouges',
        'On, Slow-sync' => 'En service, synchro lente',
        'On, Slow-sync, Red-eye reduction' => 'En service, synchro lente, réduction yeux rouges',
        'On, Trailing-curtain Sync' => 'En service, synchro 2e rideau',
        'On, Wireless (Control)' => 'En service, sans cordon (contrôleur)',
        'On, Wireless (Master)' => 'En service, sans cordon (maître)',
        'n/a - Off-Auto-Aperture' => 'N/c - auto-diaph hors service',
      },
    },
   'InternalFlashStrength' => 'Segment de mesure flash esclave 4',
   'InternalSerialNumber' => 'Numéro de série interne',
   'InteropIndex' => {
      Description => 'Identification d\'interopérabilité',
      PrintConv => {
        'R03 - DCF option file (Adobe RGB)' => 'R03: fichier d\'option DCF (Adobe RGB)',
        'R98 - DCF basic file (sRGB)' => 'R98: fichier de base DCF (sRGB)',
        'THM - DCF thumbnail file' => 'THM: fichier de vignette DCF',
      },
    },
   'InteropVersion' => 'Version d\'interopérabilité',
   'IptcLastEdited' => 'Derniere edition IPTC',
   'JFIFVersion' => 'Version JFIF',
   'JPEGACTables' => 'Tableaux AC JPEG',
   'JPEGDCTables' => 'Tableaux DC JPEG',
   'JPEGLosslessPredictors' => 'Prédicteurs JPEG sans perte',
   'JPEGPointTransforms' => 'Transformations de point JPEG',
   'JPEGProc' => 'Proc JPEG',
   'JPEGQTables' => 'Tableaux Q JPEG',
   'JPEGRestartInterval' => 'Intervalle de redémarrage JPEG',
   'JPEGTables' => 'Tableaux JPEG',
   'JobID' => 'ID de la tâche',
   'JpgRecordedPixels' => {
      Description => 'Pixels enregistrés JPEG',
      PrintConv => {
        '10 MP' => '10 Mpx',
        '2 MP' => '2 Mpx',
        '6 MP' => '6 Mpx',
      },
    },
   'Keywords' => 'Mots-clés',
   'LC1' => 'Données d\'objectif',
   'LC10' => 'Données mv\' nv\'',
   'LC11' => 'Données AVC 1/EXP',
   'LC12' => 'Données mv1 Avminsif',
   'LC14' => 'Données UNT_12 UNT_6',
   'LC15' => 'Données d\'adaptation de flash incorporé',
   'LC2' => 'Code de distance',
   'LC3' => 'Valeur K',
   'LC4' => 'Données de correction d\'aberration à courte distance',
   'LC5' => 'Données de correction d\'aberration chromatique',
   'LC6' => 'Données d\'aberration d\'ouverture',
   'LC7' => 'Données de condition minimale de déclenchement AF',
   'LCDDisplayAtPowerOn' => {
      Description => 'Etat LCD lors de l\'allumage',
      PrintConv => {
        'Display' => 'Allumé',
        'Retain power off status' => 'Etat précédent',
      },
    },
   'LCDDisplayReturnToShoot' => {
      Description => 'Affich. LCD -> Prise de vues',
      PrintConv => {
        'Also with * etc.' => 'Aussi par * etc.',
        'With Shutter Button only' => 'Par déclencheur uniq.',
      },
    },
   'LCDIllumination' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'LCDIlluminationDuringBulb' => {
      Description => 'Éclairage LCD pendant pose longue',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'LCDPanels' => {
      Description => 'Ecran LCD supérieur/arrière',
      PrintConv => {
        'ISO/File no.' => 'ISO/No. fichier',
        'ISO/Remain. shots' => 'ISO/Vues restantes',
        'Remain. shots/File no.' => 'Vues restantes/No. fichier',
        'Shots in folder/Remain. shots' => 'Vues dans dossier/Vues restantes',
      },
    },
   'LCHEditor' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'Language' => 'Langage',
   'LanguageIdentifier' => 'Identificateur de langue',
   'LensAFStopButton' => {
      Description => 'Fonct. touche AF objectif',
      PrintConv => {
        'AE lock' => 'Verrouillage AE',
        'AE lock while metering' => 'Verr. AE posemètre actif',
        'AF Stop' => 'Arrêt AF',
        'AF mode: ONE SHOT <-> AI SERVO' => 'Mode AF: ONE SHOT <-> AI SERVO',
        'AF point: M -> Auto / Auto -> Ctr.' => 'Colli: M -> Auto / Auto -> Ctr.',
        'AF point: M->Auto/Auto->ctr' => 'Collim.AF: M->Auto/Auto->ctr',
        'AF start' => 'Activation AF',
        'AF stop' => 'Arrêt AF',
        'IS start' => 'Activation stab. image',
        'Switch to registered AF point' => 'Activer le collimateur autofocus enregistré',
      },
    },
   'LensDriveNoAF' => {
      Description => 'Pilot. obj. si AF impossible',
      PrintConv => {
        'Focus search off' => 'Pas de recherche du point',
        'Focus search on' => 'Recherche du point',
      },
    },
   'LensFStops' => 'Nombre de diaphs de l\'objectif',
   'LensID' => 'ID Lens',
   'LensInfo' => 'Infos lens',
   'LensKind' => 'Sorte d\'objectif / version (LC0)',
   'LensType' => 'Sorte d\'objectif',
   'LicenseType' => {
      PrintConv => {
        'Unknown' => 'Inconnu',
      },
    },
   'LightReading' => 'Lecture de la lumière',
   'LightSource' => {
      Description => 'Source de lumière',
      PrintConv => {
        'Cloudy' => 'Temps nuageux',
        'Cool White Fluorescent' => 'Fluorescente type soft',
        'Day White Fluorescent' => 'Fluorescente type blanc',
        'Daylight' => 'Lumière du jour',
        'Daylight Fluorescent' => 'Fluorescente type jour',
        'Fine Weather' => 'Beau temps',
        'Fluorescent' => 'Fluorescente',
        'ISO Studio Tungsten' => 'Tungstène studio ISO',
        'Other' => 'Autre source de lumière',
        'Shade' => 'Ombre',
        'Standard Light A' => 'Lumière standard A',
        'Standard Light B' => 'Lumière standard B',
        'Standard Light C' => 'Lumière standard C',
        'Tungsten' => 'Tungstène (lumière incandescente)',
        'Unknown' => 'Inconnue',
        'White Fluorescent' => 'Fluorescent blanc',
      },
    },
   'LightSourceSpecial' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'LightValue' => 'Luminosite',
   'LinearResponseLimit' => 'Limite de réponse linéaire',
   'LinearizationTable' => 'Table de linéarisation',
   'Lit' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'LiveViewExposureSimulation' => {
      Description => 'Simulation d\'exposition directe',
      PrintConv => {
        'Disable (LCD auto adjust)' => 'Désactivée (réglge écran auto)',
        'Enable (simulates exposure)' => 'Activée (simulation exposition)',
      },
    },
   'LiveViewShooting' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'LocalizedCameraModel' => 'Nom traduit de modèle d\'appareil',
   'Location' => 'Ligne',
   'LockMicrophoneButton' => {
      Description => 'Fonction de touche microphone',
      PrintConv => {
        'Protect (holding:sound rec.)' => 'Protéger (maintien: enregistrement sonore)',
        'Sound rec. (protect:disable)' => 'Enregistrement sonore (protéger: désactivée)',
      },
    },
   'LongExposureNoiseReduction' => {
      Description => 'Réduct. bruit longue expo.',
      PrintConv => {
        'Off' => 'Arrêt',
        'On' => 'Marche',
      },
    },
   'LookupTable' => 'Table de correspondance',
   'LoopStyle' => {
      PrintConv => {
        'Normal' => 'Normale',
      },
    },
   'LuminanceNoiseReduction' => {
      PrintConv => {
        'Low' => 'Bas',
        'Off' => 'Désactivé',
      },
    },
   'MIEVersion' => 'Version MIE',
   'MIMEType' => 'Type MIME',
   'MSStereo' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'Macro' => {
      PrintConv => {
        'Manual' => 'Manuelle',
        'Normal' => 'Normale',
        'Off' => 'Désactivé',
        'On' => 'Activé',
        'Super Macro' => 'Super macro',
      },
    },
   'MacroMode' => {
      PrintConv => {
        'Normal' => 'Normale',
        'Off' => 'Désactivé',
        'On' => 'Activé',
        'Super Macro' => 'Super macro',
      },
    },
   'MagnifiedView' => {
      Description => 'Agrandissement en lecture',
      PrintConv => {
        'Image playback only' => 'Lecture image uniquement',
        'Image review and playback' => 'Aff. inst. et lecture',
      },
    },
   'MainDialExposureComp' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'Make' => 'Fabricant',
   'MakeAndModel' => 'Fabricant et modèle',
   'MakerNoteSafety' => {
      Description => 'Sécurité de note de fabricant',
      PrintConv => {
        'Safe' => 'Sûre',
        'Unsafe' => 'Pas sûre',
      },
    },
   'ManualFlashOutput' => {
      PrintConv => {
        'Low' => 'Bas',
        'n/a' => 'Non établie',
      },
    },
   'ManualTv' => {
      Description => 'Régl. Tv/Av manuel pour exp. M',
      PrintConv => {
        'Tv=Control/Av=Main' => 'Tv=Contrôle rapide/Av=Principale',
        'Tv=Control/Av=Main w/o lens' => 'Tv=Contrôle rapide/Av=Principale sans objectif',
        'Tv=Main/Av=Control' => 'Tv=Principale/Av=Contrôle rapide',
        'Tv=Main/Av=Main w/o lens' => 'Tv=Principale/Av=Contrôle rapide sans objectif',
      },
    },
   'ManufactureDate' => 'Date de fabrication',
   'Marked' => 'Marqué',
   'MaskedAreas' => 'Zones masquées',
   'MasterDocumentID' => 'ID du document maître',
   'Matteing' => 'Matité',
   'MaxAperture' => 'Données Avmin',
   'MaxApertureValue' => 'Ouverture maximale de l\'objectif',
   'MaxAvailHeight' => 'Hauteur max Disponible',
   'MaxAvailWidth' => 'Largeur max Disponible',
   'MaxSampleValue' => 'Valeur maxi d\'échantillon',
   'MaxVal' => 'Valeur max',
   'MaximumDensityRange' => 'Etendue maximale de densité',
   'MeasurementBacking' => 'Support de mesure',
   'MeasurementFlare' => 'Flare de mesure',
   'MeasurementGeometry' => {
      Description => 'Géométrie de mesure',
      PrintConv => {
        '0/45 or 45/0' => '0/45 ou 45/0',
        '0/d or d/0' => '0/d ou d/0',
      },
    },
   'MeasurementIlluminant' => 'Illuminant de mesure',
   'MeasurementObserver' => 'Observateur de mesure',
   'MediaBlackPoint' => 'Point noir moyen',
   'MediaWhitePoint' => 'Point blanc moyen',
   'MenuButtonDisplayPosition' => {
      Description => 'Position début touche menu',
      PrintConv => {
        'Previous' => 'Précédente',
        'Previous (top if power off)' => 'Précédente (Haut si dés.)',
        'Top' => 'Haut',
      },
    },
   'MenuButtonReturn' => {
      PrintConv => {
        'Previous' => 'Précédente',
        'Top' => 'Haut',
      },
    },
   'MetadataDate' => 'Date des metadonnées',
   'MeteringMode' => {
      Description => 'Mode de mesure',
      PrintConv => {
        'Average' => 'Moyenne',
        'Center-weighted average' => 'Centrale pondérée',
        'Evaluative' => 'Évaluative',
        'Multi-segment' => 'Multizone',
        'Other' => 'Autre',
        'Partial' => 'Partielle',
        'Unknown' => 'Inconnu',
      },
    },
   'MeteringMode2' => {
      Description => 'Mode de mesure 2',
      PrintConv => {
        'Multi-segment' => 'Multizone',
      },
    },
   'MeteringMode3' => {
      Description => 'Mode de mesure (3)',
      PrintConv => {
        'Multi-segment' => 'Multizone',
      },
    },
   'MinAperture' => 'Ouverture mini',
   'MinSampleValue' => 'Valeur mini d\'échantillon',
   'MinoltaQuality' => {
      Description => 'Qualité',
      PrintConv => {
        'Normal' => 'Normale',
      },
    },
   'MirrorLockup' => {
      Description => 'Verrouillage du miroir',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activé',
        'Enable: Down with Set' => 'Activé: Retour par touche SET',
      },
    },
   'ModDate' => 'Date de modification',
   'Model' => 'Modèle d\'appareil photo',
   'Model2' => 'Modèle d\'équipement de prise de vue (2)',
   'ModelAge' => 'Age du modele',
   'ModelTiePoint' => 'Tag de lien d modèle',
   'ModelTransform' => 'Tag de transformation de modèle',
   'ModelingFlash' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ModifiedPictureStyle' => {
      PrintConv => {
        'Landscape' => 'Paysage',
        'None' => 'Aucune',
      },
    },
   'ModifiedSaturation' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'ModifiedSharpnessFreq' => {
      PrintConv => {
        'High' => 'Haut',
        'Highest' => 'Plus haut',
        'Low' => 'Doux',
        'n/a' => 'Non établie',
      },
    },
   'ModifiedToneCurve' => {
      PrintConv => {
        'Manual' => 'Manuelle',
      },
    },
   'ModifiedWhiteBalance' => {
      PrintConv => {
        'Cloudy' => 'Temps nuageux',
        'Daylight' => 'Lumière du jour',
        'Daylight Fluorescent' => 'Fluorescente type jour',
        'Fluorescent' => 'Fluorescente',
        'Shade' => 'Ombre',
        'Tungsten' => 'Tungstène (lumière incandescente)',
      },
    },
   'ModifyDate' => 'Date de modification de fichier',
   'MoireFilter' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'MonochromeFilterEffect' => {
      PrintConv => {
        'Green' => 'Vert',
        'None' => 'Aucune',
        'Red' => 'Rouge',
        'Yellow' => 'Jaune',
      },
    },
   'MonochromeLinear' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'MonochromeToningEffect' => {
      PrintConv => {
        'Blue' => 'Bleu',
        'Green' => 'Vert',
        'None' => 'Aucune',
      },
    },
   'MultiExposureAutoGain' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'MultiExposureMode' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'MultipleExposureSet' => {
      Description => 'Exposition multiple',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'Mute' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'MyColorMode' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'NDFilter' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'NEFCompression' => {
      PrintConv => {
        'Uncompressed' => 'Non compressé',
      },
    },
   'Name' => 'Nom',
   'NamedColor2' => 'Couleur nommée 2',
   'NativeDigest' => 'Sommaire natif',
   'NativeDisplayInfo' => 'Information sur l\'affichage natif',
   'NewsPhotoVersion' => 'Version d\'enregistrement news photo',
   'Nickname' => 'Surnom',
   'Noise' => 'Bruit',
   'NoiseFilter' => {
      PrintConv => {
        'Low' => 'Bas',
        'Off' => 'Désactivé',
      },
    },
   'NoiseReduction' => {
      Description => 'Réduction du bruit',
      PrintConv => {
        'Low' => 'Bas',
        'Normal' => 'Normale',
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'NoiseReductionApplied' => 'Réduction de bruit appliquée',
   'NominalMaxAperture' => 'Ouverture maxi nominal',
   'NominalMinAperture' => 'Ouverture mini nominal',
   'NumIndexEntries' => 'Nombre d\'entrées d\'index',
   'NumberofInks' => 'Nombre d\'encres',
   'OECFColumns' => 'Colonnes OECF',
   'OECFNames' => 'Noms OECF',
   'OECFRows' => 'Lignes OECF',
   'OECFValues' => 'Valeurs OECF',
   'OPIProxy' => 'Proxy OPI',
   'ObjectAttributeReference' => 'Genre intellectuel',
   'ObjectCycle' => {
      Description => 'Cycle d\'objet',
      PrintConv => {
        'Both Morning and Evening' => 'Les deux',
        'Evening' => 'Soir',
        'Morning' => 'Matin',
      },
    },
   'ObjectFileType' => {
      PrintConv => {
        'None' => 'Aucune',
        'Unknown' => 'Inconnu',
      },
    },
   'ObjectName' => 'Titre',
   'ObjectPreviewData' => 'Données de la miniature de l\'objet',
   'ObjectPreviewFileFormat' => 'Format de fichier de la miniature de l\'objet',
   'ObjectPreviewFileVersion' => 'Version de format de fichier de la miniature de l\'objet',
   'ObjectTypeReference' => 'Référence de type d\'objet',
   'OffsetSchema' => 'Schéma de décalage',
   'OldSubfileType' => 'Type du sous-fichier',
   'OneTouchWB' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'OpticalZoomOn' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'Opto-ElectricConvFactor' => 'Facteur de conversion optoélectrique',
   'Orientation' => {
      Description => 'Orientation de l\'image',
      PrintConv => {
        'Horizontal (normal)' => '0° (haut/gauche)',
        'Mirror horizontal' => '0° (haut/droit)',
        'Mirror horizontal and rotate 270 CW' => '90° sens horaire (gauche/haut)',
        'Mirror horizontal and rotate 90 CW' => '90° sens antihoraire (droit/bas)',
        'Mirror vertical' => '180° (bas/gauche)',
        'Rotate 180' => '180° (bas/droit)',
        'Rotate 270 CW' => '90° sens horaire (gauche/bas)',
        'Rotate 90 CW' => '90° sens antihoraire (droit/haut)',
      },
    },
   'OriginalRawFileData' => 'Données du fichier raw d\'origine',
   'OriginalRawFileDigest' => 'Digest du fichier raw original',
   'OriginalRawFileName' => 'Nom du fichier raw d\'origine',
   'OriginalTransmissionReference' => 'Identificateur de tâche',
   'OriginatingProgram' => 'Programme d\'origine',
   'OtherImage' => 'Autre image',
   'OutputResponse' => 'Réponse de sortie',
   'Owner' => 'Proprietaire',
   'OwnerID' => 'ID du propriétaire',
   'OwnerName' => 'Nom du propriétaire',
   'PDFVersion' => 'Version PDF',
   'PEFVersion' => 'Version PEF',
   'Padding' => 'Remplissage',
   'PageName' => 'Nom de page',
   'PageNumber' => 'Page numéro',
   'PentaxImageSize' => {
      Description => 'Taille d\'image Pentax',
      PrintConv => {
        '2304x1728 or 2592x1944' => '2304 x 1728 ou 2592 x 1944',
        '2560x1920 or 2304x1728' => '2560 x 1920 ou 2304 x 1728',
        '2816x2212 or 2816x2112' => '2816 x 2212 ou 2816 x 2112',
        '3008x2008 or 3040x2024' => '3008 x 2008 ou 3040 x 2024',
        'Full' => 'Pleine',
      },
    },
   'PentaxModelID' => 'Modèle Pentax',
   'PentaxVersion' => 'Version Pentax',
   'PersonInImage' => 'Personnage sur l\'Image',
   'PhotoEffect' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'PhotoEffects' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'PhotoEffectsType' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'PhotometricInterpretation' => {
      Description => 'Schéma de pixel',
      PrintConv => {
        'BlackIsZero' => 'Zéro pour noir',
        'Color Filter Array' => 'CFA (Matrice de filtre de couleur)',
        'Pixar LogL' => 'CIE Log2(L) (Log luminance)',
        'Pixar LogLuv' => 'CIE Log2(L)(u\',v\') (Log luminance et chrominance)',
        'RGB' => 'RVB',
        'RGB Palette' => 'Palette RVB',
        'Transparency Mask' => 'Masque de transparence',
        'WhiteIsZero' => 'Zéro pour blanc',
      },
    },
   'PictureControl' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'PictureControlActive' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'PictureFinish' => {
      PrintConv => {
        'Natural' => 'Naturel',
        'Night Scene' => 'Nocturne',
      },
    },
   'PictureMode' => {
      Description => 'Mode d\'image',
      PrintConv => {
        '1/2 EV steps' => 'Pas de 1/2 IL',
        '1/3 EV steps' => 'Pas de 1/3 IL',
        'Aperture Priority' => 'Priorité ouverture',
        'Aperture Priority, Off-Auto-Aperture' => 'Priorité ouverture (auto-diaph hors service)',
        'Aperture-priority AE' => 'Priorité ouverture',
        'Auto PICT (Landscape)' => 'Auto PICT (paysage)',
        'Auto PICT (Macro)' => 'Auto PICT (macro)',
        'Auto PICT (Portrait)' => 'Auto PICT (portrait)',
        'Auto PICT (Sport)' => 'Auto PICT (sport)',
        'Auto PICT (Standard)' => 'Auto PICT (standard)',
        'Autumn' => 'Automne',
        'Blur Reduction' => 'Réduction du flou',
        'Bulb' => 'Pose B',
        'Bulb, Off-Auto-Aperture' => 'Pose B (auto-diaph hors service)',
        'Candlelight' => 'Bougie',
        'DOF Program' => 'Programme PdC',
        'DOF Program (HyP)' => 'Programme PdC (Hyper-programme)',
        'Dark Pet' => 'Animal foncé',
        'Digital Filter' => 'Filtre numérique',
        'Fireworks' => 'Feux d\'artifice',
        'Flash X-Sync Speed AE' => 'Synchro X flash vitesse AE',
        'Food' => 'Nourriture',
        'Frame Composite' => 'Vue composite',
        'Green Mode' => 'Mode vert',
        'Half-length Portrait' => 'Portrait (buste)',
        'Hi-speed Program' => 'Programme grande vitesse',
        'Hi-speed Program (HyP)' => 'Programme grande vitesse (Hyper-programme)',
        'Kids' => 'Enfants',
        'Landscape' => 'Paysage',
        'Light Pet' => 'Animal clair',
        'MTF Program' => 'Programme FTM',
        'MTF Program (HyP)' => 'Programme FTM (Hyper-programme)',
        'Manual' => 'Manuelle',
        'Manual, Off-Auto-Aperture' => 'Manuel (auto-diaph hors service)',
        'Medium Pet' => 'Animal demi-teintes',
        'Museum' => 'Musée',
        'Natural Skin Tone' => 'Ton chair naturel',
        'Night Scene' => 'Nocturne',
        'Night Scene Portrait' => 'Portrait nocturne',
        'No Flash' => 'Sans flash',
        'Pet' => 'Animaux de compagnie',
        'Program' => 'Programme',
        'Program (HyP)' => 'Programme AE (Hyper-programme)',
        'Program AE' => 'Priorité vitesse',
        'Program Av Shift' => 'Décalage programme Av',
        'Program Tv Shift' => 'Décalage programme Tv',
        'Self Portrait' => 'Autoportrait',
        'Sensitivity Priority AE' => 'Priorité sensibilité AE',
        'Shutter & Aperture Priority AE' => 'Priorité vitesse et ouverture AE',
        'Shutter Speed Priority' => 'Priorité vitesse',
        'Shutter speed priority AE' => 'Priorité vitesse',
        'Snow' => 'Neige',
        'Soft' => 'Doux',
        'Sunset' => 'Coucher de soleil',
        'Surf & Snow' => 'Surf et neige',
        'Synchro Sound Record' => 'Enregistrement de son synchro',
        'Text' => 'Texte',
        'Underwater' => 'Sous-marine',
      },
    },
   'PictureMode2' => {
      Description => 'Mode d\'image 2',
      PrintConv => {
        'Aperture Priority' => 'Priorité ouverture',
        'Aperture Priority, Off-Auto-Aperture' => 'Priorité ouverture (auto-diaph hors service)',
        'Auto PICT' => 'Image auto',
        'Bulb' => 'Pose B',
        'Bulb, Off-Auto-Aperture' => 'Pose B (auto-diaph hors service)',
        'Flash X-Sync Speed AE' => 'Expo auto, vitesse de synchro flash X',
        'Green Mode' => 'Mode vert',
        'Manual' => 'Manuelle',
        'Manual, Off-Auto-Aperture' => 'Manuel (auto-diaph hors service)',
        'Program AE' => 'Programme AE',
        'Program Av Shift' => 'Décalage programme Av',
        'Program Tv Shift' => 'Décalage programme Tv',
        'Scene Mode' => 'Mode scène',
        'Sensitivity Priority AE' => 'Expo auto, priorité sensibilité',
        'Shutter & Aperture Priority AE' => 'Expo auto, priorité vitesse et ouverture',
        'Shutter Speed Priority' => 'Priorité vitesse',
      },
    },
   'PictureModeBWFilter' => {
      PrintConv => {
        'Green' => 'Vert',
        'Red' => 'Rouge',
        'Yellow' => 'Jaune',
        'n/a' => 'Non établie',
      },
    },
   'PictureModeTone' => {
      PrintConv => {
        'Blue' => 'Bleu',
        'Green' => 'Vert',
        'n/a' => 'Non établie',
      },
    },
   'PictureStyle' => {
      Description => 'Style d\'image',
      PrintConv => {
        'Faithful' => 'Fidèle',
        'High Saturation' => 'Saturation élevée',
        'Landscape' => 'Paysage',
        'Low Saturation' => 'Faible saturation',
        'Neutral' => 'Neutre',
        'None' => 'Aucune',
      },
    },
   'PixelIntensityRange' => 'Intervalle d\'intensité de pixel',
   'PixelScale' => 'Tag d\'échelle de pixel modèle',
   'PixelUnits' => {
      PrintConv => {
        'Unknown' => 'Inconnu',
      },
    },
   'PlanarConfiguration' => {
      Description => 'Arrangement des données image',
      PrintConv => {
        'Chunky' => 'Format « chunky » (entrelacé)',
        'Planar' => 'Format « planar »',
      },
    },
   'PostalCode' => 'Code Postal',
   'PowerSource' => {
      Description => 'Source d\'alimentation',
      PrintConv => {
        'Body Battery' => 'Accu boîtier',
        'External Power Supply' => 'Alimentation externe',
        'Grip Battery' => 'Accu poignée',
      },
    },
   'Predictor' => {
      Description => 'Prédicteur',
      PrintConv => {
        'Horizontal differencing' => 'Différentiation horizontale',
        'None' => 'Aucun schéma de prédicteur utilisé avant l\'encodage',
      },
    },
   'Preview0' => 'Aperçu 0',
   'Preview1' => 'Aperçu 1',
   'Preview2' => 'Aperçu 2',
   'PreviewApplicationName' => 'Nom de l\'application d\'aperçu',
   'PreviewApplicationVersion' => 'Version de l\'application d\'aperçu',
   'PreviewColorSpace' => {
      Description => 'Espace de couleur de l\'aperçu',
      PrintConv => {
        'Unknown' => 'Inconnu',
      },
    },
   'PreviewDateTime' => 'Horodatage d\'aperçu',
   'PreviewImage' => 'Aperçu',
   'PreviewImageBorders' => 'Limites d\'image miniature',
   'PreviewImageLength' => 'Longueur d\'image miniature',
   'PreviewImageSize' => 'Taille d\'image miniature',
   'PreviewImageStart' => 'Début d\'image miniature',
   'PreviewImageValid' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'PreviewQuality' => {
      PrintConv => {
        'Normal' => 'Normale',
      },
    },
   'PreviewSettingsDigest' => 'Digest des réglages d\'aperçu',
   'PreviewSettingsName' => 'Nom des réglages d\'aperçu',
   'PrimaryChromaticities' => 'Chromaticité des couleurs primaires',
   'PrimaryPlatform' => 'Plateforme primaire',
   'ProcessingSoftware' => 'Logiciel de traitement',
   'Producer' => 'Producteur',
   'ProductID' => 'ID de produit',
   'ProductionCode' => 'L\'appareil est passé en SAV',
   'ProfileCMMType' => 'Type de profil CMM',
   'ProfileCalibrationSig' => 'Signature de calibration de profil',
   'ProfileClass' => {
      Description => 'Classe de profil',
      PrintConv => {
        'Abstract Profile' => 'Profil de résumé',
        'ColorSpace Conversion Profile' => 'Profil de conversion d\'espace de couleur',
        'DeviceLink Profile' => 'Profil de liaison',
        'Display Device Profile' => 'Profil d\'appareil d\'affichage',
        'Input Device Profile' => 'Profil d\'appareil d\'entrée',
        'NamedColor Profile' => 'Profil de couleur nommée',
        'Nikon Input Device Profile (NON-STANDARD!)' => 'Profil Nikon ("nkpf")',
        'Output Device Profile' => 'Profil d\'appareil de sortie',
      },
    },
   'ProfileConnectionSpace' => 'Espace de connexion de profil',
   'ProfileCopyright' => 'Copyright du profil',
   'ProfileCreator' => 'Créateur du profil',
   'ProfileDateTime' => 'Horodatage du profil',
   'ProfileDescription' => 'Description du profil',
   'ProfileDescriptionML' => 'Description de profil ML',
   'ProfileEmbedPolicy' => {
      Description => 'Règles d\'usage du profil incluses',
      PrintConv => {
        'Allow Copying' => 'Permet la copie',
        'Embed if Used' => 'Inclus si utilisé',
        'Never Embed' => 'Jamais inclus',
        'No Restrictions' => 'Pas de restriction',
      },
    },
   'ProfileFileSignature' => 'Signature de fichier de profil',
   'ProfileHueSatMapData1' => 'Données de profil teinte sat. 1',
   'ProfileHueSatMapData2' => 'Données de profil teinte sat. 2',
   'ProfileHueSatMapDims' => 'Divisions de teinte',
   'ProfileID' => 'ID du profil',
   'ProfileLookTableData' => 'Données de table de correspondance de profil',
   'ProfileLookTableDims' => 'Divisions de teinte',
   'ProfileName' => 'Nom du profil',
   'ProfileSequenceDesc' => 'Description de séquence du profil',
   'ProfileToneCurve' => 'Courbe de ton du profil',
   'ProfileVersion' => 'Version de profil',
   'ProgramLine' => {
      Description => 'Ligne de programme',
      PrintConv => {
        'Depth' => 'Priorité profondeur de champ',
        'Hi Speed' => 'Priorité grande vitesse',
        'MTF' => 'Priorité FTM',
        'Normal' => 'Normale',
      },
    },
   'ProgramMode' => {
      PrintConv => {
        'None' => 'Aucune',
        'Sunset' => 'Coucher de soleil',
        'Text' => 'Texte',
      },
    },
   'ProgramVersion' => 'Version du programme',
   'Protect' => 'Protéger',
   'Province-State' => 'Région / Département',
   'Publisher' => 'Editeur',
   'Quality' => {
      Description => 'Qualité',
      PrintConv => {
        'Best' => 'La meilleure',
        'Better' => 'Meilleure',
        'Good' => 'Bonne',
        'Low' => 'Bas',
        'Normal' => 'Normale',
      },
    },
   'QualityMode' => {
      PrintConv => {
        'Normal' => 'Normale',
      },
    },
   'QuantizationMethod' => {
      Description => 'Méthode de quantification',
      PrintConv => {
        'Color Space Specific' => 'Spécifique à l\'espace de couleur',
        'Compression Method Specific' => 'Spécifique à la méthode de compression',
        'Gamma Compensated' => 'Compensée gamma',
        'IPTC Ref B' => 'IPTC réf "B"',
        'Linear Density' => 'Densité linéaire',
        'Linear Dot Percent' => 'Pourcentage de point linéaire',
        'Linear Reflectance/Transmittance' => 'Réflectance/transmittance linéaire',
      },
    },
   'QuickControlDialInMeter' => {
      Description => 'Molette de contrôle rapide en mesure',
      PrintConv => {
        'AF point selection' => 'Sélection collimateur AF',
        'Exposure comp/Aperture' => 'Correction exposition/ouverture',
        'ISO speed' => 'Sensibilité ISO',
      },
    },
   'QuickShot' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'RAFVersion' => 'Version RAF',
   'RasterPadding' => 'Remplissage raster',
   'RasterizedCaption' => 'Légende rastérisée',
   'Rating' => 'Évaluation',
   'RatingPercent' => 'Rapport en pourcentage',
   'RawAndJpgRecording' => {
      Description => 'Enregistrement RAW et JPEG',
      PrintConv => {
        'JPEG (Best)' => 'JPEG (le meilleur)',
        'JPEG (Better)' => 'JPEG (meilleur)',
        'JPEG (Good)' => 'JPEG (bon)',
        'RAW (DNG, Best)' => 'RAW (DNG, le meilleur)',
        'RAW (DNG, Better)' => 'RAW (DNG, meilleur)',
        'RAW (DNG, Good)' => 'RAW (DNG, bon)',
        'RAW (PEF, Best)' => 'RAW (PEF, le meilleur)',
        'RAW (PEF, Better)' => 'RAW (PEF, meilleur)',
        'RAW (PEF, Good)' => 'RAW (PEF, bon)',
        'RAW+JPEG (DNG, Best)' => 'RAW+JPEG (DNG, le meilleur)',
        'RAW+JPEG (DNG, Better)' => 'RAW+JPEG (DNG, meilleur)',
        'RAW+JPEG (DNG, Good)' => 'RAW+JPEG (DNG, bon)',
        'RAW+JPEG (PEF, Best)' => 'RAW+JPEG (PEF, le meilleur)',
        'RAW+JPEG (PEF, Better)' => 'RAW+JPEG (PEF, meilleur)',
        'RAW+JPEG (PEF, Good)' => 'RAW+JPEG (PEF, bon)',
        'RAW+Large/Fine' => 'RAW+grande/fine',
        'RAW+Large/Normal' => 'RAW+grande/normale',
        'RAW+Medium/Fine' => 'RAW+moyenne/fine',
        'RAW+Medium/Normal' => 'RAW+moyenne/normale',
        'RAW+Small/Fine' => 'RAW+petite/fine',
        'RAW+Small/Normal' => 'RAW+petite/normale',
      },
    },
   'RawDataUniqueID' => 'ID unique de données brutes',
   'RawDevAutoGradation' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'RawDevPMPictureTone' => {
      PrintConv => {
        'Blue' => 'Bleu',
        'Green' => 'Vert',
      },
    },
   'RawDevPM_BWFilter' => {
      PrintConv => {
        'Green' => 'Vert',
        'Red' => 'Rouge',
        'Yellow' => 'Jaune',
      },
    },
   'RawDevPictureMode' => {
      PrintConv => {
        'Natural' => 'Naturel',
      },
    },
   'RawDevWhiteBalance' => {
      PrintConv => {
        'Color Temperature' => 'Température de couleur',
      },
    },
   'RawImageDigest' => 'Digest d\'image brute',
   'RawImageSize' => 'Taille d\'image RAW',
   'RawJpgQuality' => {
      PrintConv => {
        'Normal' => 'Normale',
      },
    },
   'RawLinear' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'RecordMode' => {
      PrintConv => {
        'Aperture Priority' => 'Priorité ouverture',
        'Manual' => 'Manuelle',
        'Shutter Priority' => 'Priorité vitesse',
      },
    },
   'RecordingMode' => {
      PrintConv => {
        'Landscape' => 'Paysage',
        'Manual' => 'Manuelle',
        'Night Scene' => 'Nocturne',
      },
    },
   'RedBalance' => 'Balance rouge',
   'RedEyeCorrection' => {
      PrintConv => {
        'Automatic' => 'Auto',
        'Off' => 'Désactivé',
      },
    },
   'RedEyeReduction' => {
      Description => 'Réduction yeux rouges',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'RedMatrixColumn' => 'Colonne de matrice rouge',
   'RedTRC' => 'Courbe de reproduction des tons rouges',
   'ReductionMatrix1' => 'Matrice de réduction 1',
   'ReductionMatrix2' => 'Matrice de réduction 2',
   'ReferenceBlackWhite' => 'Paire de valeurs de référence noir et blanc',
   'ReferenceDate' => 'Date de référence',
   'ReferenceNumber' => 'Numéro de référence',
   'ReferenceService' => 'Service de référence',
   'RelatedImageFileFormat' => 'Format de fichier image apparenté',
   'RelatedImageHeight' => 'Hauteur d\'image apparentée',
   'RelatedImageWidth' => 'Largeur d\'image apparentée',
   'RelatedSoundFile' => 'Fichier audio apparenté',
   'ReleaseButtonToUseDial' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'ReleaseDate' => 'Date de version',
   'ReleaseTime' => 'Heure de version',
   'RenderingIntent' => {
      Description => 'Intention de rendu',
      PrintConv => {
        'ICC-Absolute Colorimetric' => 'Colorimétrique absolu',
        'Media-Relative Colorimetric' => 'Colorimétrique relatif',
        'Perceptual' => 'Perceptif',
      },
    },
   'ResampleParamsQuality' => {
      PrintConv => {
        'Low' => 'Bas',
      },
    },
   'Resaved' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'Resolution' => 'Résolution d\'image',
   'ResolutionUnit' => {
      Description => 'Unité de résolution en X et Y',
      PrintConv => {
        'None' => 'Aucune',
        'inches' => 'Pouce',
      },
    },
   'RetouchHistory' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'Rights' => 'Droits',
   'RowInterleaveFactor' => 'Facteur d\'entrelacement des lignes',
   'RowsPerStrip' => 'Nombre de rangées par bande',
   'SMaxSampleValue' => 'Valeur maxi d\'échantillon S',
   'SMinSampleValue' => 'Valeur mini d\'échantillon S',
   'SPIFFVersion' => 'Version SPIFF',
   'SRAWQuality' => {
      PrintConv => {
        'n/a' => 'Non établie',
      },
    },
   'SRActive' => {
      Description => 'Réduction de bougé active',
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'SRFocalLength' => 'Focale de réduction de bougé',
   'SRHalfPressTime' => 'Temps entre mesure et déclenchement',
   'SRResult' => {
      Description => 'Stabilisation',
      PrintConv => {
        'Not stabilized' => 'Non stabilisé',
      },
    },
   'SVGVersion' => 'Version SVG',
   'SafetyShift' => {
      Description => 'Décalage de sécurité',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable (ISO speed)' => 'Activé (sensibilité ISO)',
        'Enable (Tv/Av)' => 'Activé (Tv/Av)',
      },
    },
   'SafetyShiftInAvOrTv' => {
      Description => 'Décalage de sécurité Av ou Tv',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activé',
      },
    },
   'SampleFormat' => {
      Description => 'Format d\'échantillon',
      PrintConv => {
        'Complex integer' => 'Entier complexe',
        'IEEE floating point' => 'Réel à virgule flottante',
        'Two\'s complement signed integer' => 'Entier signé',
        'Undefined' => 'Non défini',
        'Unsigned integer' => 'Entier non signé',
      },
    },
   'SampleStructure' => {
      Description => 'Structure d\'échantillonnage',
      PrintConv => {
        'CompressionDependent' => 'Définie dans le processus de compression',
        'Orthogonal4-2-2Sampling' => 'Orthogonale, avec les fréquences d\'échantillonnage dans le rapport 4:2:2:(4)',
        'OrthogonalConstangSampling' => 'Orthogonale, avec les mêmes fréquences d\'échantillonnage relatives sur chaque composante',
      },
    },
   'SamplesPerPixel' => 'Nombre de composantes',
   'Saturation' => {
      PrintConv => {
        'High' => 'Forte',
        'Low' => 'Faible',
        'Med High' => 'Assez forte',
        'Med Low' => 'Assez faible',
        'None' => 'Non établie',
        'Normal' => 'Normale',
        'Very High' => 'Très forte',
        'Very Low' => 'Très faible',
      },
    },
   'ScanImageEnhancer' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ScanningDirection' => {
      Description => 'Direction de scannage',
      PrintConv => {
        'Bottom-Top, L-R' => 'De bas en haut, de gauche à droite',
        'Bottom-Top, R-L' => 'De bas en haut, de droite à gauche',
        'L-R, Bottom-Top' => 'De gauche à droite, de bas en haut',
        'L-R, Top-Bottom' => 'De gauche à droite, de haut en bas',
        'R-L, Bottom-Top' => 'De droite à gauche, de bas en haut',
        'R-L, Top-Bottom' => 'De droite à gauche, de haut en bas',
        'Top-Bottom, L-R' => 'De haut en bas, de gauche à droite',
        'Top-Bottom, R-L' => 'De haut en bas, de droite à gauche',
      },
    },
   'SceneCaptureType' => {
      Description => 'Type de capture de scène',
      PrintConv => {
        'Landscape' => 'Paysage',
        'Night' => 'Scène de nuit',
      },
    },
   'SceneMode' => {
      PrintConv => {
        'Aperture Priority' => 'Priorité ouverture',
        'Candlelight' => 'Bougie',
        'Landscape' => 'Paysage',
        'Manual' => 'Manuelle',
        'Night Scene' => 'Nocturne',
        'Normal' => 'Normale',
        'Off' => 'Désactivé',
        'Shutter Priority' => 'Priorité vitesse',
        'Snow' => 'Neige',
        'Sunset' => 'Coucher de soleil',
        'Super Macro' => 'Super macro',
        'Text' => 'Texte',
      },
    },
   'SceneModeUsed' => {
      PrintConv => {
        'Aperture Priority' => 'Priorité ouverture',
        'Candlelight' => 'Bougie',
        'Landscape' => 'Paysage',
        'Manual' => 'Manuelle',
        'Shutter Priority' => 'Priorité vitesse',
        'Snow' => 'Neige',
        'Sunset' => 'Coucher de soleil',
        'Text' => 'Texte',
      },
    },
   'SceneSelect' => {
      PrintConv => {
        'Night' => 'Scène de nuit',
        'Off' => 'Désactivé',
      },
    },
   'SceneType' => {
      Description => 'Type de scène',
      PrintConv => {
        'Directly photographed' => 'Image photographiée directement',
      },
    },
   'SecurityClassification' => {
      Description => 'Classement de sécurité',
      PrintConv => {
        'Confidential' => 'Confidentiel',
        'Restricted' => 'Restreint',
        'Top Secret' => 'Top secret',
        'Unclassified' => 'Non classé',
      },
    },
   'SelectableAFPoint' => {
      Description => 'Collimateurs AF sélectionnables',
      PrintConv => {
        '19 points' => '19 collimateurs',
        'Inner 9 points' => '9 collimateurs centraux',
        'Outer 9 points' => '9 collimateurs périphériques',
      },
    },
   'SelfTimer' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'SelfTimer2' => 'Retardateur (2)',
   'SelfTimerMode' => 'Mode auto-timer',
   'SensingMethod' => {
      Description => 'Méthode de capture',
      PrintConv => {
        'Color sequential area' => 'Capteur couleur séquentiel',
        'Color sequential linear' => 'Capteur couleur séquentiel linéaire',
        'Monochrome area' => 'Capteur monochrome',
        'Monochrome linear' => 'Capteur linéaire monochrome',
        'Not defined' => 'Non définie',
        'One-chip color area' => 'Capteur monochip couleur',
        'Three-chip color area' => 'Capteur trois chips couleur',
        'Trilinear' => 'Capteur trilinéaire',
        'Two-chip color area' => 'Capteur deux chips couleur',
      },
    },
   'SensitivityAdjust' => 'Réglage de sensibilité',
   'SensitivitySteps' => {
      Description => 'Pas de sensibilité',
      PrintConv => {
        '1 EV Steps' => 'Pas de 1 IL',
        'As EV Steps' => 'Comme pas IL',
      },
    },
   'SensorCleaning' => {
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activé',
      },
    },
   'SequentialShot' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'SerialNumber' => 'Numéro de série',
   'ServiceIdentifier' => 'Identificateur de service',
   'SetButtonCrossKeysFunc' => {
      Description => 'Réglage touche SET/joypad',
      PrintConv => {
        'Cross keys: AF point select' => 'Joypad:Sélec. collim. AF',
        'Normal' => 'Normale',
        'Set: Flash Exposure Comp' => 'SET:Cor expo flash',
        'Set: Parameter' => 'SET:Changer de paramètres',
        'Set: Picture Style' => 'SET:Style d’image',
        'Set: Playback' => 'SET:Lecture',
        'Set: Quality' => 'SET:Qualité',
      },
    },
   'SetButtonWhenShooting' => {
      Description => 'Touche SET au déclenchement',
      PrintConv => {
        'Change parameters' => 'Changer de paramètres',
        'Default (no function)' => 'Normal (désactivée)',
        'Disabled' => 'Désactivée',
        'Flash exposure compensation' => 'Correction expo flash',
        'ISO speed' => 'Sensibilité ISO',
        'Image playback' => 'Lecture de l\'image',
        'Image quality' => 'Changer de qualité',
        'Image size' => 'Taille d\'image',
        'LCD monitor On/Off' => 'Écran LCD On/Off',
        'Menu display' => 'Affichage du menu',
        'Normal (disabled)' => 'Normal (désactivée)',
        'Picture style' => 'Style d\'image',
        'Quick control screen' => 'Écran de contrôle rapide',
        'Record func. + media/folder' => 'Fonction enregistrement + média/dossier',
        'Record movie (Live View)' => 'Enr. vidéo (visée écran)',
        'White balance' => 'Balance des blancs',
      },
    },
   'SetFunctionWhenShooting' => {
      Description => 'Touche SET au déclenchement',
      PrintConv => {
        'Change Parameters' => 'Changer de paramètres',
        'Change Picture Style' => 'Style d\'image',
        'Change quality' => 'Changer de qualité',
        'Default (no function)' => 'Normal (désactivée)',
        'Image replay' => 'Lecture de l\'image',
        'Menu display' => 'Affichage du menu',
      },
    },
   'ShadingCompensation' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ShadingCompensation2' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ShadowScale' => 'Echelle d\'ombre',
   'ShakeReduction' => {
      Description => 'Réduction du bougé (réglage)',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'Sharpness' => {
      Description => 'Accentuation',
      PrintConv => {
        'Hard' => 'Dure',
        'Med Hard' => 'Assez dure',
        'Med Soft' => 'Assez douce',
        'Normal' => 'Normale',
        'Soft' => 'Douce',
        'Very Hard' => 'Très dure',
        'Very Soft' => 'Très douce',
        'n/a' => 'Non établie',
      },
    },
   'SharpnessFrequency' => {
      PrintConv => {
        'High' => 'Haut',
        'Highest' => 'Plus haut',
        'Low' => 'Doux',
        'n/a' => 'Non établie',
      },
    },
   'ShootingMode' => {
      PrintConv => {
        'Aperture Priority' => 'Priorité ouverture',
        'Candlelight' => 'Bougie',
        'Manual' => 'Manuelle',
        'Normal' => 'Normale',
        'Shutter Priority' => 'Priorité vitesse',
        'Snow' => 'Neige',
        'Sunset' => 'Coucher de soleil',
      },
    },
   'ShortDocumentID' => 'ID court de document',
   'ShortReleaseTimeLag' => {
      Description => 'Intertie au déclenchement réduite',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activé',
      },
    },
   'Shutter-AELock' => {
      Description => 'Déclencheur/Touche verr. AE',
      PrintConv => {
        'AE lock/AF' => 'Verrouillage AE/autofocus',
        'AE/AF, No AE lock' => 'AE/AF, pas de verrou. AE',
        'AF/AE lock' => 'Autofocus/verrouillage AE',
        'AF/AF lock' => 'Autofocus/verrouillage AF',
        'AF/AF lock, No AE lock' => 'AF/verr.AF, pas de verr.AE',
      },
    },
   'ShutterAELButton' => {
      Description => 'Déclencheur/Touche verr. AE',
      PrintConv => {
        'AE lock/AF' => 'Verrouillage AE/Autofocus',
        'AE/AF, No AE lock' => 'AE/AF, pad de verrou. AE',
        'AF/AE lock stop' => 'Autofocus/Verrouillage AE',
        'AF/AF lock, No AE lock' => 'AF/ver.AF, pad de verr.AE',
      },
    },
   'ShutterButtonAFOnButton' => {
      Description => 'Déclencheur/Touche AF',
      PrintConv => {
        'AE lock/Metering + AF start' => 'Mémo expo/lct. mesure+AF',
        'Metering + AF start' => 'Mesure + lancement AF',
        'Metering + AF start / disable' => 'Lct. mesure+AF/désactivée',
        'Metering + AF start/AF stop' => 'Mesure + lancement/arrêt AF',
        'Metering start/Meter + AF start' => 'Lct. mesure/lct. mesure+AF',
      },
    },
   'ShutterCount' => 'Comptage des déclenchements',
   'ShutterCurtainSync' => {
      Description => 'Synchronisation du rideau',
      PrintConv => {
        '1st-curtain sync' => 'Synchronisation premier rideau',
        '2nd-curtain sync' => 'Synchronisation deuxième rideau',
      },
    },
   'ShutterMode' => {
      PrintConv => {
        'Aperture Priority' => 'Priorité ouverture',
      },
    },
   'ShutterReleaseButtonAE-L' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ShutterReleaseNoCFCard' => {
      Description => 'Déclench. obtur. sans carte',
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'ShutterSpeed' => 'Temps de pose',
   'ShutterSpeedRange' => {
      Description => 'Régler gamme de vitesses',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activée',
      },
    },
   'ShutterSpeedValue' => 'Vitesse d\'obturation',
   'SidecarForExtension' => 'Extension',
   'SimilarityIndex' => 'Indice de similarité',
   'SlaveFlashMeteringSegments' => 'Segments de mesure flash esclave',
   'SlideShow' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'SlowShutter' => {
      Description => 'Vitesse d\'obturation lente',
      PrintConv => {
        'Night Scene' => 'Nocturne',
        'None' => 'Aucune',
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'SlowSync' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'Software' => 'Logiciel',
   'SpatialFrequencyResponse' => 'Réponse spatiale en fréquence',
   'SpecialEffectsOpticalFilter' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'SpectralSensitivity' => 'Sensibilité spectrale',
   'SpotMeterLinkToAFPoint' => {
      Description => 'Mesure spot liée au collimateur AF',
      PrintConv => {
        'Disable (use center AF point)' => 'Désactivée (utiliser collimateur AF central)',
        'Enable (use active AF point)' => 'Activé (utiliser collimateur AF actif)',
      },
    },
   'SpotMeteringMode' => {
      PrintConv => {
        'Center' => 'Centre',
      },
    },
   'State' => 'Etat',
   'StreamType' => {
      PrintConv => {
        'Text' => 'Texte',
      },
    },
   'StripByteCounts' => 'Octets par bande compressée',
   'StripOffsets' => 'Emplacement des données image',
   'Sub-location' => 'Lieu',
   'SubSecCreateDate' => 'Date de la création des données numériques',
   'SubSecDateTimeOriginal' => 'Date de la création des données originales',
   'SubSecModifyDate' => 'Date de modification de fichier',
   'SubSecTime' => 'Fractions de seconde de DateTime',
   'SubSecTimeDigitized' => 'Fractions de seconde de DateTimeDigitized',
   'SubSecTimeOriginal' => 'Fractions de seconde de DateTimeOriginal',
   'SubTileBlockSize' => 'Taille de bloc de sous-tuile',
   'SubfileType' => 'Type du nouveau sous-fichier',
   'SubimageColor' => {
      PrintConv => {
        'RGB' => 'RVB',
      },
    },
   'Subject' => 'Sujet',
   'SubjectCode' => 'Code sujet',
   'SubjectDistance' => 'Distance du sujet',
   'SubjectDistanceRange' => {
      Description => 'Intervalle de distance du sujet',
      PrintConv => {
        'Close' => 'Vue rapprochée',
        'Distant' => 'Vue distante',
        'Unknown' => 'Inconnu',
      },
    },
   'SubjectLocation' => 'Zone du sujet',
   'SubjectProgram' => {
      PrintConv => {
        'None' => 'Aucune',
        'Sunset' => 'Coucher de soleil',
        'Text' => 'Texte',
      },
    },
   'SubjectReference' => 'Code de sujet',
   'Subsystem' => {
      PrintConv => {
        'Unknown' => 'Inconnu',
      },
    },
   'SuperMacro' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'SuperimposedDisplay' => {
      Description => 'Affichage superposé',
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'SupplementalCategories' => 'Catégorie d\'appoint',
   'SupplementalType' => {
      Description => 'Type de supplément',
      PrintConv => {
        'Main Image' => 'Non établi',
        'Rasterized Caption' => 'Titre rastérisé',
        'Reduced Resolution Image' => 'Image de résolution réduite',
      },
    },
   'SvISOSetting' => 'Réglage ISO Sv',
   'SwitchToRegisteredAFPoint' => {
      Description => 'Activer collimateur enregistré',
      PrintConv => {
        'Assist' => 'Touche d\'assistance',
        'Assist + AF' => 'Touche d\'assistance + touche AF',
        'Disable' => 'Désactivé',
        'Enable' => 'Activé',
        'Only while pressing assist' => 'Seulement en appuyant touche d\'assistance',
      },
    },
   'T4Options' => 'Bits de remplissage ajoutés',
   'T6Options' => 'Options T6',
   'TTL_DA_ADown' => 'Segment de mesure flash esclave 6',
   'TTL_DA_AUp' => 'Segment de mesure flash esclave 5',
   'TTL_DA_BDown' => 'Segment de mesure flash esclave 8',
   'TTL_DA_BUp' => 'Segment de mesure flash esclave 7',
   'Tagged' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'TargetPrinter' => 'Imprimantte cible',
   'Technology' => {
      Description => 'Technologie',
      PrintConv => {
        'Active Matrix Display' => 'Afficheur à matrice active',
        'Cathode Ray Tube Display' => 'Afficheur à tube cathodique',
        'Digital Camera' => 'Appareil photo numérique',
        'Dye Sublimation Printer' => 'Imprimante à sublimation thermique',
        'Electrophotographic Printer' => 'Imprimante électrophotographique',
        'Electrostatic Printer' => 'Imprimante électrostatique',
        'Film Scanner' => 'Scanner de film',
        'Flexography' => 'Flexographie',
        'Ink Jet Printer' => 'Imprimante à jet d\'encre',
        'Offset Lithography' => 'Lithographie offset',
        'Passive Matrix Display' => 'Afficheur à matrice passive',
        'Photo CD' => 'CD photo',
        'Photo Image Setter' => 'Cadre photo',
        'Photographic Paper Printer' => 'Imprimante à papier photo',
        'Projection Television' => 'Téléviseur à projection',
        'Reflective Scanner' => 'Scanner à réflexion',
        'Silkscreen' => 'Ecran de soie',
        'Thermal Wax Printer' => 'Imprimante thermique à cire',
        'Video Camera' => 'Caméra vidéo',
        'Video Monitor' => 'Moniteur vidéo',
      },
    },
   'Teleconverter' => {
      PrintConv => {
        'None' => 'Aucune',
      },
    },
   'Text' => 'Texte',
   'TextStamp' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'Thresholding' => 'Seuil',
   'ThumbnailHeight' => 'Hauteur de la vignette',
   'ThumbnailImage' => 'Vignette',
   'ThumbnailWidth' => 'Hauteur de la vignette',
   'TileByteCounts' => 'Nombre d\'octets d\'élément',
   'TileDepth' => 'Profondeur d\'élément',
   'TileLength' => 'Longueur d\'élément',
   'TileOffsets' => 'Décalages d\'élément',
   'TileWidth' => 'Largeur d\'élément',
   'Time' => 'Heure',
   'TimeCreated' => 'Heure de création',
   'TimeScaleParamsQuality' => {
      PrintConv => {
        'Low' => 'Bas',
      },
    },
   'TimeSent' => 'Heure d\'envoi',
   'TimeZoneOffset' => 'Offset de zone de date',
   'TimerLength' => {
      Description => 'Durée du retardateur',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activée',
      },
    },
   'Title' => 'Titre',
   'ToneCurve' => {
      Description => 'Courbe de ton',
      PrintConv => {
        'Manual' => 'Manuelle',
      },
    },
   'ToneCurveActive' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'ToneCurves' => 'Courbes de ton',
   'ToningEffect' => {
      PrintConv => {
        'Blue' => 'Bleu',
        'Green' => 'Vert',
        'None' => 'Aucune',
        'Red' => 'Rouge',
        'Yellow' => 'Jaune',
        'n/a' => 'Non établie',
      },
    },
   'ToningEffectMonochrome' => {
      PrintConv => {
        'Blue' => 'Bleu',
        'Green' => 'Vert',
        'None' => 'Aucune',
      },
    },
   'TransferFunction' => 'Fonction de transfert',
   'TransferRange' => 'Intervalle de transfert',
   'Transformation' => {
      PrintConv => {
        'Horizontal (normal)' => '0° (haut/gauche)',
        'Mirror horizontal' => '0° (haut/droit)',
        'Mirror horizontal and rotate 270 CW' => '90° sens horaire (gauche/haut)',
        'Mirror horizontal and rotate 90 CW' => '90° sens antihoraire (droit/bas)',
        'Mirror vertical' => '180° (bas/gauche)',
        'Rotate 180' => '180° (bas/droit)',
        'Rotate 270 CW' => '90° sens horaire (gauche/bas)',
        'Rotate 90 CW' => '90° sens antihoraire (droit/haut)',
      },
    },
   'TransmissionReference' => 'Référence transmission',
   'TransparencyIndicator' => 'Indicateur de transparence',
   'TrapIndicator' => 'Indicateur de piège',
   'Trapped' => {
      Description => 'Piégé',
      PrintConv => {
        'False' => 'Faux',
        'True' => 'Vrai',
        'Unknown' => 'Inconnu',
      },
    },
   'TvExposureTimeSetting' => 'Réglage de temps de pose Tv',
   'USMLensElectronicMF' => {
      Description => 'MF électronique à objectif USM',
      PrintConv => {
        'Always turned off' => 'Toujours débrayé',
        'Disable after one-shot AF' => 'Désactivée après One-Shot AF',
        'Disable in AF mode' => 'Désactivée en mode AF',
        'Enable after one-shot AF' => 'Activée après AF One-Shot',
        'Turns off after one-shot AF' => 'Débrayé aprés One-Shot AF',
        'Turns on after one-shot AF' => 'Activé aprés One-Shot AF',
      },
    },
   'Uncompressed' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'UniqueCameraModel' => 'Nom unique de modèle d\'appareil',
   'UniqueDocumentID' => 'ID unique de document',
   'UniqueObjectName' => 'Nom Unique d\'Objet',
   'Unsharp1Color' => {
      PrintConv => {
        'Blue' => 'Bleu',
        'Green' => 'Vert',
        'RGB' => 'RVB',
        'Red' => 'Rouge',
        'Yellow' => 'Jaune',
      },
    },
   'Unsharp2Color' => {
      PrintConv => {
        'Blue' => 'Bleu',
        'Green' => 'Vert',
        'RGB' => 'RVB',
        'Red' => 'Rouge',
        'Yellow' => 'Jaune',
      },
    },
   'Unsharp3Color' => {
      PrintConv => {
        'Blue' => 'Bleu',
        'Green' => 'Vert',
        'RGB' => 'RVB',
        'Red' => 'Rouge',
        'Yellow' => 'Jaune',
      },
    },
   'Unsharp4Color' => {
      PrintConv => {
        'Blue' => 'Bleu',
        'Green' => 'Vert',
        'RGB' => 'RVB',
        'Red' => 'Rouge',
        'Yellow' => 'Jaune',
      },
    },
   'UnsharpMask' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'Urgency' => {
      Description => 'Urgence',
      PrintConv => {
        '0 (reserved)' => '0 (réservé pour utilisation future)',
        '1 (most urgent)' => '1 (très urgent)',
        '5 (normal urgency)' => '5 (normalement urgent)',
        '8 (least urgent)' => '8 (moins urgent)',
        '9 (user-defined priority)' => '9 (réservé pour utilisation future)',
      },
    },
   'UsableMeteringModes' => {
      Description => 'Sélectionner modes de mesure',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activée',
      },
    },
   'UsableShootingModes' => {
      Description => 'Sélectionner modes de prise de vue',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activée',
      },
    },
   'UsageTerms' => 'Conditions d\'Utilisation',
   'UserComment' => 'Commentaire utilisateur',
   'UserDef1PictureStyle' => {
      PrintConv => {
        'Landscape' => 'Paysage',
      },
    },
   'UserDef2PictureStyle' => {
      PrintConv => {
        'Landscape' => 'Paysage',
      },
    },
   'UserDef3PictureStyle' => {
      PrintConv => {
        'Landscape' => 'Paysage',
      },
    },
   'VRDVersion' => 'Version VRD',
   'VR_0x66' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'VibrationReduction' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
        'n/a' => 'Non établie',
      },
    },
   'VideoCardGamma' => 'Gamma de la carte vidéo',
   'ViewInfoDuringExposure' => {
      Description => 'Infos viseur pendant exposition',
      PrintConv => {
        'Disable' => 'Désactivé',
        'Enable' => 'Activé',
      },
    },
   'ViewfinderWarning' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'ViewingCondDesc' => 'Description des conditions de visionnage',
   'ViewingCondIlluminant' => 'Illuminant des conditions de visionnage',
   'ViewingCondIlluminantType' => 'Type d\'illuminant des conditions de visionnage',
   'ViewingCondSurround' => 'Environnement des conditions de visionnage',
   'VignetteControl' => {
      PrintConv => {
        'High' => 'Haut',
        'Low' => 'Bas',
        'Normal' => 'Normale',
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'VoiceMemo' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'WBAdjLighting' => {
      PrintConv => {
        'Daylight' => 'Lumière du jour',
        'None' => 'Aucune',
      },
    },
   'WBBracketMode' => {
      PrintConv => {
        'Off' => 'Désactivé',
      },
    },
   'WBFineTuneActive' => {
      PrintConv => {
        'No' => 'Non',
        'Yes' => 'Oui',
      },
    },
   'WBMediaImageSizeSetting' => {
      Description => 'Réglage de balance des blancs + taille d\'image',
      PrintConv => {
        'LCD monitor' => 'Écran LCD',
        'Rear LCD panel' => 'Panneau LCD arrièr',
      },
    },
   'WBShiftAB' => 'Décalage bal. blancs ambre-bleu',
   'WBShiftGM' => 'Décalage bal. blancs vert-magenta',
   'WBShiftMG' => 'Décalage bal. blancs magenta-vert',
   'WB_GBRGLevels' => 'Niveaux BB VBRV',
   'WB_GRBGLevels' => 'Niveaux BB VRBV',
   'WB_GRGBLevels' => 'Niveaux BB VRVB',
   'WB_RBGGLevels' => 'Niveaux BB RBVV',
   'WB_RBLevels' => 'Niveaux BB RB',
   'WB_RBLevels3000K' => 'Niveaux BB RB 3000K',
   'WB_RBLevels3300K' => 'Niveaux BB RB 3300K',
   'WB_RBLevels3600K' => 'Niveaux BB RB 3600K',
   'WB_RBLevels3900K' => 'Niveaux BB RB 3800K',
   'WB_RBLevels4000K' => 'Niveaux BB RB 4000K',
   'WB_RBLevels4300K' => 'Niveaux BB RB 4300K',
   'WB_RBLevels4500K' => 'Niveaux BB RB 4500K',
   'WB_RBLevels4800K' => 'Niveaux BB RB 4800K',
   'WB_RBLevels5300K' => 'Niveaux BB RB 5300K',
   'WB_RBLevels6000K' => 'Niveaux BB RB 6000K',
   'WB_RBLevels6600K' => 'Niveaux BB RB 6600K',
   'WB_RBLevels7500K' => 'Niveaux BB RB 7500K',
   'WB_RBLevelsCloudy' => 'Niveaux BB RB nuageux',
   'WB_RBLevelsShade' => 'Niveaux BB RB ombre',
   'WB_RBLevelsTungsten' => 'Niveaux BB RB tungstène',
   'WB_RGBGLevels' => 'Niveaux BB RVBV',
   'WB_RGBLevels' => 'Niveaux BB RVB',
   'WB_RGBLevelsCloudy' => 'Niveaux BB RVB nuageux',
   'WB_RGBLevelsDaylight' => 'Niveaux BB RVB lumière jour',
   'WB_RGBLevelsFlash' => 'Niveaux BB RVB flash',
   'WB_RGBLevelsFluorescent' => 'Niveaux BB RVB fluorescent',
   'WB_RGBLevelsShade' => 'Niveaux BB RVB ombre',
   'WB_RGBLevelsTungsten' => 'Niveaux BB RVB tungstène',
   'WB_RGGBLevels' => 'Niveaux BB RVVB',
   'WB_RGGBLevelsCloudy' => 'Niveaux BB RVVB nuageux',
   'WB_RGGBLevelsDaylight' => 'Niveaux BB RVVB lumière jour',
   'WB_RGGBLevelsFlash' => 'Niveaux BB RVVB flash',
   'WB_RGGBLevelsFluorescent' => 'Niveaux BB RVVB fluorescent',
   'WB_RGGBLevelsFluorescentD' => 'Niveaux BB RVVB fluorescent',
   'WB_RGGBLevelsFluorescentN' => 'Niveaux BB RVVB fluo N',
   'WB_RGGBLevelsFluorescentW' => 'Niveaux BB RVVB fluo W',
   'WB_RGGBLevelsShade' => 'Niveaux BB RVVB ombre',
   'WB_RGGBLevelsTungsten' => 'Niveaux BB RVVB tungstène',
   'WCSProfiles' => 'Profil Windows Color System',
   'Warning' => 'Attention',
   'WebStatement' => 'Relevé Web',
   'WhiteBalance' => {
      Description => 'Balance des blancs',
      PrintConv => {
        'Black & White' => 'Monochrome',
        'Cloudy' => 'Temps nuageux',
        'Custom' => 'Personnalisée',
        'Custom 1' => 'Personnalisée 1',
        'Custom 2' => 'Personnalisée 2',
        'Custom 3' => 'Personnalisée 3',
        'Custom 4' => 'Personnalisée 4',
        'Day White Fluorescent' => 'Fluorescente type blanc',
        'Daylight' => 'Lumière du jour',
        'Daylight Fluorescent' => 'Fluorescente type jour',
        'DaylightFluorescent' => 'Fluorescente type jour',
        'DaywhiteFluorescent' => 'Fluorescent blanc jour',
        'Fluorescent' => 'Fluorescente',
        'Manual' => 'Manuelle',
        'Manual Temperature (Kelvin)' => 'Température de couleur (Kelvin)',
        'Shade' => 'Ombre',
        'Shadow' => 'Ombre',
        'Tungsten' => 'Tungstène (lumière incandescente)',
        'Unknown' => 'Inconnu',
        'User-Selected' => 'Sélectionnée par l\'utilisateur',
        'White Fluorescent' => 'Fluorescent blanc',
        'WhiteFluorescent' => 'Fluorescent blanc',
      },
    },
   'WhiteBalanceAdj' => {
      PrintConv => {
        'Cloudy' => 'Temps nuageux',
        'Daylight' => 'Lumière du jour',
        'Fluorescent' => 'Fluorescente',
        'Off' => 'Désactivé',
        'On' => 'Activé',
        'Shade' => 'Ombre',
        'Tungsten' => 'Tungstène (lumière incandescente)',
      },
    },
   'WhiteBalanceMode' => {
      Description => 'Mode de balance des blancs',
      PrintConv => {
        'Auto (Cloudy)' => 'Auto (nuageux)',
        'Auto (Daylight)' => 'Auto (lumière du jour)',
        'Auto (DaylightFluorescent)' => 'Auto (fluo lum. jour)',
        'Auto (DaywhiteFluorescent)' => 'Auto (fluo jour)',
        'Auto (Flash)' => 'Auto (flash)',
        'Auto (Shade)' => 'Auto (ombre)',
        'Auto (Tungsten)' => 'Auto (tungstène)',
        'Auto (WhiteFluorescent)' => 'Auto (fluo blanc)',
        'Unknown' => 'Inconnu',
        'User-Selected' => 'Sélectionnée par l\'utilisateur',
      },
    },
   'WhiteBalanceSet' => {
      Description => 'Réglage de balance des blancs',
      PrintConv => {
        'Cloudy' => 'Temps nuageux',
        'Daylight' => 'Lumière du jour',
        'DaylightFluorescent' => 'Fluorescente type jour',
        'DaywhiteFluorescent' => 'Fluorescent blanc jour',
        'Manual' => 'Manuelle',
        'Set Color Temperature 1' => 'Température de couleur définie 1',
        'Set Color Temperature 2' => 'Température de couleur définie 2',
        'Set Color Temperature 3' => 'Température de couleur définie 3',
        'Shade' => 'Ombre',
        'Tungsten' => 'Tungstène (lumière incandescente)',
        'WhiteFluorescent' => 'Fluorescent blanc',
      },
    },
   'WhiteLevel' => 'Niveau blanc',
   'WhitePoint' => 'Chromaticité du point blanc',
   'WideRange' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
   'WorldTimeLocation' => {
      Description => 'Position en temps mondial',
      PrintConv => {
        'Hometown' => 'Résidence',
      },
    },
   'Writer-Editor' => 'Auteur de la légende / description',
   'XClipPathUnits' => 'Unités de chemin de rognage en X',
   'XPAuthor' => 'Auteur',
   'XPComment' => 'Commentaire',
   'XPKeywords' => 'Mots clé',
   'XPSubject' => 'Sujet',
   'XPTitle' => 'Titre',
   'XPosition' => 'Position en X',
   'XResolution' => 'Résolution d\'image horizontale',
   'YCbCrCoefficients' => 'Coefficients de la matrice de transformation de l\'espace de couleurs',
   'YCbCrPositioning' => {
      Description => 'Positionnement Y et C',
      PrintConv => {
        'Centered' => 'Centré',
        'Co-sited' => 'Côte à côte',
      },
    },
   'YCbCrSubSampling' => 'Rapport de sous-échantillonnage Y à C',
   'YClipPathUnits' => 'Unités de chemin de rognage en Y',
   'YPosition' => 'Position en Y',
   'YResolution' => 'Résolution d\'image verticale',
   'Year' => 'Année',
   'ZoneMatchingOn' => {
      PrintConv => {
        'Off' => 'Désactivé',
        'On' => 'Activé',
      },
    },
);

1;  # end


__END__

=head1 NAME

Image::ExifTool::Lang::fr.pm - ExifTool French language translations

=head1 DESCRIPTION

This file is used by Image::ExifTool to generate localized tag descriptions
and values.

=head1 AUTHOR

Copyright 2003-2009, Phil Harvey (phil at owl.phy.queensu.ca)

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 ACKNOWLEDGEMENTS

Thanks to Jens Duttke, Bernard Guillotin and Jean Piquemal for providing
this translation.

=head1 SEE ALSO

L<Image::ExifTool(3pm)|Image::ExifTool>,
L<Image::ExifTool::TagInfoXML(3pm)|Image::ExifTool::TagInfoXML>

=cut
