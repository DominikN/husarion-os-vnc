#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

sudo cp ./10-dummy-monitor.conf /etc/X11/xorg.conf.d/10-dummy-monitor.conf
sudo systemctl restart display-manager