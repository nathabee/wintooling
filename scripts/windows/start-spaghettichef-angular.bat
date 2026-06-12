@echo off
setlocal

set "APP_DIR=%~dp0..\.."
for %%I in ("%APP_DIR%") do set "APP_DIR=%%~fI"

set "PORT=4200"
set "URL=http://127.0.0.1:%PORT%/"
set "PUBLIC_DIR=%APP_DIR%\public"
set "RUNTIME_DIR=%APP_DIR%\runtime"
set "PID_FILE=%RUNTIME_DIR%\spaghettichef-angular.pid"
set "SERVER_SCRIPT=%RUNTIME_DIR%\windows\static-server.ps1"

if not exist "%PUBLIC_DIR%\index.html" (
  echo Missing Angular production files: %PUBLIC_DIR%
  exit /b 1
)

if not exist "%SERVER_SCRIPT%" (
  echo Missing runtime server: %SERVER_SCRIPT%
  exit /b 1
)

if exist "%PID_FILE%" (
  for /f "usebackq delims=" %%P in ("%PID_FILE%") do set "SERVER_PID=%%P"
  if defined SERVER_PID (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "if (Get-Process -Id %SERVER_PID% -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }" >nul 2>nul
    if not errorlevel 1 (
      start "" "%URL%"
      exit /b 0
    )
  )
)

start "SpaghettiChef Angular Server" /min powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SERVER_SCRIPT%" -Root "%PUBLIC_DIR%" -Port %PORT% -PidFile "%PID_FILE%"
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Start-Sleep -Seconds 2" >nul 2>nul
start "" "%URL%"

exit /b 0
