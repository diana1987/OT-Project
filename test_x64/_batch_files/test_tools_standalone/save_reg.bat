@echo off
cd /d %~dp0
md "reg"
start /wait "" /w /b reg SAVE HKLM\SAM "reg\sam"
start /wait "" /w /b reg SAVE HKLM\SECURITY "reg\security"
start /wait "" /w /b reg SAVE HKLM\SYSTEM "reg\system"