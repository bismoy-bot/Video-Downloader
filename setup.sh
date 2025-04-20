#!/bin/bash

# Do not modify without author permission.
# Regular Colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
reset='\033[0m'
echo -e "${yellow}[+] Detecting operating system...${reset}"

unameOut="$(uname -s)"

case "${unameOut}" in
    Linux*)
        echo -e "${purple}[+] Linux detected. Running 'linux.sh'...${reset}"
        chmod +x ./linux.sh && ./linux.sh
        ;;
    Darwin*)
        echo -e "${purple}[+] macOS detected. Running 'Mac.sh'...${reset}"
        chmod +x ./Mac.sh && ./Mac.sh
        ;;
    *)
        echo -e "${red}[-] Unsupported OS: ${unameOut}. You don't need to worry about it ...${reset}"
        exit 1
        ;;
esac
