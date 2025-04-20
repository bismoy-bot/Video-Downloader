#!/bin/bash

# Do not modify without author permission.

echo "[+] Detecting operating system..."

unameOut="$(uname -s)"

case "${unameOut}" in
    Linux*)
        echo "[+] Linux detected. Running 'l'..."
        chmod +x ./l && ./l
        ;;
    Darwin*)
        echo "[+] macOS detected. Running 'Mac.sh'..."
        chmod +x ./Mac.sh && ./Mac.sh
        ;;
    *)
        echo "[-] Unsupported OS: ${unameOut}. Only Linux and macOS are supported."
        exit 1
        ;;
esac
