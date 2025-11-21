#!/bin/bash
# Cross-platform build script
# This script helps build for different platforms

PLATFORM=${1:-current}

echo "========================================="
echo "  h4g-client Build Script"
echo "========================================="
echo ""

case $PLATFORM in
    macos|mac|osx)
        echo "Building for macOS..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            ./build.sh
        else
            echo "Error: Cannot build macOS executable on non-macOS system"
            echo "Please run this script on a macOS system"
            exit 1
        fi
        ;;
    linux)
        echo "Building for Linux..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            ./build.sh
        else
            echo "Error: Cannot build Linux executable on non-Linux system"
            echo "Please run this script on a Linux system"
            exit 1
        fi
        ;;
    windows|win)
        echo "Building for Windows..."
        if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
            ./build.bat
        else
            echo "Error: Cannot build Windows executable on non-Windows system"
            echo "Please run build.bat on a Windows system"
            exit 1
        fi
        ;;
    current|*)
        echo "Building for current platform: $(uname -s)"
        ./build.sh
        ;;
esac

echo ""
echo "Build complete!"

