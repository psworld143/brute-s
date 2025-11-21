# Setting Up GitHub Repository

## Quick Setup Commands

```bash
# 1. Add all files
git add .

# 2. Commit
git commit -m "Initial commit: h4g-client with cross-platform builds"

# 3. Push to GitHub
git branch -M main
git push -u origin main
```

## After Pushing

Once you push to GitHub, the GitHub Actions workflow will automatically:
- Build for macOS
- Build for Linux  
- Build for Windows

You can download the executables from:
**GitHub → Actions → Latest workflow run → Artifacts**

## Files Included

- `client.py` - Python client application
- `api.php` - PHP REST API (for reference)
- `database.sql` - Database schema
- `requirements.txt` - Python dependencies
- `build.sh` - macOS/Linux build script
- `build.bat` - Windows build script
- `.github/workflows/build-all-platforms.yml` - Auto-build workflow
- `Dockerfile.linux` - Docker build for Linux
- `README.md` - Project documentation

## GitHub Actions

The repository includes automated builds via GitHub Actions. Every push will:
1. Build macOS executable
2. Build Linux executable
3. Build Windows executable
4. Create downloadable artifacts

No manual building needed for other platforms!

