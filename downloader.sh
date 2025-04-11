#Do not modify without autor permission.


#!/bin/bash

# Update & Upgrade
echo "[+] Updating packages..."
apt update -y && apt upgrade -y

# Install Python
if ! command -v python &> /dev/null; then
    echo "[+] Installing Python..."
    apt install -y python
fi

# Install pip if not already installed
if ! command -v pip &> /dev/null; then
    echo "[+] Installing Python dependencies..."
    pip install -r requirements.txt
fi
# Run the Python server
echo "[+] Starting server..."
python server.py &

# Wait a bit for server to start
sleep 3

# Open mobile browser
echo "[+] Opening browser at http://0.0.0.0:5000"
xdg-open http://0.0.0.0:5000
