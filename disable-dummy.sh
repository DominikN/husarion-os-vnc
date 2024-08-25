#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Path to the configuration file
config_file="/etc/X11/xorg.conf.d/10-dummy-monitor.conf"

# Check if the configuration file exists
if [ -f "$config_file" ]; then
    echo "$config_file exists. Removing and restarting display manager..."
    
    # Remove the dummy monitor configuration file
    sudo rm "$config_file"
    
    # Restart the display manager
    sudo systemctl restart display-manager
else
    echo "$config_file does not exist. No action taken."
fi
