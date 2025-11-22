#!/usr/bin/env python3

import requests
import json
import sys
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import padding
import base64
import hashlib
import os

API_URL = "https://dispatch.assettransporttms.com/api.php"

ENCRYPTION_KEY = "ndmu2025"

def get_key():
    return hashlib.sha256(ENCRYPTION_KEY.encode()).digest()

def encrypt_data(plaintext):
    try:
        key = get_key()
        iv = hashlib.md5(plaintext.encode()).digest()[:16]
        
        padder = padding.PKCS7(128).padder()
        padded_data = padder.update(plaintext.encode())
        padded_data += padder.finalize()
        
        cipher = Cipher(algorithms.AES(key), modes.CBC(iv), backend=default_backend())
        encryptor = cipher.encryptor()
        ciphertext = encryptor.update(padded_data) + encryptor.finalize()
        
        encrypted_data = base64.b64encode(iv + ciphertext).decode('utf-8')
        return encrypted_data
    except Exception:
        raise Exception("Encryption error")

def decrypt_data(encrypted_data):
    try:
        key = get_key()
        
        encrypted_bytes = base64.b64decode(encrypted_data)
        
        iv = encrypted_bytes[:16]
        ciphertext = encrypted_bytes[16:]
        
        cipher = Cipher(algorithms.AES(key), modes.CBC(iv), backend=default_backend())
        decryptor = cipher.decryptor()
        padded_plaintext = decryptor.update(ciphertext) + decryptor.finalize()
        
        unpadder = padding.PKCS7(128).unpadder()
        plaintext = unpadder.update(padded_plaintext)
        plaintext += unpadder.finalize()
        
        return plaintext.decode('utf-8')
    except Exception:
        raise Exception("Decryption error")

def save_data(keyword, flag):
    if not keyword or not keyword.strip():
        return False
    if not flag or not flag.strip():
        return False
    
    try:
        encrypted_keyword = encrypt_data(keyword.strip())
        encrypted_flag = encrypt_data(flag.strip())
        
        data = {
            'keyword': encrypted_keyword,
            'flag': encrypted_flag
        }
        
        response = requests.post(
            API_URL,
            json=data,
            headers={'Content-Type': 'application/json'},
            timeout=10
        )
        
        if response.status_code == 201:
            return True
        else:
            return False
            
    except requests.exceptions.ConnectionError:
        return False
    except requests.exceptions.Timeout:
        return False
    except requests.exceptions.RequestException:
        return False
    except json.JSONDecodeError:
        return False

def search_data(keyword=None):
    try:
        params = {}
        if keyword:
            params['keyword'] = keyword
        
        response = requests.get(
            API_URL,
            params=params,
            timeout=10
        )
        
        if response.status_code == 200:
            result = response.json()
            
            if result.get('success'):
                flags = result.get('flags', [])
                
                for record in flags:
                    encrypted_flag = record.get('flag', '')
                    try:
                        decrypted_flag = decrypt_data(encrypted_flag)
                        if decrypted_flag:
                            print(decrypted_flag)
                    except Exception:
                        pass
                
                return True
            else:
                return False
        else:
            return False
            
    except requests.exceptions.ConnectionError:
        return False
    except requests.exceptions.Timeout:
        return False
    except requests.exceptions.RequestException:
        return False
    except json.JSONDecodeError:
        return False

def print_usage():
    print("Usage:")
    print("  python client.py -e {keyword} {flag}  # Enter/save keyword and flag")
    print("  python client.py -d                    # Display all flags")
    print("  python client.py -d {keyword}          # Display flags for specific keyword")
    print("\nExamples:")
    print("  python client.py -e python programming")
    print("  python client.py -e \"web development\" active")
    print("  python client.py -d                    # Show all records")
    print("  python client.py -d python             # Show records for 'python' keyword")

def main():
    if len(sys.argv) < 2:
        print_usage()
        sys.exit(1)
    
    command = sys.argv[1]
    
    if command == '-e':
        if len(sys.argv) < 4:
            print_usage()
            sys.exit(1)
        
        keyword = sys.argv[2]
        flag = sys.argv[3]
        
        if not keyword.strip() or not flag.strip():
            print_usage()
            sys.exit(1)
        
        save_data(keyword, flag)
    
    elif command == '-d':
        keyword = sys.argv[2] if len(sys.argv) >= 3 else None
        search_data(keyword)
    
    else:
        print_usage()
        sys.exit(1)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(0)
