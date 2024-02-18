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
echo Test > config.txt
echo Added Config File to: "%USERPROFILE%\Documents\OpenVPN-CLI-Tools\"
echo Moving Script to: "%USERPROFILE%\Documents\OpenVPN-CLI-Tools\"
cd /d %~dp0
xcopy main.bat %USERPROFILE%\Documents\OpenVPN-CLI-Tools\ /q /y
cd /d %USERPROFILE%\Documents\OpenVPN-CLI-Tools\

:: Extracts Data from Config, if avaiable
:config-exists
set /p config=<config.txt
echo %config%
pause

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
@title OpenVPN-CLI-Tool
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

exit /b 0
