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

# Check if DISPLAY environment variable is set
if [ -z "$DISPLAY" ]; then
  echo "DISPLAY environment variable is not set. Running ./enable-dummy.sh..."

  # Run the enable-dummy.sh script
  ./enable-dummy.sh

  # Check for available displays in /tmp/.X11-unix and set DISPLAY
  available_display=$(ls /tmp/.X11-unix | grep 'X' | head -n 1)

  if [ -n "$available_display" ]; then
    # Set the DISPLAY environment variable to the first available display
    export DISPLAY=":$available_display"
    echo "DISPLAY environment variable set to: $DISPLAY"
  else
    echo "No available displays found in /tmp/.X11-unix."
  fi
else
  echo "DISPLAY environment variable is already set to: $DISPLAY"
fi

# Parse command line arguments
if [[ $# -lt 1  ]]; then
   echo -e "No password set, using default: ${BOLD}husarion${NC}"
else
   export VNC_PASSWORD=$1
   echo -e "Password: ${BOLD}${VNC_PASSWORD}${NC}"
fi

xhost +local:docker
docker compose -f compose.vnc.yaml up -d

echo -e "\r\nVisit ${BLUE}http://${HUSARNET_IPV6}:8080${NC} to access remote desktop."
echo -e "Ensure your computer is in ${BOLD}the same Husarnet network${NC} (${BLUE}${URL_START}${URL_GUIDE}${TEXT_RESET}how to connect?${URL_END}${NC}) ."