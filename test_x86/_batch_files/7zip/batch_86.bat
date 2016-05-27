@echo off
cd /d %~dp0
msiexec.exe /qb /i "winx86\7z1514.msi" INSTALLDIR="C:\Program Files\7-Zip"