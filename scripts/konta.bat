@echo off
echo Tworzenie kont w domenie
set /p ile="Podaj liczbe kont do utworzenia "
echo %ile%
for /L %%X IN (1,1,%ile%) do net user uczen%%X Qwerty123 /add
net user
pause
