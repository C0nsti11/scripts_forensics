@echo off

mkdir "C:\Users\%USERNAME%\Desktop\%COMPUTERNAME%"

echo Gathering Installed Application Info
wmic product get name, version > "C:\Users\%USERNAME%\Desktop\%COMPUTERNAME%\%COMPUTERNAME%_Installed_Product_List.txt"

::pause
echo Gathering system information
systeminfo > "C:\Users\%USERNAME%\Desktop\%COMPUTERNAME%\%COMPUTERNAME%_systeminfo.txt"

echo Gathering Network information
netstat -aon > "C:\Users\%USERNAME%\Desktop\%COMPUTERNAME%\%COMPUTERNAME%_Network.txt"

echo Gathering Process and their parent processid
wmic process get processid,parentprocessid,executablepath > "C:\Users\%USERNAME%\Desktop\%COMPUTERNAME%\%COMPUTERNAME%_running_processs_ppid.txt"

echo Gathering runnning tasks
tasklist > "C:\Users\%USERNAME%\Desktop\%COMPUTERNAME%\%COMPUTERNAME%_running_tasks.txt"

:: Check Windows version and activation information
echo Gathering windows version and activation information...
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"Registered Owner" /C:"Registered Organization" > "C:\Users\%USERNAME%\Desktop\%COMPUTERNAME%\%COMPUTERNAME%_activation_detail_sysinfo.txt"
reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId > "C:\Users\%USERNAME%\Desktop\%COMPUTERNAME%\%COMPUTERNAME%_activation_detail_registry.txt"

ipconfig /all > "C:\Users\%USERNAME%\Desktop\%COMPUTERNAME%\%COMPUTERNAME%_mac_ip.txt

pause