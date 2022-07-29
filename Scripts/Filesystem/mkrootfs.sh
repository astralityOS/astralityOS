#!/bin/bash

#note: we need qemu-user-static for this to work

source "$2"
source "$3"

ROOT=$1
builddir="$4"

echo "Creating rootfs"

rm -r $builddir/rootfs
#cleaning failed attempts

mkdir -p $builddir/rootfs

debootstrap --foreign --arch $arch $suite $builddir/rootfs $mirror

cp $(which qemu-$qemuarch-static) $builddir/rootfs/bin

cp chrootsetup.sh $builddir/rootfs/usr/local

#NOTE: probably change $fstab to a path ig
cp $fstab $builddir/rootfs/etc/

chroot $builddir/rootfs "/bin/qemu-$qemuarch-static" "/bin/bash" "/usr/local/chrootsetup.sh"

#or we can do this instead of a configurable choot script
#LC_ALL=C chroot $builddir/rootfs "/bin/qemu-$qemuarch-static" "/bin/bash" <<"EOF"
#debootstrap --second-stage
#EOF

rm $builddir/rootfs/usr/local/chrootsetup.sh

echo "rootfs is done"
