@echo off
title Drishti - Shutdown System
echo ==========================================
echo   DRISHTI: Closing System Safely
echo ==========================================
echo.

echo Data is automatically saved to the database.
echo.

echo Stopping Backend (Port 8000)...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :8000 ^| findstr LISTENING') do (
    taskkill /f /pid %%a >nul 2>&1
)

echo Stopping Frontend (Port 3000)...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :3000 ^| findstr LISTENING') do (
    taskkill /f /pid %%a >nul 2>&1
)

echo.
echo ------------------------------------------
echo Shutdown Complete. All sessions saved to DB.
echo ------------------------------------------
echo.
pause
