@echo off
cd /d %~dp0
for /F %%i in (pattern\pattern.out) do (
echo Files containing %%i
findstr /M /C:%%i /S *.txt *.pwdump >> "Results_Output\out_filtered_tools"
)