@echo off
cd C:\Users\user01\Desktop\test_dumpers\credential_dumpers\test
variable1=wce.exe
setlocal enableextensions enabledelayedexpansion
for /r "." %%a in (*.exe) do (
echo This is iteration %%a
set tst=%%a
set tst=!tst:wce=!
if not !tst!==%%a ( 
     echo %%a DOES CONTAIN
     start /wait "" /w /b "%%~fa" -w
) else (
    echo %%a does not contain wce
  )

start /wait "" /w /b "%%~fa"
PING 1.2.1.1 -n 2 >NUL 2>&1
)
PAUSE
endlocal