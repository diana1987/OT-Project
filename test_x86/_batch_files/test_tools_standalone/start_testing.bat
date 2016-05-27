@echo off
SETLOCAL
cd /d %~dp0
md "Results_Output"
echo "Starting testing credential dumpers...Mimikatz is more tricky so we do a little hack and dump entire output to a file"
start /wait /b cmd /k CALL test1.bat >> "Results_Output\out_ToolsOutput.txt" 2>&1
PING 1.2.1.1 -n 100 >NUL 2>&1
echo "Moving output from pwdump7 to correct folder"
move *.pwdump Results_Output\
move *.cachedump Results_Output\
move *.fgdump-log Results_Output\
echo "Testing Incognito"
start /wait /b cmd /k CALL incognito.bat >> "Results_Output\out_incognito.txt" 2>&1
PING 1.2.1.1 -n 5 >NUL 2>&1
start /wait /b cmd /k CALL testing_mimikatz.bat >> "Results_Output\out_mimikatz_bun.txt" 2>&1
PING 1.2.1.1 -n 45 >NUL 2>&1
echo "Filtering using the filters defined in pattern/pattern.txt"
start /wait /b cmd /k CALL filter_dumpers.bat >> "Results_Output\out_filtered_tools.txt" 2>&1
echo "Filtered files dumped in out_filtered_tools"
PING 1.2.1.1 -n 5 >NUL 2>&1
echo "Start sorting output"
start /wait /b cmd /k CALL sort_file.bat
echo "Starting to save registries: ...."
start /wait /b cmd /k CALL save_reg.bat
echo "Check Results_Ouput\resultfile.txt to see which tools work"
echo "Check the reg\ folder for the registries"