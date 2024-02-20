
CALL %0\..\main.bat

:: checks for updates in a non existent settings textfile :/
:under-construction
echo Checking for Data...
setlocal enabledelayedexpansion
set "batchfile=settings.txt"
set "linenumber=4"
set "searchtext=uy"

for /f "tokens=1* delims=:" %%a in ('findstr /n "^" "%batchfile%"') do (
    if %%a equ %linenumber% (
        set "line=%%b"
        set "line=!line:*:=!"
        if "!line!" equ "%searchtext%" (
            goto gitvercheck
        ) else (
            goto ulttop
        )
    )
)

:gitvercheck
set "api_url=https://api.github.com/repos/PIRANY1/openvpn-cli-tools/releases/latest"
echo Fetching Git Url....
@ping -n 1 localhost> nul
echo Calling Github API...
for /f "usebackq tokens=*" %%i in (`curl -s %api_url% ^| jq -r ".tag_name"`) do (set "latest_version=%%i")
echo Version:%latest_version%
if %latest_version% equ v2.6 (goto UpToDate) else (goto gitverout)

:UpToDate
@ping -n 1 localhost> nul
echo The Version you are currently Using is the newest one (%latest_version%)
goto ulttop


:gitverout
echo.
@ping -n 1 localhost> nul
echo Version Outdated!
@ping -n 1 localhost> nul
echo.
@ping -n 1 localhost> nul
echo Please consider downloading the new Version. 
@ping -n 1 localhost> nul
echo The Version you are currently using is %gitver12%
@ping -n 1 localhost> nul 
echo The newest Version avaiable is %latest_version%
@ping -n 1 localhost> nul
echo.
echo [1] Update
@ping -n 1 localhost> nul
echo.
@ping -n 1 localhost> nul
echo [2] Continue Anyways
@ping -n 1 localhost> nul
echo.
@ping -n 1 localhost> nul
set /p menu4=Choose an Option from Above:
If %menu4% == 1 goto gitupt
If %menu4% == 2 goto ulttop
goto gitverout

:gitupt
set gitverold=%gitver12%
cd %~dp0
set "source_dir_start=%cd%"
cd ..
mkdir %latest_version%
cd %latest_version%
git clone https://github.com/PIRANY1/DataSpammer %cd%
echo Downloaded
set "setupaftgitcl=1"
main.bat



echo "Enter a menu option in the Keyboard [1,2,3,4,5,6,7,8,0] :"
choice /C:123456780 /N
set _erl=%errorlevel%
if %_erl%==9 exit /b
if %_erl%==8 cls | goto 
if %_erl%==7 cls | goto 
if %_erl%==6 cls | goto 
if %_erl%==5 cls | goto 
if %_erl%==4 cls | goto 
if %_erl%==3 cls | goto 
if %_erl%==2 cls | goto 
if %_erl%==1 cls | goto 
goto :MainMenu

setlocal & call :_Check_Status_wmi & cls & endlocal & goto :MainMenu