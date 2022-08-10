@echo off

set BALPOS=windows
set ICONDIST=resources\icons

:argumentLoop
IF NOT "%1"=="" (
    IF "%1"=="--dist" (
        SET DIST=%2
        SHIFT
    )
    IF "%1"=="--version" (
        SET BALLERINA_VERSION=%2
        SHIFT
    )
	IF "%1"=="--path" (
        SET DISTLOC=%2
        SHIFT
    )
	SHIFT
	goto argumentLoop
)


IF "%DIST%"==""  (
	set DIST=all
)

IF "%DISTLOC%"==""  (
	set DISTLOC=resources\dist
)

IF NOT "%DIST%"=="all" IF NOT "%DIST%"=="ballerina" IF NOT "%DIST%"=="ballerina-runtime" (
	echo The syntax of the command is incorrect. Possible arguments for dist - all, ballerina, ballerina-runtime.
	echo Ex: --dist ballerina
	goto EOF
)

IF "%BALLERINA_VERSION%"==""  (
	echo The syntax of the command is incorrect. Missing argument version.
	goto EOF
)

for /f %%x in ('wmic path win32_utctime get /format:list ^| findstr "="') do set %%x
set UTC_TIME=%Year%-%Month%-%Day% %Hour%:%Minute%:%Second% UTC

rmdir ballerina-%BALLERINA_VERSION%-windows /s /q >nul 2>&1
rmdir target /s /q >nul 2>&1

for /f %%i in ('guid') do set UPGRADECODE=%%i
echo Upgrade Code - %UPGRADECODE%

IF "%DIST%"=="all" (
	call :createballerinaWin64Installer
) ELSE (
	call :create%DIST%Win64Installer
)

goto EOF


:createballerinaWin64Installer
set BALZIP=%DISTLOC%\ballerina-%BALLERINA_VERSION%-windows.zip
set BALDIST=ballerina-%BALLERINA_VERSION%-windows
set BALPARCH=x64
set INSTALLERPARCH=amd64
set MSI=ballerina-%BALLERINA_VERSION%-%BALPOS%-%BALPARCH%.msi
set INSTALLERNAME="Ballerina %BALLERINA_VERSION%"
call :createInstaller
goto EOF

:createballerinaWin586Installer
set BALZIP=%DISTLOC%\ballerina-%BALLERINA_VERSION%-windows.zip
set BALDIST=ballerina-%BALLERINA_VERSION%-windows
set BALPARCH=i586
set INSTALLERPARCH=386
set MSI=ballerina-%BALLERINA_VERSION%-%BALPOS%-%BALPARCH%.msi
set INSTALLERNAME="Ballerina %BALLERINA_VERSION%"
call :createInstaller
goto EOF

:createInstaller
rmdir target\installer-resources /s /q >nul 2>&1
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('%BALZIP%', '.'); }"
xcopy  %ICONDIST% %BALDIST%\icons /e /i >nul 2>&1

echo %BALDIST% build started at '%UTC_TIME%' for %BALPOS% %BALPARCH%

echo Creating the Installer...

heat dir %BALDIST% -nologo -v -gg -g1 -srd -sfrag -sreg -cg AppFiles -template fragment -dr INSTALLDIR -var var.SourceDir -out target\installer-resources\AppFiles.wxs
candle -nologo -sw -dinstallerName=%INSTALLERNAME% -dbalVersion=%BALLERINA_VERSION% -dWixbalVersion=1.0.0 -dUpgradeCode=%UPGRADECODE% -dArch=%INSTALLERPARCH% -dSourceDir=%BALDIST% -out target\installer-resources\ -ext WixUtilExtension resources\installer.wxs target\installer-resources\AppFiles.wxs
light -nologo -dcl:high -sw -ext WixUIExtension -ext WixUtilExtension -loc resources\en-us.wxl target\installer-resources\AppFiles.wixobj target\installer-resources\installer.wixobj -o target\msi\%MSI%

rmdir ballerina-%BALLERINA_VERSION%-windows /s /q >nul 2>&1

echo %BALDIST% build completed at '%UTC_TIME%' for %BALPOS% %BALPARCH%

echo.
goto EOF

:EOF
