@echo off
mode con:cols=170 lines=2700
title Windows Credential Dumpers (OS3 - Diana Rusu)
::Menu to select any type of scenario for running Windows credential dumpers tests
:top
echo ***************************************************************
echo.
echo              Windows Credential Dumpers
echo.
echo  NOTE: There is a time delay between operations, so please wait for the program to complete.
echo.
echo ***************************************************************
echo Key: [1] Scenario One (x86)    - Start Windows Server 2008 R2, Windows 7 x86, Windows 8.1 x86, Windows 10 x86
echo.
echo      [2] Scenario Two (x64)    - Start Windows Server 2008 R2, Windows 7 x64, Windows 8.1 x64, Windows 10 x64
echo.
echo      [3] Scenario Three (Server)  - Start Windows Server 2008 (x86), Windows Server 2008 (x64), Windows Server 2008 R2
echo.
echo      [5] Scenario Four (Server)  - Start Windows Server 2012, Windows Server 2012 R2
echo.
echo      [4] Attacker              - Start Kali
echo.
echo      [e] Exit
echo.
echo ***************************************************************
echo Enter the number for the selection:
echo.
set /p udefine=
echo.
echo ***************************************************************
::SWITCH type of selection
if %udefine%==1 goto scenario1
if %udefine%==2 goto scenario2
if %udefine%==3 goto scenario3
if %udefine%==4 goto start_kali
::First we need to send the folder containing all credential dumpers
if %udefine%==4 goto start_kali

if %udefine%==5 goto copy_dumpers
if %udefine%==6 goto stop_vms
if %udefine%==e goto exit


:scenario1
::DISABLE UAC Windows7: C:\Windows\System32\cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
echo Starting Scenario One (x86)    - Start Windows Server 2008 R2, Windows 7 x86, Windows 8.1 x86, Windows 10 x86
echo Starting Windows_7_x86....
vmrun -T ws start "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx"
PING 1.2.1.1 -n 20 >NUL 2>&1
echo Starting Windows_8.1_x86....
vmrun -T ws start "F:\_OT_Win_VMs\Win8.1_x86\Windows 8.vmx"
PING 1.2.1.1 -n 20 >NUL 2>&1
echo Starting Windows_10_x86....
vmrun -T ws start "F:\_OT_Win_VMs\Win10_x86\Windows 10 x86.vmx"
PING 1.2.1.1 -n 20 >NUL 2>&1
echo Starting Windows_Server__2008R2_x86....
vmrun -T ws start "F:\_OT_Win_VMs\WindowsServer2008R2\Windows Server 2008 R2 x64.vmx"
goto selection

:scenario2
vmrun -T ws start "F:\_OT_Win_VMs\Win2012\Windows Server 2012 _1.vmx"
goto selection

:scenario3
REM echo Copy 7zip
REM vmrun  -gu user01 -gp queen copyFileFromHostToGuest "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx" "E:\_OT_project\7zip\winx86\7z1514.msi" "C:\Users\user01\Desktop\7z1514.msi"
REM PAUSE
REM echo Install 7zip
REM vmrun  -gu user01 -gp queen copyFileFromHostToGuest "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx" "E:\_OT_project\7zip\batch.bat" "C:\Users\user01\Desktop\batch.bat"
REM vmrun  -gu user01 -gp queen runProgramInGuest "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx"   %COMSPEC% "/c C:\Users\user01\Desktop\batch.bat"
REM PAUSE
REM echo Create folder test_dumpers
REM vmrun  -gu user01 -gp queen createDirectoryInGuest "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx" "C:\Users\user01\Desktop\test_dumpers"
REM echo Copy unzip.batch and the ot_credential_dumpers to the created folder
REM vmrun  -gu user01 -gp queen copyFileFromHostToGuest "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx" "E:\_OT_project\_unzip_batch_files\unzip.bat" "C:\Users\user01\Desktop\test_dumpers\unzip.bat"
REM vmrun  -gu user01 -gp queen copyFileFromHostToGuest "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx" "F:\credential_dumpers.zip" "C:\Users\user01\Desktop\test_dumpers\credential_dumpers.zip"
REM PAUSE
REM echo Unzip credential_dumpers
REM vmrun  -gu user01 -gp queen runProgramInGuest "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx" %COMSPEC% "/c C:\Users\user01\Desktop\test_dumpers\unzip.bat"
REM PAUSE
REM vmrun  -gu user01 -gp queen runProgramInGuest "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx"  %COMSPEC% "/c C:\Users\user01\Desktop\test_dumpers\credential_dumpers\unzip_to_folder.bat"
REM PAUSE
echo Start the batch for testing the tools
vmrun  -gu user01 -gp queen runProgramInGuest "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx"  "c:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" "& 'C:\Users\user01\Desktop\test_dumpers\credential_dumpers\test_dumpers.ps1' -default"
PAUSE
goto selection

:start_kali
vmrun -T ws start "F:\_OT_Win_VMs\Kali\Kali_x64.vmx"
goto selection

::Before running the commands below, UAC has to be turned off. REMEMBER! Turn UAC back on to not affect results
:copy_dumpers
echo Started copying From Host to Guest...
echo 1. Copy dumpers zip to Win10_x86
vmrun  -gu dia -gp user10 copyFileFromHostToGuest "F:\_OT_Win_VMs\Win10_x86\Windows 10 x86.vmx" "E:\_OT_project\ot_credential_dumpers.zip" "C:\Users\dia\Desktop\ot_credential_dumpers.zip"
echo 2. Copy dumpers zip  Windows7_x86
vmrun  -gu user01 -gp queen copyFileFromHostToGuest "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx" "E:\_OT_project\ot_credential_dumpers.zip" "C:\Users\user01\Desktop\ot_credential_dumpers.zip"
echo 3. Copy dumpers zip  Windows8.1
vmrun  -gu user -gp user81 copyFileFromHostToGuest "F:\_OT_Win_VMs\Win8.1_x86\Windows 8.vmx" "E:\_OT_project\ot_credential_dumpers.zip" "C:\Users\user\Desktop\ot_credential_dumpers.zip"
echo 4. Starting CMD in Win10_x86
vmrun  -gu dia -gp user10 runProgramInGuest "F:\_OT_Win_VMs\Win10_x86\Windows 10 x86.vmx" -noWait -activeWindow -interactive "c:\windows\system32\cmd.exe"
echo 5. Starting CMD in Win8.1x86
vmrun   -gu user -gp user81  runProgramInGuest "F:\_OT_Win_VMs\Win8.1_x86\Windows 8.vmx" -noWait  -activeWindow -interactive "c:\windows\system32\cmd.exe"
echo 6 Starting CMD in Windows7_x86
vmrun  -gu user01 -gp queen  runProgramInGuest "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx" -noWait -activeWindow -interactive "c:\windows\system32\cmd.exe"
echo 7. Finised...
goto selection

:stop_vms
vmrun stop "E:\_OT_project\_OT_VMs\Windows7_x86\Windows 7 x86.vmx"
PING 1.2.1.1 -n 10 >NUL 2>&1
vmrun stop "F:\_OT_Win_VMs\Win8.1_x86\Windows 8.vmx"
PING 1.2.1.1 -n 10 >NUL 2>&1
vmrun stop "F:\_OT_Win_VMs\Win10_x86\Windows 10 x86.vmx"
PING 1.2.1.1 -n 10 >NUL 2>&1
vmrun stop "F:\_OT_Win_VMs\WindowsServer2008R2\Windows Server 2008 R2 x64.vmx"
goto selection

:menu_options
cls
echo ***************************************************************
echo.
echo Windows Hash Dumpers
echo.
echo ***************************************************************
echo      [5] Copy credential dumpers zip in started vms
echo.
echo      [6] STOP all VMs from ""Scenario One (x86)""
echo.
echo      [e] to exit
echo.
echo      [b] to go back and select another scenario.
echo.
set /p udefine=
echo.
echo ***************************************************************
if %udefine%==b goto top
if %udefine%==e goto exit


:selection
cls
echo ***************************************************************
echo.
echo Windows Hash Dumpers
echo.
echo ***************************************************************
echo Type [e] to exit or [b] to go back and select another scenario.
echo.
set /p udefine=
echo.
echo ***************************************************************
if %udefine%==b goto top
if %udefine%==e goto exit
:exit
cls
pause
exit
