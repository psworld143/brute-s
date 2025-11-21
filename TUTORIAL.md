# h4g-client Tutorial

Complete guide on how to use h4g-client and set it up for global terminal access.

## Table of Contents

1. [Quick Start](#quick-start)
2. [Installation](#installation)
3. [Basic Usage](#basic-usage)
4. [Advanced Usage](#advanced-usage)
5. [Global Terminal Access](#global-terminal-access)
6. [Troubleshooting](#troubleshooting)

---

## Quick Start

### Download Executable

Download the executable for your platform from [GitHub Releases](https://github.com/psworld143/brute-s/releases) or build it yourself.

### Run Commands

**Save data:**
```bash
h4g-client -e keyword flag
```

**Display all flags:**
```bash
h4g-client -d
```

**Search by keyword:**
```bash
h4g-client -d keyword
```

---

## Installation

### Option 1: Using Pre-built Executable

1. Download the executable for your platform
2. Make it executable (Linux/macOS): `chmod +x h4g-client`
3. Run it directly: `./h4g-client -d`

### Option 2: Using Python Script

1. Install Python 3.7 or higher
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Run the script:
   ```bash
   python3 client.py -e keyword flag
   ```

### Option 3: Build from Source

**macOS/Linux:**
```bash
./build.sh
```

**Windows:**
```cmd
build.bat
```

---

## Basic Usage

### Save Data

Save a keyword and flag pair to the database:

```bash
h4g-client -e python programming
h4g-client -e "web development" active
h4g-client -e database mysql
```

**Notes:**
- Use quotes for keywords/flags with spaces
- Empty keyword or flag will be rejected
- Duplicate exact matches (same keyword + same flag) are prevented

### Display All Flags

View all flags in the database:

```bash
h4g-client -d
```

**Output:** One flag per line, no formatting

### Search by Keyword

Search for flags by keyword (exact match takes priority):

```bash
# Exact match - shows only flags for exact keyword "python"
h4g-client -d python

# Partial match - shows flags from keywords containing "web"
h4g-client -d web
```

**Search Behavior:**
- **Exact match**: If keyword exists exactly, shows only that keyword's flags
- **Partial match**: If no exact match, shows flags from keywords containing the search term

---

## Advanced Usage

### Examples

**Save multiple flags for same keyword:**
```bash
h4g-client -e language python
h4g-client -e language java
h4g-client -e language javascript
```

**Search for all flags:**
```bash
h4g-client -d
# Output:
# python
# java
# javascript
```

**Search for specific keyword:**
```bash
h4g-client -d language
# Output:
# python
# java
# javascript
```

**Partial search:**
```bash
h4g-client -d lang
# Output: (if "language" exists, shows its flags)
# python
# java
# javascript
```

### Encryption

All data is encrypted with AES-256-CBC using key "ndmu2025":
- Keywords are encrypted before storage
- Flags are encrypted before storage
- Data is decrypted when retrieved
- Encryption is transparent to the user

---

## Global Terminal Access

Make h4g-client available from anywhere in your terminal.

### macOS

#### Method 1: Add to PATH (Recommended)

1. **Copy executable to a system directory:**
   ```bash
   sudo cp dist/h4g-client /usr/local/bin/h4g-client
   sudo chmod +x /usr/local/bin/h4g-client
   ```

2. **Verify it works:**
   ```bash
   h4g-client -d
   ```

#### Method 2: Create Symbolic Link

1. **Create a bin directory in your home folder:**
   ```bash
   mkdir -p ~/bin
   cp dist/h4g-client ~/bin/h4g-client
   chmod +x ~/bin/h4g-client
   ```

2. **Add to PATH in ~/.zshrc (or ~/.bash_profile for bash):**
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

3. **Verify:**
   ```bash
   h4g-client -d
   ```

#### Method 3: Using Homebrew (Advanced)

Create a custom Homebrew formula (for advanced users).

### Linux

#### Method 1: System-wide Installation

1. **Copy to /usr/local/bin:**
   ```bash
   sudo cp dist/h4g-client /usr/local/bin/h4g-client
   sudo chmod +x /usr/local/bin/h4g-client
   ```

2. **Verify:**
   ```bash
   h4g-client -d
   ```

#### Method 2: User Installation

1. **Create ~/bin directory:**
   ```bash
   mkdir -p ~/bin
   cp dist/h4g-client ~/bin/h4g-client
   chmod +x ~/bin/h4g-client
   ```

2. **Add to PATH in ~/.bashrc (or ~/.zshrc):**
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

3. **Verify:**
   ```bash
   h4g-client -d
   ```

### Windows

#### Method 1: Add to System PATH

1. **Copy executable to a permanent location:**
   - Create folder: `C:\Program Files\h4g-client\`
   - Copy `h4g-client.exe` to that folder

2. **Add to PATH:**
   - Press `Win + R`, type `sysdm.cpl`, press Enter
   - Go to "Advanced" tab → "Environment Variables"
   - Under "System Variables", find "Path" → "Edit"
   - Click "New" → Add: `C:\Program Files\h4g-client`
   - Click "OK" on all windows

3. **Restart Command Prompt/PowerShell**

4. **Verify:**
   ```cmd
   h4g-client.exe -d
   ```

#### Method 2: User PATH (No Admin Required)

1. **Create folder in your user directory:**
   ```cmd
   mkdir %USERPROFILE%\bin
   copy h4g-client.exe %USERPROFILE%\bin\h4g-client.exe
   ```

2. **Add to User PATH:**
   - Press `Win + R`, type `sysdm.cpl`, press Enter
   - Go to "Advanced" tab → "Environment Variables"
   - Under "User Variables", find "Path" → "Edit"
   - Click "New" → Add: `%USERPROFILE%\bin`
   - Click "OK" on all windows

3. **Restart Command Prompt/PowerShell**

4. **Verify:**
   ```cmd
   h4g-client.exe -d
   ```

#### Method 3: PowerShell Profile (Alternative)

1. **Add alias to PowerShell profile:**
   ```powershell
   # Find profile location
   $PROFILE
   
   # Edit profile (if exists) or create new
   notepad $PROFILE
   
   # Add this line (adjust path):
   Set-Alias h4g "C:\path\to\h4g-client.exe"
   ```

2. **Reload PowerShell:**
   ```powershell
   . $PROFILE
   ```

3. **Use:**
   ```powershell
   h4g -d
   ```

---

## Verification

After setting up global access, test from any directory:

### macOS/Linux
```bash
cd ~
h4g-client -d

cd /tmp
h4g-client -e test flag
h4g-client -d test
```

### Windows
```cmd
cd %USERPROFILE%
h4g-client.exe -d

cd C:\Temp
h4g-client.exe -e test flag
h4g-client.exe -d test
```

---

## Troubleshooting

### "Command not found"

**macOS/Linux:**
- Check if executable is in PATH: `echo $PATH`
- Verify executable exists: `which h4g-client`
- Re-source your shell config: `source ~/.zshrc` or `source ~/.bashrc`

**Windows:**
- Check PATH: `echo %PATH%`
- Verify executable: `where h4g-client.exe`
- Restart Command Prompt/PowerShell after PATH changes

### "Permission denied"

**macOS/Linux:**
```bash
chmod +x /path/to/h4g-client
```

**Windows:**
- Run Command Prompt as Administrator if needed

### "Could not connect to API"

- Check internet connection
- Verify API endpoint is accessible: `curl https://dispatch.assettransporttms.com/api.php`
- Check firewall settings

### Executable doesn't work

- Verify it's the correct platform version
- Check file permissions
- Try running with full path first: `./h4g-client -d`

---

## API Endpoint

The application connects to:
```
https://dispatch.assettransporttms.com/api.php
```

This is a global endpoint accessible from anywhere.

---

## Features Summary

- ✅ **Encryption**: All data encrypted with AES-256-CBC
- ✅ **Exact Match Priority**: Exact keyword matches shown first
- ✅ **Partial Search**: Search for keywords containing a term
- ✅ **Duplicate Prevention**: Prevents exact duplicates
- ✅ **Silent Operations**: No output when saving
- ✅ **Clean Display**: Flags only, one per line
- ✅ **Cross-Platform**: Works on macOS, Linux, Windows

---

## Examples

### Example 1: Basic Workflow

```bash
# Save some data
h4g-client -e python scripting
h4g-client -e python programming
h4g-client -e java development

# View all
h4g-client -d
# Output:
# scripting
# programming
# development

# Search for python
h4g-client -d python
# Output:
# scripting
# programming
```

### Example 2: Multiple Keywords

```bash
# Save data
h4g-client -e web html
h4g-client -e web css
h4g-client -e web javascript
h4g-client -e mobile android
h4g-client -e mobile ios

# Search for web
h4g-client -d web
# Output:
# html
# css
# javascript

# Search for mobile
h4g-client -d mobile
# Output:
# android
# ios
```

### Example 3: Partial Search

```bash
# If you have keywords: "python", "python3", "pythonscript"
h4g-client -d python
# Shows flags for exact "python" match

h4g-client -d pyth
# Shows flags from all keywords containing "pyth"
```

---

## Support

For issues or questions:
1. Check this tutorial
2. Verify API endpoint is accessible
3. Check GitHub Issues: https://github.com/psworld143/brute-s/issues

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `h4g-client -e keyword flag` | Save keyword and flag |
| `h4g-client -d` | Display all flags |
| `h4g-client -d keyword` | Search flags by keyword |
| `h4g-client` | Show usage help |

---

**Last Updated:** 2025

