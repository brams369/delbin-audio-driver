# Delbin Chromebook Audio Driver

Project de pilote audio pour ASUS Chromebook Vibe CX5/CX55 (delbin) sur Windows 11

## Matériel
- **Platforme:** Intel Tiger Lake (TGL)
- **Controleur HDA:** Intel HD Audio (PCI\VEN_8086&DEV_A0C8)
- **Codec:** Realtek ALC5682 / Conexant CX
- **Firmware:** Intel SST (Sound Open Firmware)

## Installation
1. Cloner ce repository
2. Compiler le pilote avec Windows Driver Kit (WDK)
3. Signer le pilote (test mode pour développement)
4. Installer via pnputil ou Gestionnaire de périphériques

## Compatibilité
- Windows 11 x64
- Intel SST Audio Driver for Tiger Lake

## Sources
- Intel SST Audio Driver: https://www.intel.com/content/www/us/en/download-center/home.html
- MrChromebox UEFI: https://mrchromebox.tech/
