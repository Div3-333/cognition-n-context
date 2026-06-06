@echo off
title Drishti - Start System
echo ==========================================
echo   DRISHTI: Linguistic Analysis System
echo ==========================================
echo.

:: CHECK FOR PREREQUISITES
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not in PATH.
    pause
    exit
)
where npm >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Node.js/NPM is not installed or not in PATH.
    pause
    exit
)

:: AUTO-SETUP DETECTION
if not exist "backend\venv" goto setup_needed
if not exist "frontend\node_modules" goto setup_needed
goto menu

:setup_needed
echo [DETECTED] This looks like a fresh install. 
echo Initial setup is required (this may take a few minutes).
echo.
set /p start_setup="Start setup now? (y/n): "
if /i "%start_setup%"=="y" goto setup_all
echo Setup cancelled. The app may not run.
pause
goto menu

:setup_all
echo.
echo [1/2] Setting up Backend Virtual Environment...
cd backend
python -m venv venv
call venv\Scripts\activate
call pip install -r requirements.txt
cd ..

echo.
echo [2/2] Installing Frontend Dependencies...
cd frontend
call npm.cmd install
cd ..
echo.
echo ==========================================
echo SETUP COMPLETE!
echo ==========================================
echo.
goto menu

:menu
echo 1) Start normally
echo 2) Clean Start (Fixes Cloud/Cache errors)
echo 3) Run Setup/Repair (Reinstalls everything)
echo 4) Exit
echo.
set /p choice="Choose an option (1-4): "

if "%choice%"=="1" goto start
if "%choice%"=="2" goto clean
if "%choice%"=="3" goto setup_all
if "%choice%"=="4" exit
goto menu

:clean
echo.
echo [Cleaning] Removing corrupted cache...
if exist "frontend\.next" rd /s /q "frontend\.next"
echo [Cleaning] Refreshing frontend dependencies...
cd frontend && call npm.cmd install && cd ..
echo.
echo [Clean Complete] Starting system now...
goto start

:start
echo.
echo [1/2] Starting Backend (FastAPI)...
start "Drishti Backend" cmd /k "cd backend && venv\Scripts\activate && python main.py || pause"

echo [2/2] Starting Frontend (Next.js)...
start "Drishti Frontend" cmd /k "cd frontend && call npm.cmd run dev || pause"

echo.
echo ------------------------------------------
echo System is initializing...
echo Backend:  http://127.0.0.1:8000
echo Frontend: http://127.0.0.1:3000
echo ------------------------------------------
echo.
echo You can close this window. The app windows will stay open.
timeout /t 5
