@echo off
SETLOCAL enabledelayedexpansion
cd /d %~dp0
for /r "." %%a in (*.exe) do (
:: %%a is used as argument for "TYPEd"
echo Checking: %%a
:: FIND /i : Specifies that the search is not case-sensitive.
ECHO.%%a| FIND /I "incognito.exe">Nul && (
  Echo Executing "incognito.exe". This tool is not appending output to file and it requires to run using CMD
   start /wait "" /b "%%a" -h 127.0.0.1 list_tokens -u
  PING 1.2.1.1 -n 5 >NUL 2>&1
  start /wait "" /b "%%a" -h 127.0.0.1 list_tokens -g
  PING 1.2.1.1 -n 10 >NUL 2>&1
) || (
  Echo.
)
)
PAUSE
endlocal
goto :EOF

@end


