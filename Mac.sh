# Do not modify without autor permission.

#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
reset='\033[0m'
# Update & Upgrade
echo -e "${purple}[+] Updating packages...${reset}"
brew update && brew upgrade

# Install Python
if ! command -v python3 &> /dev/null; then
    echo -e "${bule}[+] Installing Python...${reset}"
    brew install python
fi

# Install pip if not already installed
if ! command -v pip3 &> /dev/null; then
    echo -e "${purple}[+] pip not found. Installing pip...${reset}"
    python3 -m ensurepip --upgrade
fi

# Run pip install
echo -e "${purple}[+] Installing Python dependencies...${reset}"
pip3 install -r requirements.txt

# Run the Python server
echo -e "${green}[+] Starting server...${reset}"
python3 server.py &

# Wait a bit for server to start
sleep 1

# Open browser
echo -e "${green}[+] Wait it will redirect to your browser...${reset}"
echo -e "${green}[+] Opening browser at http://0.0.0.0:5000...${reset}"
echo -e "${red}[+]Or,Open your browser and goto http://0.0.0.0:5000${reset}"
open http://0.0.0.0:5000

echo -e "${cyan}Press Enter to stop server...${reset}"
read
pkill -f server.py
