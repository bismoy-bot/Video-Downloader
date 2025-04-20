#Do not modify without autor permission.
#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
reset='\033[0m'
# Update & Upgrade
echo -e "${green}[+] Updating packages...${reset}"
apt update -y && apt upgrade -y

# Install Python
if ! command -v python &> /dev/null; then
    echo -e "${green}[+] Installing Python...${reset}"
    apt install -y python
fi

# Install pip if not already installed
if ! command -v pip &> /dev/null; then
    echo -e "${green}[+] Installing Python dependencies...${reset}"
    pip install -r requirements.txt
fi
# Run the Python server
echo -e "${purple}[+] Starting server...${reset}"
python server.py &
# Wait a bit for server to start
sleep 1

# Open mobile browser
echo -e "${green}[+] Wait it will redirect to your browser...${reset}"
echo -e "${green}[+] Opening browser at http://0.0.0.0:5000...${reset}"
echo -e "${green}[+] Or Open browser at http://0.0.0.0:5000...${reset}"
xdg-open http://0.0.0.0:5000



echo -e "${purple}Press Enter to stop server...${reset}"
read
pkill -f server.py
