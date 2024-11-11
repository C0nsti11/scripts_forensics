@echo off

:: Detect if running on Windows Vista or later to set paths accordingly
set "desktopPath="
if exist "C:\Users\%USERNAME%\Desktop" (
    set "desktopPath=C:\Users\%USERNAME%\Desktop"
) else (
    set "desktopPath=C:\Documents and Settings\%USERNAME%\Desktop"
)

:: Create folder on the desktop named after the computer
mkdir "%desktopPath%\%COMPUTERNAME%"

echo Gathering Installed Application Info
:: Use WMIC if available; otherwise, display a message that this info cannot be gathered
if exist %WINDIR%\System32\wbem\wmic.exe (
    wmic product get name, version > "%desktopPath%\%COMPUTERNAME%\%COMPUTERNAME%_Installed_Product_List.txt"
) else (
    echo WMIC not available. Cannot retrieve installed applications list. > "%desktopPath%\%COMPUTERNAME%\%COMPUTERNAME%_Installed_Product_List.txt"
)

:: Gather system information
echo Gathering system information
systeminfo > "%desktopPath%\%COMPUTERNAME%\%COMPUTERNAME%_systeminfo.txt"

:: Gather network information
echo Gathering Network information
netstat -aon > "%desktopPath%\%COMPUTERNAME%\%COMPUTERNAME%_Network.txt"

:: Gather process information (use WMIC if available, otherwise notify)
echo Gathering Process and their parent processid
if exist %WINDIR%\System32\wbem\wmic.exe (
    wmic process get processid,parentprocessid,executablepath > "%desktopPath%\%COMPUTERNAME%\%COMPUTERNAME%_running_processs_ppid.txt"
) else (
    echo WMIC not available. Cannot retrieve process list with parent process IDs. > "%desktopPath%\%COMPUTERNAME%\%COMPUTERNAME%_running_processs_ppid.txt"
)

:: Gather running tasks
echo Gathering running tasks
tasklist > "%desktopPath%\%COMPUTERNAME%\%COMPUTERNAME%_running_tasks.txt"

:: Check Windows version and activation information
echo Gathering Windows version and activation information...
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"Registered Owner" /C:"Registered Organization" > "%desktopPath%\%COMPUTERNAME%\%COMPUTERNAME%_activation_detail_sysinfo.txt"

:: Registry query for activation details (works across Windows versions)
reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId > "%desktopPath%\%COMPUTERNAME%\%COMPUTERNAME%_activation_detail_registry.txt"

:: Gather IP and MAC address information
ipconfig /all > "%desktopPath%\%COMPUTERNAME%\%COMPUTERNAME%_mac_ip.txt"

pause
