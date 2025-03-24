@echo off
echo Kasowanie kont w domenie
set /p ile="Podaj liczbe kont do skasowania "
echo %ile%
for /L %%X IN (1,1,%ile%) do net user uczen%%X /delete
net user
pause
