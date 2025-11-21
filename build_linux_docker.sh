#!/bin/bash
# Build Linux executable using Docker

echo "========================================="
echo "  Building Linux executable with Docker"
echo "========================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "✗ Docker is not installed!"
    echo "  Please install Docker first: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "✗ Docker is not running!"
    echo "  Please start Docker Desktop"
    exit 1
fi

echo "Building Linux executable..."
echo ""

# Build Docker image and create executable
docker build -f Dockerfile.linux -t h4g-client-builder .

if [ $? -ne 0 ]; then
    echo "✗ Docker build failed!"
    exit 1
fi

# Create container and copy executable
CONTAINER_ID=$(docker create h4g-client-builder)
mkdir -p dist/linux
docker cp $CONTAINER_ID:/app/dist/h4g-client dist/linux/h4g-client-linux
docker rm $CONTAINER_ID

# Make executable
chmod +x dist/linux/h4g-client-linux

if [ -f "dist/linux/h4g-client-linux" ]; then
    echo ""
    echo "✓ Linux build successful!"
    echo "  Location: dist/linux/h4g-client-linux"
    ls -lh dist/linux/h4g-client-linux
else
    echo "✗ Build failed - executable not found"
    exit 1
fi

