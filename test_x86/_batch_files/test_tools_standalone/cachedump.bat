@echo off
SETLOCAL enabledelayedexpansion
cd /d %~dp0
for /r "." %%a in (*.exe) do (
:: %%a is used as argument for "TYPEd"
echo Checking: %%a
:: FIND /i : Specifies that the search is not case-sensitive.
ECHO.%%a| FIND /I "cachedump-1.2beta\cachedump.exe">Nul && (
   Echo Executing "cachedump.exe ".
   start /wait "" /w /b "%%a" -v >> "Results_Output\out_cachedump.txt" 2>&1
) || (
  Echo.
)

)
PAUSE
endlocal
goto :EOF

@end


