#!/bin/bash
# Build script for macOS and Linux

echo "Building brute for $(uname -s)..."

# Check if PyInstaller is installed
if ! command -v pyinstaller &> /dev/null; then
    echo "PyInstaller not found. Installing..."
    pip3 install pyinstaller
fi

# Clean previous builds
echo "Cleaning previous builds..."
rm -rf build dist __pycache__ *.spec

# Build the executable
echo "Building executable..."
pyinstaller --onefile --name brute --console client.py

# Check if build was successful
if [ -f "dist/brute" ] || [ -f "dist/brute.exe" ]; then
    echo ""
    echo "✓ Build successful!"
    echo "Executable location: dist/brute"
    if [ -f "dist/brute.exe" ]; then
        echo "Executable location: dist/brute.exe"
    fi
else
    echo "✗ Build failed!"
    exit 1
fi

