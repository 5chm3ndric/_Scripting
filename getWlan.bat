@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

set OUTPUT_FOLDER=Export
set OUTPUT_FILE=%OUTPUT_FOLDER%\WLAN.txt

if not exist %OUTPUT_FOLDER% mkdir %OUTPUT_FOLDER%

if exist %OUTPUT_FILE% del %OUTPUT_FILE%

for /f "tokens=4,* delims=: " %%a in ('netsh wlan show profile ^| findstr "Profil für alle Benutzer"') do (
    set "PROFILE_NAME=%%b"
    echo Ergebnis 1 ist: !PROFILE_NAME!
    echo Ausführen für Profil: !PROFILE_NAME! >> %OUTPUT_FILE%
    netsh wlan show profile name="!PROFILE_NAME!" key=clear >> %OUTPUT_FILE% 2>&1
    echo. >> %OUTPUT_FILE%
)

echo Ergebnisse wurden in %OUTPUT_FILE% gespeichert.
