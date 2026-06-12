@echo off
setlocal

set "APP_DIR=%~dp0..\.."
for %%I in ("%APP_DIR%") do set "APP_DIR=%%~fI"

set "PID_FILE=%APP_DIR%\runtime\spaghettichef-angular.pid"

if not exist "%PID_FILE%" (
  echo SpaghettiChef Angular server is not running.
  exit /b 0
)

for /f "usebackq delims=" %%P in ("%PID_FILE%") do set "SERVER_PID=%%P"

if not defined SERVER_PID (
  del "%PID_FILE%" >nul 2>nul
  echo Removed empty server pid file.
  exit /b 0
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$process = Get-Process -Id %SERVER_PID% -ErrorAction SilentlyContinue; if (-not $process) { exit 2 }; $command = (Get-CimInstance Win32_Process -Filter 'ProcessId = %SERVER_PID%').CommandLine; if ($command -notlike '*static-server.ps1*') { exit 3 }; Stop-Process -Id %SERVER_PID% -Force"

if errorlevel 3 (
  echo Refusing to stop process %SERVER_PID% because it is not the SpaghettiChef Angular server.
  exit /b 1
)

if errorlevel 2 (
  del "%PID_FILE%" >nul 2>nul
  echo SpaghettiChef Angular server was not running.
  exit /b 0
)

del "%PID_FILE%" >nul 2>nul
echo SpaghettiChef Angular server stopped.
exit /b 0
