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

## Requirements

- Python 3.7+ (for building)
- All dependencies in `requirements.txt`

## License

This project is provided as-is.

