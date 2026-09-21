@echo off
REM Script de compilation pour Windows Driver Kit (WDK)
REM Nécessite: Windows Driver Kit (WDK) installé

echo Compilation Delbin Audio Driver...

REM Configuration du chemin WDK (adapter selon votre installation)
set WDK_PATH=C:\Program Files (x86)\Windows Kits\10

REM Compilation du pilote
call "%WDK_PATH%\bin\x64\build.bat" delbin_audio.vcxproj

if %ERRORLEVEL% EQU 0 (
    echo Compilation reussie
) else (
    echo Erreur de compilation
)

pause
