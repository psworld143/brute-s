#!/bin/bash
# Script to push code to GitHub and trigger automated builds

echo "========================================="
echo "  Pushing to GitHub Repository"
echo "========================================="
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "✗ Git repository not initialized!"
    exit 1
fi

# Add all files
echo "Adding files..."
git add .

# Check if there are changes
if git diff --staged --quiet; then
    echo "No changes to commit."
    exit 0
fi

# Commit
echo "Committing changes..."
git commit -m "Initial commit: h4g-client with cross-platform builds and GitHub Actions"

# Set main branch
echo "Setting main branch..."
git branch -M main

# Push to GitHub
echo ""
echo "Pushing to GitHub..."
echo "Repository: https://github.com/psworld143/brute-s.git"
echo ""
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "========================================="
    echo "  ✓ Successfully pushed to GitHub!"
    echo "========================================="
    echo ""
    echo "GitHub Actions will now automatically build for:"
    echo "  - macOS"
    echo "  - Linux"
    echo "  - Windows"
    echo ""
    echo "To download executables:"
    echo "  1. Go to: https://github.com/psworld143/brute-s/actions"
    echo "  2. Click on the latest workflow run"
    echo "  3. Download artifacts from the bottom"
    echo ""
else
    echo ""
    echo "✗ Push failed. Please check your GitHub credentials."
    echo "  You may need to authenticate:"
    echo "  - Use GitHub CLI: gh auth login"
    echo "  - Or use SSH keys"
    echo "  - Or use personal access token"
    exit 1
fi

