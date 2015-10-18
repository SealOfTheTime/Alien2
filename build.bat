@echo off
color 0a

:: Check if we already have the tools in the environment
if exist "%VCINSTALLDIR%" (
    goto compile
)


:: Check for Visual Studio
if exist "%VS100COMNTOOLS%" (
    set VSPATH="%VS100COMNTOOLS%"
    goto set_env
)
if exist "%VS140COMNTOOLS%" (
    set VSPATH="%VS140COMNTOOLS%"
    goto set_env
)
if exist "%VS90COMNTOOLS%" (
    set VSPATH="%VS90COMNTOOLS%"
    goto set_env
)
if exist "%VS80COMNTOOLS%" (
    set VSPATH="%VS80COMNTOOLS%"
    goto set_env
)

echo You need Microsoft Visual Studio 8, 9 or 10 installed
pause
exit

:: Setup the environment
:set_env
call %VSPATH%vsvars32.bat
ping -n 1 localhost >nul

::Check for bam
if exist "../bam-0.4.0/bam.exe" (
    set BAM="../bam-0.4.0/bam.exe"
    goto setbampar
)
if exist "../bam/bam.exe" (
    set BAM="../bam/bam.exe"
    goto compile
)
if exist "bam.exe" (
    set BAM="bam.exe"
    goto compile
)
if exist "../bam/src/bam.exe" (
    set BAM="../bam/src/bam.exe"
    goto compile
)
if exist "../bam-0.2.0/src/bam.exe" (
    set BAM="../bam-0.2.0/src/bam.exe"
    goto compile
) else goto nobam
pause

:nobam
cls
echo.
echo [ERROR]No bam found!
echo.
pause >nul
exit

:: Compile
:compile
@echo === Building Teeworlds Server===
@call %BAM% server_release -j 4 
@echo === Finished ===
echo.

:: Ending/Or not :D
echo Press any Key to Compile again...
pause >nul
color 0c
echo === Again :D ===
ping -n 2 localhost >nul
color 0a
cls
goto compile
exit