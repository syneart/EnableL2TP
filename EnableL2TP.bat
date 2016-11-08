@echo off
echo Crate ProhibitIpSec with 0
reg add "HKLM\SYSTEM\CurrentControlSet\services\RasMan\Parameters" /v ProhibitIpSec /t REG_DWORD /d 0 /f
echo Crate AssumeUDPEncapsulationContextOnSendRule with 2
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 2 /f
echo Process service - Remote Access Auto Connection Manager
sc config RasAuto start= auto
sc start RasAuto
echo Process service - Remote Access Connection Manager
sc config RasMan start= auto
sc start RasMan
echo Process service - Secure Socket Tunneling Protocol Service
sc config SstpSvc start= auto
sc start SstpSvc
echo All finish, please REBOOT your system.
pause