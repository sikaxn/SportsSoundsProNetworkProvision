net use z: /delete
echo Mapping Network Drive
net use z: \server\music


echo Starting SSP

SETLOCAL EnableExtensions
set EXE=SportsSoundsPro.exe
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% goto FOUND
echo Not running
goto FIN
:FOUND
echo Running
mshta "javascript:new ActiveXObject('WScript.Shell').popup('SSP is already running.',7,'ERROR',64);window.close();"
exit

:FIN
mshta "javascript:new ActiveXObject('WScript.Shell').popup('DO NOT CLOSE Command Pronpt. This can ensure logs being collected and uploaded to the server.',7,'Logit warning',64);window.close();"
start /w %AppData%\SportsSoundsPro\SportsSoundsPro.exe 
echo Uploading logs
xcopy /K /H /Y /D %AppData%\SportsSoundsPro\SportsSoundsProLog.txt Z:\SSPLogFile\
rename Z:\SSPLogFile\SportsSoundsProLog.txt "SSPLog_%date:~0,4%-%date:~5,2%-%date:~8,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.txt"
del /f %AppData%\SportsSoundsPro\SportsSoundsProLog.txt
xcopy /K /H /Y /D %AppData%\SportsSoundsPro\SSP.inf Z:\SportsSoundsPro\SSP.inf 
echo Done