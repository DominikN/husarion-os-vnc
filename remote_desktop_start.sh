#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Define color codes
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

URL_START="\e]8;;"
URL_END="\e]8;;\a"
TEXT_RESET="\a"
URL_GUIDE="https://husarnet.com/docs/#husarnet-client"

export HUSARNET_IPV6=$(echo "["$(curl -s 127.0.0.1:16216/api/status | jq -r '.result.local_ip')"]")

./enable-dummy.sh

# Parse command line arguments
if [[ $# -lt 1  ]]; then
   echo -e "No password set, using default: ${BOLD}husarion${NC}"
else
   export VNC_PASSWORD=$1
   echo -e "Password: ${BOLD}${VNC_PASSWORD}${NC}"
fi

docker compose -f compose.vnc.yaml up -d

echo -e "\r\nVisit ${BLUE}http://${HUSARNET_IPV6}:8080${NC} to access remote desktop."
echo -e "Ensure your computer is in ${BOLD}the same Husarnet network${NC} (${BLUE}${URL_START}${URL_GUIDE}${TEXT_RESET}how to connect?${URL_END}${NC}) ."