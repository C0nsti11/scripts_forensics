@echo off
setlocal enabledelayedexpansion

:: Define the file containing the IP addresses (one per line)
set "ipFile=C2_server_List.txt"
:: Define the output file for logging
set "logFile=tracert_log.txt"

:: Clear the log file if it already exists
if exist "%logFile%" del "%logFile%"

:: Loop through each IP in the file
for /f "tokens=*" %%A in (%ipFile%) do (
    echo Tracing route to %%A... >> "%logFile%"
    tracert %%A >> "%logFile%"
    ping %%A -n 2 >> "%logFile%"
    echo. >> "%logFile%" 
)

echo All tracert commands have been executed. Check the "%logFile%" for results.
pause
