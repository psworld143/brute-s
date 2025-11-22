# brute Tutorial

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
brute -e keyword flag
```

**Display all flags:**
```bash
brute -d
```

**Search by keyword:**
```bash
brute -d keyword
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
brute -e python programming
brute -e "web development" active
brute -e database mysql
```

**Notes:**
- Use quotes for keywords/flags with spaces
- Empty keyword or flag will be rejected
- Duplicate exact matches (same keyword + same flag) are prevented

### Display All Flags

View all flags in the database:

```bash
brute -d
```

**Output:** One flag per line, no formatting

### Search by Keyword

Search for flags by keyword (exact match takes priority):

```bash
# Exact match - shows only flags for exact keyword "python"
brute -d python

# Partial match - shows flags from keywords containing "web"
brute -d web
```

**Search Behavior:**
- **Exact match**: If keyword exists exactly, shows only that keyword's flags
- **Partial match**: If no exact match, shows flags from keywords containing the search term

---

## Advanced Usage

### Examples

**Save multiple flags for same keyword:**
```bash
brute -e language python
brute -e language java
brute -e language javascript
```

**Search for all flags:**
```bash
brute -d
# Output:
# python
# java
# javascript
```

**Search for specific keyword:**
```bash
brute -d language
# Output:
# python
# java
# javascript
```

**Partial search:**
```bash
brute -d lang
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

Make `brute` available from anywhere in your terminal so you can run it from any directory.

### macOS

#### Method 1: System-wide Installation (All Users)

1. **Copy executable to system directory:**
   ```bash
   sudo cp dist/brute /usr/local/bin/brute
   sudo chmod +x /usr/local/bin/brute
   ```

2. **Verify it works from any directory:**
   ```bash
   cd ~
   brute -d
   
   cd /tmp
   brute -d
   ```

**Note:** Requires administrator password. Works for all users on the system.

#### Method 2: User-only Installation (Your Account Only)

1. **Create bin directory in your home folder:**
   ```bash
   mkdir -p ~/bin
   cp dist/brute ~/bin/brute
   chmod +x ~/bin/brute
   ```

2. **Add to PATH in your shell configuration file:**
   
   **For Zsh (default on macOS):**
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```
   
   **For Bash:**
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bash_profile
   source ~/.bash_profile
   ```

3. **Verify:**
   ```bash
   cd ~
   brute -d
   
   cd /tmp
   brute -d
   ```

**Note:** This only works for your user account, no admin password needed.

#### Method 3: Symbolic Link (Alternative)

1. **Create symbolic link in /usr/local/bin:**
   ```bash
   sudo ln -s /full/path/to/dist/brute /usr/local/bin/brute
   ```

2. **Verify:**
   ```bash
   brute -d
   ```

### Linux

#### Method 1: System-wide Installation (All Users)

1. **Copy executable to system directory:**
   ```bash
   sudo cp dist/brute /usr/local/bin/brute
   sudo chmod +x /usr/local/bin/brute
   ```

2. **Verify it works from any directory:**
   ```bash
   cd ~
   brute -d
   
   cd /tmp
   brute -d
   ```

**Note:** Requires root/sudo access. Works for all users on the system.

#### Method 2: User-only Installation (Your Account Only)

1. **Create bin directory in your home folder:**
   ```bash
   mkdir -p ~/bin
   cp dist/brute ~/bin/brute
   chmod +x ~/bin/brute
   ```

2. **Add to PATH in your shell configuration file:**
   
   **For Bash (most common):**
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```
   
   **For Zsh:**
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

3. **Verify:**
   ```bash
   cd ~
   brute -d
   
   cd /tmp
   brute -d
   ```

**Note:** This only works for your user account, no root access needed.

### Windows

#### Method 1: User PATH (Your Account Only - Recommended)

**Step 1: Create a folder for the executable**
1. Open File Explorer
2. Navigate to your user directory (usually `C:\Users\YourUsername`)
3. Create a new folder named `bin`
   - Or use Command Prompt:
     ```cmd
     mkdir %USERPROFILE%\bin
     ```

**Step 2: Copy the executable**
1. Copy `brute.exe` to the `bin` folder:
   ```cmd
   copy brute.exe %USERPROFILE%\bin\brute.exe
   ```

**Step 3: Add to User PATH**
1. Press `Win + X` and select **System**
2. Click **Advanced system settings** (or press `Win + R`, type `sysdm.cpl`, press Enter)
3. Click **Environment Variables** button
4. Under **User variables** (top section), find and select **Path**, then click **Edit**
5. Click **New** button
6. Type: `%USERPROFILE%\bin`
7. Click **OK** on all windows

**Step 4: Restart Terminal**
1. Close all Command Prompt/PowerShell windows
2. Open a new Command Prompt or PowerShell window

**Step 5: Verify**
```cmd
cd %USERPROFILE%
brute.exe -d

cd C:\Temp
brute.exe -e test flag
brute.exe -d
```

**Note:** This only affects your user account, no administrator rights needed.

#### Method 2: System PATH (All Users - Requires Admin)

**Step 1: Create folder**
1. Create folder: `C:\Program Files\brute\`
   ```cmd
   mkdir "C:\Program Files\brute"
   ```

**Step 2: Copy executable**
```cmd
copy brute.exe "C:\Program Files\brute\brute.exe"
```

**Step 3: Add to System PATH**
1. Press `Win + X` and select **System**
2. Click **Advanced system settings**
3. Click **Environment Variables**
4. Under **System variables** (bottom section), find and select **Path**, then click **Edit**
5. Click **New** button
6. Type: `C:\Program Files\brute`
7. Click **OK** on all windows

**Step 4: Restart Terminal**
- Close all Command Prompt/PowerShell windows and open new ones

**Step 5: Verify**
```cmd
brute.exe -d
```

**Note:** Requires administrator rights. Works for all users on the system.

#### Method 3: Quick Access (Current Session Only)

If you only need it for the current terminal session:

**Command Prompt:**
```cmd
set PATH=%PATH%;C:\full\path\to\brute.exe\directory
```

**PowerShell:**
```powershell
$env:PATH += ";C:\full\path\to\brute.exe\directory"
```

**Note:** This only works for the current terminal window. Settings are lost when you close it.

---

## Verification

After setting up global access, test from any directory:

### macOS/Linux
```bash
# Test from home directory
cd ~
brute -d

# Test from different directory
cd /tmp
brute -e test flag
brute -d test

# Verify it works from anywhere
cd /usr
brute -d
```

### Windows
```cmd
REM Test from user directory
cd %USERPROFILE%
brute.exe -d

REM Test from different directory
cd C:\Temp
brute.exe -e test flag
brute.exe -d test

REM Verify it works from anywhere
cd C:\Windows
brute.exe -d
```

---

## Troubleshooting

### "Command not found"

**macOS/Linux:**
- Check if executable is in PATH: `echo $PATH`
- Verify executable exists: `which brute`
- Check if file exists: `ls -la /usr/local/bin/brute` or `ls -la ~/bin/brute`
- Re-source your shell config: `source ~/.zshrc` or `source ~/.bashrc`
- Make sure executable has execute permission: `chmod +x ~/bin/brute`

**Windows:**
- Check PATH: `echo %PATH%`
- Verify executable: `where brute.exe`
- Check if file exists: `dir "%USERPROFILE%\bin\brute.exe"`
- Restart Command Prompt/PowerShell after PATH changes (important!)
- Check if PATH entry is correct: Look for `%USERPROFILE%\bin` or `C:\Program Files\brute`

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
brute -e python scripting
brute -e python programming
brute -e java development

# View all
brute -d
# Output:
# scripting
# programming
# development

# Search for python
brute -d python
# Output:
# scripting
# programming
```

### Example 2: Multiple Keywords

```bash
# Save data
brute -e web html
brute -e web css
brute -e web javascript
brute -e mobile android
brute -e mobile ios

# Search for web
brute -d web
# Output:
# html
# css
# javascript

# Search for mobile
brute -d mobile
# Output:
# android
# ios
```

### Example 3: Partial Search

```bash
# If you have keywords: "python", "python3", "pythonscript"
brute -d python
# Shows flags for exact "python" match

brute -d pyth
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
| `brute -e keyword flag` | Save keyword and flag |
| `brute -d` | Display all flags |
| `brute -d keyword` | Search flags by keyword |
| `brute` | Show usage help |

---

**Last Updated:** 2025

