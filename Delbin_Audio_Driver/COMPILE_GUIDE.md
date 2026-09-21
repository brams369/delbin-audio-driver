# Guide de Compilation et Installation - Delbin Audio Driver

## Analyses BIOS Realisées

### Matériel Identifié
- **Platforme:** Intel Tiger Lake (TGL)
- **Controleur HDA:** Intel HD Audio
- **ID Matériel:** PCI\VEN_8086&DEV_A0C8&SUBSYS_00000000&REV_20
- **Codecs:** Intel HD Audio, Realtek ALC5682, Conexant CX

### Configuration BIOS
- **Firmware Intel Audio:** Kaby Lake Audio + Gemini Lake Audio
- **Structure HDA:** Supporté
- **Configuration ACPI:** Tables DSDT et SSDT présentes

## Structure du Projet

```
Delbin_Audio_Driver/
├── README.md                      # Documentation
├── COMPILE_GUIDE.md              # Ce fichier
├── driver/
│   ├── delbin_audio.inf          # Fichier INF avec ID matériel réel
│   └── delbin_audio.c            # Code source template
├── build/
│   ├── build.bat                 # Script de compilation
│   └── delbin_audio.vcxproj      # Projet Visual Studio
├── scripts/
│   └── install.bat               # Script d'installation
└── .gitignore                    # Configuration Git
```

## Méthode 1: Compilation Locale (WDK)

### Prérequis
1. Windows Driver Kit (WDK) installé
2. Visual Studio 2019/2022 avec workload C++
3. Windows 11 x64

### Étapes
1. Ouvrir Visual Studio
2. Ouvrir `build/delbin_audio.vcxproj`
3. Sélectionner configuration "Release|x64"
4. Build → Build Solution
5. Le fichier `.sys` sera généré dans `build/x64/Release/`

## Méthode 2: Compilation GitHub Actions

### Créer `.github/workflows/build.yml`

```yaml
name: Build Audio Driver

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: windows-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Setup MSBuild
      uses: microsoft/setup-msbuild@v1
    
    - name: Install WDK
      run: |
        # Télécharger WDK
        # Installer WDK
        
    - name: Build Driver
      run: |
        msbuild build/delbin_audio.vcxproj /p:Configuration=Release /p:Platform=x64
        
    - name: Upload Artifacts
      uses: actions/upload-artifact@v2
      with:
        name: driver-package
        path: build/x64/Release/
```

## Méthode 3: Utilisation Pilotes Intel Existants

### Option Alternative - Utiliser Intel SST Audio Driver

Au lieu de compiler un nouveau pilote, utiliser les pilotes Intel existants:

1. Télécharger Intel SST Audio Driver pour Tiger Lake
2. Modifier le fichier INF avec notre ID matériel
3. Installer via pnputil

## Installation

### Via Script
```cmd
cd C:\Users\hassb\Desktop\Delbin_Audio_Driver
scripts\install.bat
```

### Via pnputil Manuel
```cmd
pnputil /add-driver driver\delbin_audio.inf /install
```

### Via Gestionnaire de Périphériques
1. Gestionnaire de périphériques
2. Mettre à jour le pilote pour "CoolStar HD Audio"
3. Sélectionner le fichier INF

## Vérification

### Vérifier l'installation
```powershell
pnputil /enum-drivers | findstr "Delbin"
```

### Vérifier le service audio
```powershell
Get-Service Audiosrv
Get-PnpDevice | Where-Object { $_.InstanceId -like "*VEN_8086&DEV_A0C8*" }
```

## Problèmes Connus

### Erreur de signature
- Utiliser Test Mode Windows pour développement
- Signer le pilote avec un certificat de test

### Pilote non reconnu
- Vérifier l'ID matériel correspond
- Redémarrer le service audio
- Réinitialiser le contrôleur HDA

## Notes Basées sur Analyses BIOS

- Le BIOS contient des références Intel HDA, Realtek ALC5682, et Conexant CX
- Le firmware Intel SST est présent dans le BIOS UEFI EDK2
- L'ID matériel détecté est: `PCI\VEN_8086&DEV_A0C8&SUBSYS_00000000&REV_20`
- Windows 11 détecte déjà le contrôleur comme "CoolStar HD Audio"
