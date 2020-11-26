@echo off
echo resolving exsited network drive
net use z: /delete
echo Mapping Network Drive
net use z: \\server\music
echo Copying files over.
xcopy Z:\SportsSoundsPro\ %AppData%\SportsSoundsPro\  /E

echo Create Shortcut for SSP
SETLOCAL ENABLEDELAYEDEXPANSION
SET LinkName=Hello
SET Esc_LinkDest=%%HOMEDRIVE%%%%HOMEPATH%%\Desktop\Start SSP.lnk
SET Esc_LinkTarget=%AppData%\SportsSoundsPro\SSP_Start.bat
SET cSctVBS=CreateShortcut.vbs
SET LOG=".\%~N0_runtime.log"
((
  echo Set oWS = WScript.CreateObject^("WScript.Shell"^) 
  echo sLinkFile = oWS.ExpandEnvironmentStrings^("!Esc_LinkDest!"^)
  echo Set oLink = oWS.CreateShortcut^(sLinkFile^) 
  echo oLink.TargetPath = oWS.ExpandEnvironmentStrings^("!Esc_LinkTarget!"^)
  echo oLink.IconLocation = "%AppData%\SportsSoundsPro\SportsSoundsPro.exe"
  echo oLink.Save
  
)1>!cSctVBS!
cscript //nologo .\!cSctVBS!
DEL !cSctVBS! /f /q
)1>>!LOG! 2>>&1
echo Starting SSP
start %AppData%\SportsSoundsPro\SSP_Start.bat
echo Done
