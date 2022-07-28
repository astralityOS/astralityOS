#!/bin/bash

export packages="neofetch"
#for installing special packages/ui
#i'm not sure how veriables can be transfered between scripts, figure that out

/debootstrap/debootstrap --second-stage

#TODO: do setup steps in here: https://www.debian.org/releases/bullseye/arm64/apds03.en.html

apt-get install -y $packages

exit 
