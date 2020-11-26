@echo off
net use z: /delete
echo Mapping Network Drive
net use z: \\server\music


echo Starting SSP

SETLOCAL EnableExtensions
set EXE=SportsSoundsPro.exe
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% goto FOUND
echo Not running
goto NOTFOUND
:FOUND
echo Running
mshta "javascript:new ActiveXObject('WScript.Shell').popup('SSP is already running.',7,'ERROR',64);window.close();"
exit

:NOTFOUND
mshta "javascript:new ActiveXObject('WScript.Shell').popup('DO NOT CLOSE Command Pronpt. This can ensure logs being collected and uploaded to the server.',7,'Logit warning',64);window.close();"
start %AppData%\SportsSoundsPro\SportsSoundsPro.exe 
powershell -window minimized -command ""

:CHECK
echo SSP is running DONOT CLOSE
more %AppData%\SportsSoundsPro\SportsSoundsProLog.txt
@timeout /t 3 
cls
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% goto CHECK

echo QUITTING
timeout 1
goto QUITTING
:QUITTING
echo Uploading logs
xcopy /K /H /Y /D %AppData%\SportsSoundsPro\SportsSoundsProLog.txt Z:\SSPLogFile\
rename Z:\SSPLogFile\SportsSoundsProLog.txt "SSPLog_%date:~0,4%-%date:~5,2%-%date:~8,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.txt"
del /f %AppData%\SportsSoundsPro\SportsSoundsProLog.txt
xcopy /K /H /Y /D %AppData%\SportsSoundsPro\SSP.inf Z:\SportsSoundsPro\SSP.inf 
echo Done
echo  
echo Disconnecting from server
net use z: /delete
echo Window will close
timeout 3
exit
