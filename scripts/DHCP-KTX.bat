@echo off
:start
cls
echo ===========================================
echo                     KTX
echo ===========================================
echo.
echo [1] Ustaw statyczne IP 10.10.7.11
echo [2] Ustaw statyczne IP 172.31.16.11
echo [3] Ustaw statyczne IP jakie chcesz
echo [4] Ustaw DHCP
echo [5] Zamknij program
echo.

:choice
SET /P C=Podaj numer:
if [%C%]==[1] goto 1
if [%C%]==[2] goto 2
if [%C%]==[3] goto 3
if [%C%]==[4] goto 4
if [%C%]==[5] goto 5
goto choice

:1
@echo off
echo Setting static IP address: 10.10.7.11
netsh interface ip set address "Ethernet" static 10.10.7.11 255.255.255.0 10.10.7.1
netsh interface ip add dns "Ethernet" addr="8.8.4.4"
netsh interface ip add dns "Ethernet" addr="8.8.8.8"
netsh interface ip show config "Ethernet"
pause
goto start

:2
@echo off
echo Setting static IP address: 172.31.16.11
netsh interface ip set address "Ethernet" static 172.31.16.11 255.255.255.0 172.31.16.1
netsh interface ip add dns "Ethernet" addr="8.8.4.4"
netsh interface ip add dns "Ethernet" addr="8.8.8.8"
netsh interface ip show config "Ethernet"
pause
goto start

:3
@echo off
echo Wpisz statyczne IP:
SET /P IP=IP: 
echo Wpisz maske podsieci:
SET /P MASK=Maska: 
echo Wpisz brame domyslna:
SET /P GATEWAY=Brama: 

echo Setting static IP address: %IP%
netsh interface ip set address "Ethernet" static %IP% %MASK% %GATEWAY%
netsh interface ip add dns "Ethernet" addr="8.8.4.4"
netsh interface ip add dns "Ethernet" addr="8.8.8.8"
netsh interface ip show config "Ethernet"
pause
goto start

:4
@echo off
echo Enabling DHCP
netsh interface ip set address "Ethernet" source=dhcp
netsh interface ip set dnsservers "Ethernet" source=dhcp
netsh interface ip show config "Ethernet"
pause
goto start

:5
end
