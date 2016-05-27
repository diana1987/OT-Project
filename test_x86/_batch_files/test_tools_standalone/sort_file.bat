@ECHO OFF
SETLOCAL
cd /d %~dp0
cd "Results_Output"
:: remove variables starting $
FOR  /F "delims==" %%a In ('set $ 2^>Nul') DO SET "%%a="

FOR /f "delims=" %%a IN (out_filtered_tools) DO SET $%%a=Y
(FOR  /F "delims=$=" %%a In ('set $ 2^>Nul') DO ECHO %%a)> resultfile.txt

GOTO :EOF