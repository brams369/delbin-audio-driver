@echo off
REM Script d'installation du pilote

echo Installation Delbin Audio Driver...

REM Installation via pnputil
pnputil /add-driver driver\delbin_audio.inf /install

if %ERRORLEVEL% EQU 0 (
    echo Installation reussie
) else (
    echo Erreur d'installation
)

pause
