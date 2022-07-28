#!/bin/bash

#note: we need qemu-user-static for this to work

#placeholder veriables
export devicebuilddir="../../Build/Placeholder"

export suite="bullseye"

export arch="arm64"
export qmeuarch="aarch64"

export LANG=C.UTF-8

export mirror="http://deb.debian.org/debian/"
#https://www.debian.org/mirror/list

echo "Creating rootfs"

rm -r $devicebuilddir/rootfs
#cleaning failed attempts

mkdir $devicebuilddir/rootfs

debootstrap --foreign --arch $arch $suite $devicebuilddir/rootfs $mirror

cp $(which qemu-$qmeuarch-static) $devicebuilddir/rootfs/bin

cp chrootsetup.sh $devicebuilddir/rootfs

chroot $devicebuilddir/rootfs "/bin/qemu-$qmeuarch-static" "/bin/bash" "/chrootsetup.sh"

#or we can do this instead of a configurable choot script
#LC_ALL=C chroot $devicebuilddir/rootfs "/bin/qemu-$qmeuarch-static" "/bin/bash" <<"EOF"
#debootstrap --second-stage
#EOF

echo "rootfs is done"
