@echo off
chcp 65001 >nul
title PavThean StreamAlert
color 0A

echo.
echo  ________  ________  ___      ___ ________  ___  ___  _______   ________  ________
echo ^|\   __  \^|\   __  \^|\  \    /  /^|\__    _\^|\  \^|\  \^|\  ___ \ ^|\   __  \^|\   ___  \
echo \ \  \^|\  \ \  \^|\  \ \  \  /  / \^|___ \  \_\ \  \\\\  \ \   __/^|\ \  \^|\  \ \  \\\ \  \
echo  \ \   ____\ \   __  \ \  \/  / /     \ \  \ \ \   __  \ \  \_^|/_\ \   __  \ \  \\\ \  \
echo   \ \  \_^|__\ \  \ \  \ \    / /       \ \  \ \ \  \ \  \ \  \_^|\ \ \  \ \  \ \  \\\ \  \
echo    \ \__\    \ \__\ \__\ \__/ /         \ \__\ \ \__\ \__\ \_______\ \__\ \__\ \__\\\ \__\
echo     \^|__^|     \^|__^|\^|__\^|__^|/           \^|__^|  \^|__^|\^|__\^|_______\^|__^|\^|__\^|__^| \^|__^|
echo.
echo  ================================================================
echo     ABA Donation Stream Alert  ^|  Powered by PAV THEAN
echo  ================================================================
echo.

:: Check Node.js
node -v >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] Node.js not found!
    echo  Please install from: https://nodejs.org
    echo.
    pause
    exit /b 1
)

:: Check if already configured
if exist telegram.config.json (
    echo  [INFO] Config found. Skipping setup.
    goto :run
)

echo  Fill in the details below to get started.
echo  ----------------------------------------------------------------
echo.

:: LICENSE KEY
:askLicense
set /p LICENSE_KEY= Enter your License Key (PT-...): 
if "%LICENSE_KEY%"=="" (
    echo  [ERROR] License key cannot be empty.
    goto :askLicense
)

echo.
echo  Validating license key...

set MACHINE_ID=%COMPUTERNAME%_%USERNAME%

powershell -Command "$body = '{\"licenseKey\":\"%LICENSE_KEY%\",\"machineId\":\"%MACHINE_ID%\"}'; try { $r = Invoke-RestMethod -Uri 'https://pt-license-production.up.railway.app/api/validate' -Method POST -ContentType 'application/json' -Body $body; if ($r.valid) { Write-Host '  [OK] License valid. Welcome, ' + $r.owner } else { Write-Host '  [FAIL] ' + $r.reason; exit 1 } } catch { Write-Host '  [ERROR] Cannot reach license server.'; exit 1 }"

if errorlevel 1 (
    echo.
    echo  Please check your license key and try again.
    echo.
    goto :askLicense
)

echo.
echo  ----------------------------------------------------------------
echo  Telegram API Setup
echo  Get credentials from: https://my.telegram.org/apps
echo  ----------------------------------------------------------------
echo.

:askApiId
set /p TG_API_ID= Enter api_id (numbers only): 
if "%TG_API_ID%"=="" goto :askApiId
echo %TG_API_ID%| findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 (
    echo  [ERROR] api_id must be numbers only.
    goto :askApiId
)

:askApiHash
set /p TG_API_HASH= Enter api_hash: 
if "%TG_API_HASH%"=="" goto :askApiHash

echo.
echo  Saving config...

powershell -Command "$cfg = @{ apiId = %TG_API_ID%; apiHash = '%TG_API_HASH%'; session = '' }; $cfg | ConvertTo-Json | Set-Content -Encoding UTF8 'telegram.config.json'"

:: Save license key file
echo %LICENSE_KEY%> license.key

if errorlevel 1 (
    echo  [ERROR] Failed to save config.
    pause
    exit /b 1
)

echo  [OK] Config saved!
echo.

:: Install dependencies if needed
if not exist node_modules (
    echo  Installing dependencies (first time only)...
    call npm install
    if errorlevel 1 (
        echo  [ERROR] npm install failed.
        pause
        exit /b 1
    )
)

echo.
echo  ================================================================
echo     Setup complete! Starting...
echo  ================================================================
echo.

:run
call npm run start
pause