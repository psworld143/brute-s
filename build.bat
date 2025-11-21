@echo off
REM Build script for Windows

echo Building brute for Windows...

REM Check if PyInstaller is installed
pip show pyinstaller >nul 2>&1
if errorlevel 1 (
    echo PyInstaller not found. Installing...
    pip install pyinstaller
)

REM Clean previous builds
echo Cleaning previous builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist __pycache__ rmdir /s /q __pycache__
if exist *.spec del /q *.spec

REM Build the executable
echo Building executable...
pyinstaller --onefile --name brute --console client.py

REM Check if build was successful
if exist "dist\brute.exe" (
    echo.
    echo Build successful!
    echo Executable location: dist\brute.exe
) else (
    echo Build failed!
    exit /b 1
)

pause

