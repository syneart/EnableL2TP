:: Copyright by SyneArt <sa@syneart.com>
@echo off
call :check_Permissions
echo.&echo Create key "ProhibitIpSec" with 0
reg add "HKLM\SYSTEM\CurrentControlSet\services\RasMan\Parameters" /v ProhibitIpSec /t REG_DWORD /d 0 /f
echo.&echo Create key "AssumeUDPEncapsulationContextOnSendRule" with 2
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 2 /f
echo.&echo Active service "Remote Access Auto Connection Manager"
sc config RasAuto start= auto
sc start RasAuto
echo.&echo Active service "Remote Access Connection Manager"
sc config RasMan start= auto
sc start RasMan
echo.&echo Active service "Secure Socket Tunneling Protocol Service"
sc config SstpSvc start= auto
sc start SstpSvc
echo All finish, please REBOOT your system.
pause >nul

:check_Permissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
    ) else (
        echo Failure: Current permissions inadequate. 
		echo Administrative permissions required.
		pause >nul
		EXIT
    )
