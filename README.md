# Cloud-config 
A collection of cloud-config YAML files files to provision virtual servers. Adapted for Hetzner "cloud servers" using the "ubuntu-20.04" image. Tested with hcloud or with Hetzner web interface. Performs simple variable substiution in YAML files to avoid storing secrets / host specific information in template

## Usage
- On your desktop, install [hcloud cli](https://github.com/hetznercloud/cli) 
- Get API token from Hetzner for the project you want to use
- `mv cloud-config-example .cloud-config-secret` and add variables
- Generate a cloud-config file by passing the YAML file as argument to generate-config.sh

### Example
- To launch a server with *ubuntu 20.04* running *xfce4*, run
```bash
NAME="my-ubuntu-desktop" IMG="ubuntu-20.04" && \ 
TYPE="desktop" && \
./generate-config.sh "$IMG-$TYPE.yaml"  && \
hcloud server create --image $IMG --name "$NAME" \
--type "cpx11" --datacenter fsn1-dc14 \
--user-data-from-file "$IMG-$TYPE.yaml-secret"
```

# Usage  of configured cloud instances
## xRDP
- Use SSH tunnel for connections , e.g. "ssh -L 2000:localhost:3389 "
- If screen resolution is too low, make sure to use "use client resolution" on client app side (remmina)

## Home directory
- An (optional) volume is added to /etc/fstab and is mounted on top of existing /home if present
  - make sure to have SSH keys in the right place

# Todo
## General
- Make overlayfs work
- PIA VPN
  - xrdp connection breaks upon activation

## Server
- Add openvpn setup
