#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

export HUSARNET_IPV6=$(echo "["$(curl -s 127.0.0.1:16216/api/status | jq -r '.result.local_ip')"]")

docker compose -f compose.vnc.yaml down
./disable-dummy.sh