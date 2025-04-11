#Do not modify without autor permission.


#!/bin/bash

# Update & Upgrade
echo "[+] Updating packages..."
apt update -y && apt upgrade -y

# Install Python
echo "[+] Installing Python..."
apt install -y python

# Install pip if not already installed
if ! command -v pip &> /dev/null; then
    echo "[+] Installing pip..."
    apt install -y python-pip
fi

# Install required packages from requirements.txt
echo "[+] Installing Python dependencies..."
pip install -r requirements.txt

# Run the Python server
echo "[+] Starting server..."
python server.py &

# Wait a bit for server to start
sleep 3

# Open mobile browser
echo "[+] Opening browser at http://0.0.0.0:5000"
xdg-open http://0.0.0.0:5000
