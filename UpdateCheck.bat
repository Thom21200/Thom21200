@echo off

REM Switch to utf-8 encoding
chcp 65001 > nul

REM Get current location
set Ulocation=%cd%
cd ..
set Llocation=%cd%
set Mlocation=%Llocation%\game\mods
set Jlocation=%Llocation%\jre

echo [DEBUG] Updater location: %Ulocation%
echo [DEBUG] Launcher location: %Llocation%
echo [DEBUG] Mods location: %Mlocation%

:JreCheck
REM Check JRE
echo [INFO] Checking Java Runtime Environment ^(JRE^)...
cd %Llocation%
if exist jre\ (
    echo [INFO] Found jre
    goto :GetVersion
) else (
    echo [INFO] No jre found
    goto :InstallJre
)

:InstallJre
REM Downloading 3 jre archive files

mkdir jre
cd %Jlocation%

echo [INFO] Downloading Jre... ^(1/3^)
curl -o jre-1.zip https://raw.githubusercontent.com/tt-thoma/tt-thoma/mcmodpack/jre/jre-1.zip -#
if not %ERRORLEVEL%==0 (
    del /F /Q jre-1.zip
    echo [ERROR] Failed to contact server ^(Error code: %ERRORLEVEL%^).
    echo -- Press any key to continue --
    pause > nul
    goto :END
)
echo [INFO] Downloading Jre... ^(2/3^)
curl -o jre-2.zip https://raw.githubusercontent.com/tt-thoma/tt-thoma/mcmodpack/jre/jre-2.zip -#
if not %ERRORLEVEL%==0 (
    del /F /Q jre-1.zip
    del /F /Q jre-2.zip
    echo [ERROR] Failed to contact server ^(Error code: %ERRORLEVEL%^).
    echo -- Press any key to continue --
    pause > nul
    goto :END
)
echo [INFO] Downloading Jre... ^(3/3^)
curl -o jre-3.zip https://raw.githubusercontent.com/tt-thoma/tt-thoma/mcmodpack/jre/jre-3.zip -#
if not %ERRORLEVEL%==0 (
    del /F /Q jre-1.zip
    del /F /Q jre-2.zip
    del /F /Q jre-3.zip
    echo [ERROR] Failed to contact server ^(Error code: %ERRORLEVEL%^).
    echo -- Press any key to continue --
    pause > nul
    goto :END
)

REM Extract 3 files
echo [INFO] Extracting files... ^(1/3^)
tar -xf jre-1.zip
echo [INFO] Extracting files... ^(2/3^)
tar -xf jre-2.zip
echo [INFO] Extracting files... ^(3/3^)
tar -xf jre-3.zip

REM Remove files
echo [INFO] Cleaning files...
del /F /Q jre-1.zip
del /F /Q jre-2.zip
del /F /Q jre-3.zip


:GetVersion
REM Download current version file
cd %Ulocation%
echo [INFO] Contacting GitHub server...
curl -o server-version.txt https://raw.githubusercontent.com/tt-thoma/tt-thoma/mcmodpack/version.txt -s

REM Check status
if %ERRORLEVEL%==0 (
    echo [INFO] Success!
) else (
    echo [ERROR] Failed to contact server ^(Error code: %ERRORLEVEL%^).
    echo [WARN] /!\ Modpack might be out-to-date
    echo -- Press any key to continue --
    pause > nul
    goto :Launch
)

REM Obtaining version infos
echo [INFO] Checking versions...

if not exist version.txt (
    echo [WARN] There was an update error on last execution
    echo None> version.txt
)

REM Remove spaces
set /p cver=< version.txt
set cver=%cver: =%
set /p sver=< server-version.txt
set sver=%sver: =%

REM Delete server version as we no longer need it
del /F /Q server-version.txt

REM Check versions
if "%cver%"=="%sver%" (
    echo [INFO] Modpack is up to date.
    goto :Launch
) else (
    echo [INFO] Version needs an update! ^(%cver% -^> %sver%^)
    goto :Update
)


:Update
REM Remove version to inform of update
del /F /Q version.txt

REM Check folders
cd %Llocation%

if not exist game\ ( mkdir game )
cd game
if exist mods\ (
    rmdir /S /Q mods
)
mkdir mods
cd mods

REM Download modpack
echo [INFO] Downloading modpack...
curl -o modpack.zip https://media.githubusercontent.com/media/tt-thoma/tt-thoma/mcmodpack/modpack.zip -#

REM Check status

if %ERRORLEVEL%==0 (
    echo [INFO] Done!
) else (
    del /F /Q modpack.zip
    echo [ERROR] Failed to contact server ^(Error code: %ERRORLEVEL%^).
    echo -- Press any key to continue --
    pause > nul
    goto :Launch
)

REM Extract modpack
echo [INFO] Extracting modpack...
tar -xf modpack.zip
echo [INFO] Done!

cd %Ulocation%
echo %sver%> version.txt

:Launch
REM Start TL legacy

echo [INFO] Starting launcher...
cd %Llocation%

if exist TL.exe (
    start TL.exe
) else (
    echo [ERROR] Could not find TL launcher
)

:END
pause
