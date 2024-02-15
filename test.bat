@setlocal enableextensions ENABLEDELAYEDEXPANSION 
@if not defined debug_assist (@ECHO OFF) else (@echo on)
rem Checks if the Script is started by a debug Script
if not defined devtools (goto nodev) else (goto dtd)
rem Presets the Elevated Variable when called with call
set "elevated=0"

:checkelev
rem Checks if the Script is elevated when called
net session >nul 2>&1
if %errorLevel% == 0 ( set "elevated=1" )
goto :EOF

:nodev
call :checkelev
echo %elevated%
pause
