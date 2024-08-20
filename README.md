# husarion-os-vnc

If there is no [Husarion OS](https://husarion.com/software/os/) available for your single board compuer (like Nvidia Jetson), and you want to use the remote desktop this instruction is for you. 

## Quick Start

First connect the [user computer in Panther's user compartment](https://husarion.com/manuals/panther/#user-compartment) to the Husarnet VPN group as described [here](https://husarnet.com/docs/#husarnet-client).

SSH to the Panther's terminal and run:

1. install `jq` on the user computer in Panther:

```bash
sudo apt install jq
```

2. Now instruction is pretty the same as in the [Husarion OS VNC guide](https://husarion.com/software/os/remote-desktop/#share-your-robots-desktop). Start the remote desktop:

```bash
sudo ./remote_desktop_start.sh
```



