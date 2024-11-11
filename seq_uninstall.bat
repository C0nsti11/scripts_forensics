@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script must be run as administrator!
    pause
    exit /b
)

:: Uninstall Seqrite Endpoint Security using the uninstall string
echo Uninstalling Seqrite Endpoint Security...
msiexec /x "C:\PROGRA~1\Seqrite\CLIENT~1.11\AGUNINST.exe /silent UninstUI" /qn REBOOT=ReallySuppress

:: Replace {UninstallString} with the actual string found in the registry
echo Uninstallation complete.
pause
