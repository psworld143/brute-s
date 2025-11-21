#!/bin/bash
# Build script for all platforms (macOS, Linux, Windows)
# Note: Each platform must be built on that specific platform

PLATFORM=$(uname -s)

echo "========================================="
echo "  brute Multi-Platform Build"
echo "========================================="
echo "Current platform: $PLATFORM"
echo ""

case "$PLATFORM" in
    Darwin)
        echo "Building for macOS..."
        ./build.sh
        if [ -f "dist/brute" ]; then
            mkdir -p dist/macos
            cp dist/brute dist/macos/brute-macos
            echo ""
            echo "✓ macOS build complete!"
            echo "  Location: dist/macos/brute-macos"
        fi
        ;;
    Linux)
        echo "Building for Linux..."
        ./build.sh
        if [ -f "dist/brute" ]; then
            mkdir -p dist/linux
            cp dist/brute dist/linux/brute-linux
            echo ""
            echo "✓ Linux build complete!"
            echo "  Location: dist/linux/brute-linux"
        fi
        ;;
    *)
        echo "Unknown platform: $PLATFORM"
        echo "Please run this script on macOS or Linux"
        exit 1
        ;;
esac

echo ""
echo "========================================="
echo "  Build Summary"
echo "========================================="
echo "To build for other platforms:"
echo "  - macOS: Run on macOS system"
echo "  - Linux: Run on Linux system"
echo "  - Windows: Run build.bat on Windows system"
echo ""

