#!/bin/bash
set -a #sets all envs to be exported

rootdir=$(cd "$(dirname "$BASH_SOURCE[0]")"; pwd -P)

builddir=${rootdir}/output

scriptdir=${rootdir}/scripts

mkdir $builddir

error() {
 echo -e "\e[1;31m[ERROR]\e[0m $1" >&2
 exit 1
}

if [ -f ${rootdir}/config.env ]; then
    . ${rootdir}/config.env
else
    echo "config.env not found, running initial config"
    echo " "
    . ${rootdir}/setup.sh
    . ${rootdir}/config.env
fi

. ${rootdir}/devices/$device/$device.env

if [[ $(uname -m) == *"$arch"* ]]; then
    cross=0
else
    cross=1
    crosscompiler=aarch64-linux-gnu- # should be replaced with a list of come kind if this script becomes public
fi

mirror=http://deb.debian.org/debian/

echo "creating rootfs..."

if [ -f $builddir/rootfs/.tmp ]; then
    echo -e "rootfs already exits"
else
    . ${scriptdir}/rootfs/mkrootfs.sh || error "error creating rootfs"
fi

echo "building kernel..."

. ${scriptdir}/kernel/mkkernel.sh #check is inside this script beacuse amake is defined in here.

echo "copying modules and firmware into rootfs..."

if [ -f $builddir/rootfs/lib/modules/*/modules.dep ]; then #again, perhaps check for another directory.
    echo -e "modules already installed"
else
    $amake INSTALL_MOD_PATH=$builddir/rootfs modules_install || error "error copying modules" 
fi

#if [ -f $builddir/rootfs/lib/firmware/[file to test for] ]; then #heh this will be a hard one, good thing this is wip
#    echo -e "firmware already copied"
#else
#    wget $firmwareurl $builddir/${device}_firmware.xz
#    tar -xzf $builddir/${device}_firmware.xz $builddir/rootfs/lib/firmware
#fi

echo "executing bootloder script"

. ${rootdir}/bootloaders/$bootloader/bootloader.sh

