@echo off
SET INTERFACE=
:start
cls
echo ==========================================
echo                     KTX
echo ==========================================
echo.

if defined INTERFACE (
    echo Aktualnie wybrany interfejs: %INTERFACE%
) else (
    echo Interfejs nie zostal jeszcze wybrany.
)
echo.
echo [1] Pokaz i wybierz interfejs
echo [2] Pokaz aktualne IP
echo [3] Ustaw statyczne IP
echo [4] Ustaw DHCP
echo [5] Spinguj
echo [6] Odpal Powershell
echo [7] Odpal Powershell ISE
echo [8] Stworz konta
echo [9] Usun konta
echo [0] Zamknij program
echo.

:choice
SET /P C=Podaj numer:
if [%C%]==[1] goto 1
if [%C%]==[2] goto 2
if [%C%]==[3] goto 3
if [%C%]==[4] goto 4
if [%C%]==[5] goto 5
if [%C%]==[6] goto 6
if [%C%]==[7] goto 7
if [%C%]==[8] goto 8
if [%C%]==[9] goto 9
if [%C%]==[0] goto 0
goto choice

:1
@echo off
cls
echo Wybierz interfejs:
netsh interface show INTERFACE
echo.
echo (Wybierz interfejs wpisujac jego nazwe w cudzyslowie np. "Ethernet")
SET /P INTERFACE=Interfejs: 
echo Interfejs %INTERFACE% zostal wybrany.
goto start 

:2
@echo off
cls
if not defined INTERFACE (
    echo Nie wybrano interfejsu. Wybierz interfejs przed kontynuowaniem.
    pause
    goto start
)
echo Wyszukiwanie konfiguracji IP dla interfejsu: %INTERFACE%
netsh interface ip show config %INTERFACE%
pause
goto start

:3
@echo off
cls
if not defined INTERFACE (
    echo Nie wybrano interfejsu. Wybierz interfejs przed kontynuowaniem.
    pause
    goto start
)
echo Ustawianie statycznego IP dla interfejsu %INTERFACE%
echo Wpisz statyczne IP:
SET /P IP=IP: 
echo Wpisz maske podsieci:
SET /P MASK=Maska: 
echo Wpisz brame domyslna:
SET /P GATEWAY=Brama: 

netsh interface ip set address "%INTERFACE%" static %IP% %MASK% %GATEWAY%
netsh interface ip add dns "%INTERFACE%" addr="8.8.4.4"
netsh interface ip add dns "%INTERFACE%" addr="8.8.8.8"
netsh interface ip show config "%INTERFACE%"
pause
goto start

:4
@echo off
cls
if not defined INTERFACE (
    echo Nie wybrano interfejsu. Wybierz interfejs przed kontynuowaniem.
    pause
    goto start
)
echo Odpalanie DHCP dla interfejsu %INTERFACE%
netsh interface ip set address "%INTERFACE%" source=dhcp
netsh interface ip set dnsservers "%INTERFACE%" source=dhcp
netsh interface ip show config "%INTERFACE%"
pause
goto start

:5
@echo off
cls
echo Wpisz adres IP do spingowania:
SET /P TARGET_IP=IP: 
echo Pinging %TARGET_IP%
ping %TARGET_IP%
pause
goto start

:6
@echo off
cls
start powershell.exe
goto start

:7
@echo off
cls
start PowerShell_ISE.exe
goto start

:8
@echo off
cls
set /p nazwa="Podaj nazwe podstawowa konta (np. uczen): "
set /p ile="Podaj liczbe kont do utworzenia: "
set /p haslo="Podaj haslo dla wszystkich kont: "
for /L %%X IN (1,1,%ile%) do net user %nazwa%%%X %haslo% /add
net user
pause
goto start

:9
@echo off
cls
set /p nazwa="Podaj nazwe podstawowa konta (np. uczen): "
set /p ile="Podaj liczbe kont do skasowania: "
for /L %%X IN (1,1,%ile%) do net user %nazwa%%%X /delete
net user
pause
goto start

:0
end
