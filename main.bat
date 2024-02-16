:: Use only under MIT License
:: If you want to Publish a modified Version please mention the Original Creator PIRANY and link the GitHub Repo

:: Some Startup Stuff (yk)
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

:: Presets some Variables when used in call
set "elevated="
set "exitcode="
set "gitver12=v0"
goto main

:: Checks if the Script is elevated when called
:checkelev
net session >nul 2>&1
if %errorLevel% == 0 ( set "elevated=1" )
goto :EOF

:: Main Part
:main
set "startupendtime=%time%"
set /a res= %startupendtime% - %scriptstart% 
@title OpenVPN-CLI-Tool
echo             [1] Info
echo.         
echo             [2] Add to Path
echo.            
echo             [3] Autostart
echo.            
echo             [4]
echo.            
echo             [5] Check for Updates
echo.            
echo             [6] Exit

exit /b 0
