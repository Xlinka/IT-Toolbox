@echo off

REM Check if the user has administrative privileges
NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo This script requires administrative privileges. Please run it as an administrator.
    pause
    exit /b 1
)

REM Flush DNS cache
echo Flushing DNS cache...
ipconfig /flushdns
if %ERRORLEVEL% NEQ 0 (
    echo An error occurred while flushing the DNS cache.
    pause
    exit /b 1
)

REM Reset DNS client settings
echo Resetting DNS client settings...
net stop "Dnscache"
net start "Dnscache"
if %ERRORLEVEL% NEQ 0 (
    echo An error occurred while resetting DNS client settings.
    pause
    exit /b 1
)

REM Release and renew IP address
echo Releasing and renewing IP address...
ipconfig /release
ipconfig /renew
if %ERRORLEVEL% NEQ 0 (
    echo An error occurred while releasing and renewing the IP address.
    pause
    exit /b 1
)

REM Display network adapter information
echo Network adapter information:
wmic nic get Name, AdapterType, NetConnectionStatus, Speed, MACAddress
pause

REM Display DNS server information
echo DNS server information:
nslookup
pause

REM Display the current DNS cache content
echo Current DNS cache content:
ipconfig /displaydns
pause

REM Display the local hosts file content
echo Local hosts file content:
type %SystemRoot%\System32\drivers\etc\hosts
pause
