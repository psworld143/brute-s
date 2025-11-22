# brute

A Python console application that saves and retrieves encrypted data to/from a MySQL database via a PHP REST API.

## Features

- ✅ Save encrypted keyword and flag pairs to MySQL database
- ✅ Retrieve and display flags (decrypted)
- ✅ Search flags by keyword with exact match priority
- ✅ AES-256-CBC encryption with key "ndmu2025"
- ✅ Cross-platform support (macOS, Linux, Windows)
- ✅ Standalone executables (no Python installation required)

## Quick Start

### Using Standalone Executable

Download the executable for your platform from the [Releases](https://github.com/psworld143/brute-s/releases) page.

**macOS/Linux:**
```bash
./brute -e keyword flag
./brute -d
```

**Windows:**
```cmd
brute.exe -e keyword flag
brute.exe -d
```

### Using Python Script

1. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

2. **Run:**
   ```bash
   python3 client.py -e keyword flag
   python3 client.py -d
   ```

## Usage

### Save Data
```bash
brute -e {keyword} {flag}
# or
python3 client.py -e {keyword} {flag}
```

### Display All Flags
```bash
brute -d
# or
python3 client.py -d
```

### Search by Keyword
```bash
brute -d {keyword}
# or
python3 client.py -d {keyword}
```

## Building

### macOS/Linux
```bash
./build.sh
```

### Windows
```cmd
build.bat
```

### All Platforms (GitHub Actions)
The repository includes GitHub Actions workflow that automatically builds for all platforms on push.

---

## Global Environment Setup

Make `brute` executable available from anywhere in your terminal.

### macOS

#### Method 1: System-wide Installation (All Users)

1. **Copy executable to system directory:**
   ```bash
   sudo cp dist/brute /usr/local/bin/brute
   sudo chmod +x /usr/local/bin/brute
   ```

2. **Verify:**
   ```bash
   cd ~
   brute -d
   ```

#### Method 2: User-only Installation (Your Account Only)

1. **Create bin directory and copy executable:**
   ```bash
   mkdir -p ~/bin
   cp dist/brute ~/bin/brute
   chmod +x ~/bin/brute
   ```

2. **Add to PATH in ~/.zshrc (or ~/.bash_profile for bash):**
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

### Linux

#### Method 1: System-wide Installation (All Users)

1. **Copy executable to system directory:**
   ```bash
   sudo cp dist/brute /usr/local/bin/brute
   sudo chmod +x /usr/local/bin/brute
   ```

2. **Verify:**
   ```bash
   cd ~
   brute -d
   ```

#### Method 2: User-only Installation (Your Account Only)

1. **Create bin directory and copy executable:**
   ```bash
   mkdir -p ~/bin
   cp dist/brute ~/bin/brute
   chmod +x ~/bin/brute
   ```

2. **Add to PATH in ~/.bashrc (or ~/.zshrc):**
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

3. **Verify:**
   ```bash
   cd ~
   brute -d
   cd /tmp
   brute -d
   ```

### Windows

#### Method 1: User PATH (Your Account Only - Recommended)

1. **Create bin folder in your user directory:**
   ```cmd
   mkdir %USERPROFILE%\bin
   copy brute.exe %USERPROFILE%\bin\brute.exe
   ```

2. **Add to User PATH:**
   - Press `Win + X` and select **System**
   - Click **Advanced system settings**
   - Click **Environment Variables**
   - Under **User variables**, select **Path** → **Edit**
   - Click **New** → Add: `%USERPROFILE%\bin`
   - Click **OK** on all windows

3. **Restart Command Prompt/PowerShell**

4. **Verify:**
   ```cmd
   cd %USERPROFILE%
   brute.exe -d
   cd C:\Temp
   brute.exe -d
   ```

#### Method 2: System PATH (All Users - Requires Admin)

1. **Create folder and copy executable:**
   ```cmd
   mkdir "C:\Program Files\brute"
   copy brute.exe "C:\Program Files\brute\brute.exe"
   ```

2. **Add to System PATH:**
   - Press `Win + X` and select **System**
   - Click **Advanced system settings**
   - Click **Environment Variables**
   - Under **System variables**, select **Path** → **Edit**
   - Click **New** → Add: `C:\Program Files\brute`
   - Click **OK** on all windows

3. **Restart Command Prompt/PowerShell**

4. **Verify:**
   ```cmd
   brute.exe -d
   ```

---

## Requirements

- Python 3.7+ (for building)
- All dependencies in `requirements.txt`

## License

This project is provided as-is.

