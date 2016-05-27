@echo off
cd /d %~dp0
md "reg"
start /wait "" /w /b vssadmin list shadows > Results_Output\out_vssadmin.txt

