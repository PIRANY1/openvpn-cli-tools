:: Use only under MIT License
:: If you want to Publish a modified Version please mention the Original Creator PIRANY and link the GitHub Repo

:: Some Startup Stuff (yk)
cls
@echo off
set "scriptstart=%time%"
@title Starting Up...
echo Starting Up...
@color 02
@setlocal enableextensions ENABLEDELAYEDEXPANSION 

:: Checks if the Script is started by a debug Script
:: update part to be linked here
@if defined debug_assist @ECHO ON
@if defined devtools goto devpart

:: Allows ASCII Art to be Used in the Script (50/50 pasted) Instead of Echo Use %$Echo% " 
SETLOCAL EnableDelayedExpansion
SET $Echo=FOR %%I IN (1 2) DO IF %%I==2 (SETLOCAL EnableDelayedExpansion ^& FOR %%A IN (^^^!Text:""^^^^^=^^^^^"^^^!) DO ENDLOCAL ^& ENDLOCAL ^& ECHO %%~A) ELSE SETLOCAL DisableDelayedExpansion ^& SET Text=
SETLOCAL DisableDelayedExpansion

:: Presets some Variables when used in cal
set "elevated="
set "exitcode="
set "gitver12=v0"
set "-= "

::Checks if the OpenVPN GUI Executable exists.
if not exist "C:\Program Files\OpenVPN\bin\openvpn-gui.exe" goto :installation-not-found
set "startuptimeend=%time%"

:: Checks if the Config already exists and if not creates one
if exist "%USERPROFILE%\Documents\OpenVPN-CLI-Tools\config.txt" (goto config-exists) else (goto create-config)

:create-config
cd /d %USERPROFILE%\Documents\
mkdir OpenVPN-CLI-Tools
cd /d OpenVPN-CLI-Tools
echo :: This File was created by OpenVPN-CLI-Tools. It may be valuable if you used OpenVPN-CLI-Tools once. > config.txt
echo Added Config File to: "%USERPROFILE%\Documents\OpenVPN-CLI-Tools\"
echo Moving Script to: "%USERPROFILE%\Documents\OpenVPN-CLI-Tools\"
cd /d %~dp0
xcopy main.bat %USERPROFILE%\Documents\OpenVPN-CLI-Tools\ /q /y
cd /d %USERPROFILE%\Documents\OpenVPN-CLI-Tools\
goto config-exists

:: Extracts Data from Config, if avaiable
:config-exists
cd /d %USERPROFILE%\Documents\OpenVPN-CLI-Tools\
set /p config=<config.txt
echo %config%
@ping -n 2 localhost> nul
goto main

:: ------------
:: Startup Done
:: ------------


:: Checks if the Script is elevated when called
:checkelev
net session >nul 2>&1
if %errorLevel% == 0 ( set "elevated=1" )
goto :EOF

:: Main Part
:main
cls
@title OpenVPN-CLI-Tool
echo             OpenVPN-CLI-Tools
echo.
echo             [1] Info
echo.         
echo             [2] Add to Path
echo.            
echo             [3] Autostart
echo.            
echo             [4] Settings
echo.            
echo             [5] Check for Updates
echo.            
echo             [6] Open the Github-Repo
echo.            
echo             [7] Delete Script
echo. 
echo             [8] Exit
echo. 
echo             Enter a menu option in the Keyboard [1,2,3,4,5,6,7] :
choice /C 1234567 /N
set _erl=%errorlevel%
if %_erl%==8 exit /b 0
if %_erl%==7 cls & goto delete-script
if %_erl%==6 start "" "https://github.com/PIRANY1/openvpn-cli-tools" & cls % goto main 
if %_erl%==5 setlocal & call check-updates & cls & endlocal & goto :main
if %_erl%==4 cls & goto settings
if %_erl%==3 cls & goto autostart
if %_erl%==2 cls & goto add-to-path
if %_erl%==1 cls & goto info
goto :main

:info
echo If you found an Error please create an Issue on the GithubRepo.
echo Please find Information about the Licensing in LICENSE or in the Github Repo
pause
goto main

:add-to-path

:autostart

:settings

:installation-not-found
echo The Script couldnt found the OpenVPN installation.
echo Please add the Path to the OpenVPN-gui.exe manually
echo It can look something like C:\Program Files\OpenVPN\bin\openvpn-gui.exe
set /p openvpn-exe=Enter the Path:

:delete-script
echo Are you Sure you want to delete the Script?
choice /C yn /M "Press Y to continue or N to go back:"
set _erl=%errorlevel%
if %_erl%==y goto delete-script-confirmed
if %_erl%==n goto main
goto delete-script

:delete-script-confirmed
set "autostart-delete=Not Defined"
set "path-link-delete=Not defined"

:delete-script-select
cls
title Delete OpenVPN-CLI-Tools
echo Do you want to Delete any Installed Features too?
echo. 
echo             [1] Autstart (%path-link-delete%)
echo.
echo             [2] Add to Path (%autostart-delete%)
echo.
echo             [3] Continue
echo.
choice /C 123 /M Choose which Features to delete by Pressing 1 and/or 2 and 3 to Continue:
set _erl=%errorlevel%
if %_erl%==3 cls & goto delete-script-selected
if %_erl%==2 cls & goto path-include
if %_erl%==1 cls & goto autostart-include

:autostart-include
cls
set "autostart-select-status=Included"
set "autstart-delete=1"
goto delete-script-select

:path-include
cls
set "path-select-status=Included"
set "path-delete=1"
goto delete-script-select


exit /b 0
