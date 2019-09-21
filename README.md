# vpn-port-forwarder

Forward traffic through a VPN without installing a VPN client on your physical machine!

## What Even is this?

This is a script designed as an alternative to installing a VPN client on a personal computer when accessing an external network.

## How does it Work?

This script uses openconnect to connect to a VPN and then uses socat to forward all TCP traffic on a specific port to another machine on the VPN. So when run in a virtual machine, the specified port behaves like the specified machine on the VPN. This is especially helpful in cases of using a VPN to connect to a computer at work, because some VPN clients will make strange configuration changes to your personal machine when all you need is port 22/3389 (ssh/RDP) to your work computer.

## How do I use it?

### Initial Setup

Create a virtual machine and install Alpine Linux, including the `openconnect` and `socat` packages (ssh isn't needed), and map the port you want to forward on your phyical machine to the VPN.

Once that's done, assign the following variables located at the top of the script:

- `target_addr`: The IP or DNS of the machine you want to connect to on the VPN
- `target_port`: The port you want to forward to `target_addr`
- `vpn_server`: The IP or DNS of the VPN server
- `vpn_cert`: The certificate of the VPN server
  - This is mostly to stop openconnect from asking you to confirm the certificate everytime, and can be found in the logs of the `openconnect` command when trying to connect to the VPN
- `vpn_group`: The group to use when connecting to the VPN
- `vpn_user`: The user to use when connecting to the VPN

### Connecting

Simply call `./run.sh` in the Ash terminal of the your virtual machine, filling in any other prompts from openconnect and you're good to go!
