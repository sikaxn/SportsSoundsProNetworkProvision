# Sports Sounds Pro in network

This set of script allows you to use Sports sounds pro (SSP) in a networked environment using SMB based shared folder.

[Get Sports sounds pro](http://www.sportssoundspro.com/)

these scripts allows SSP to

 1. Be used in a networked environment.
 2. Sync settings
 3. Sync logs
## Creating shared folder

A SMB shared folder can be created using windows file sharing, In order to get these script to work, full write and read permission needs to be enabled. 

Under this shared folder, these file should be contained. 
1. SSP install. This can be accomplished by copying SSP from program files folder from a computer installed with SSP directly to the server. SSP.inf file under SSP install folder consist license key and settings. When trying to get SSP setup on the server, first install SSP and activate it using the regular way, enable logging and tweak settings to best fitting your need, than copy the whole \SportsSoundsPro folder from program file to the server. 
2. all music that you want SSP to play. Feel free to organizing these files using your prefered way.
3. SSP_LocalProvision_Log.bat under the root directory of your shared folder. Remember to open it and change the shared folder address.
4. SSP_start.bat under \SportsSoundsPro on your shared folder so it get copied over to your host computer running SSP.Remember to open it and change the shared folder address.
5. create the .set file for your SSP so it has all the music buttons you need. notes that SSP.inf file under \SportsSoundsPro remember what .set was last opened. Therefore you want to sync your SSP.inf to your server by copying it over. 
6. SSPLogFile folder that collect all logs SSP on client computer create.

## Provision SSP on client computer

After creating the shared folder with all the necessary file, use a client computer to access that shared folder and run SSP_LocalProvision_Log.bat with administrator privilege. SSP_LocalProvision_Log.bat will create a shortcut to SSP_start.bat and run it.

## Using SSP on client computer

 After SSP is provisioned, using the Start SSP shortcut on desktop to start SSP. This script will ensure network drives are properly mapped, and will copy log and sync SSP settings after SSP is closed. This script will also detect weather SSP is already running and prevent a second instance from running as this would prevent logging from work properly.

## Modifying the script

To disable logging, delete these from SSP_start.bat, ensure it's synced on the server than provision clients again.

```batch
echo Uploading logs
xcopy /K /H /Y /D %AppData%\SportsSoundsPro\SportsSoundsProLog.txt Z:\SSPLogFile\
rename Z:\SSPLogFile\SportsSoundsProLog.txt "SSPLog_%date:~0,4%-%date:~5,2%-%date:~8,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.txt"
del /f %AppData%\SportsSoundsPro\SportsSoundsProLog.txt
```

To disable syncing SSP.inf , delete these from SSP_start.bat, ensure it's synced on the server than provision clients again.
```batch
xcopy /K /H /Y /D %AppData%\SportsSoundsPro\SSP.inf Z:\SportsSoundsPro\SSP.inf 
```
## Future update

1. automatic check for SSP and scripts update from server.
2. automatic scrip that configuring scripts. 
