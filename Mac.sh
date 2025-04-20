# Do not modify without autor permission.

#!/bin/bash

# Update & Upgrade
echo "[+] Updating packages..."
brew update && brew upgrade

# Install Python
if ! command -v python3 &> /dev/null; then
    echo "[+] Installing Python..."
    brew install python
fi

# Install pip if not already installed
if ! command -v pip3 &> /dev/null; then
    echo "[+] pip not found. Installing pip..."
    python3 -m ensurepip --upgrade
fi

# Run pip install
echo "[+] Installing Python dependencies..."
pip3 install -r requirements.txt

# Run the Python server
echo "[+] Starting server..."
python3 server.py &

# Wait a bit for server to start
sleep 1

# Open browser
echo "[+] Wait it will redirect to your browser..."
echo "[+] Opening browser at http://0.0.0.0:5000"
open http://0.0.0.0:5000

echo "Press Enter to stop server..."
read
pkill -f server.py
