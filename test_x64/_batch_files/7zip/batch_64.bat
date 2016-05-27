@echo off
cd /d %~dp0
msiexec.exe /qb /i "winx64\7z1514-x64.msi" INSTALLDIR="C:\Program Files\7-Zip"