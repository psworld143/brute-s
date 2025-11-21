#!/bin/bash
# Build script for macOS and Linux

echo "Building h4g-client for $(uname -s)..."

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
pyinstaller --onefile --name h4g-client --console client.py

# Check if build was successful
if [ -f "dist/h4g-client" ] || [ -f "dist/h4g-client.exe" ]; then
    echo ""
    echo "✓ Build successful!"
    echo "Executable location: dist/h4g-client"
    if [ -f "dist/h4g-client.exe" ]; then
        echo "Executable location: dist/h4g-client.exe"
    fi
else
    echo "✗ Build failed!"
    exit 1
fi

