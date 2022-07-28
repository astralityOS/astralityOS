#!/bin/bash

#note: we need qemu-user-static for this to work

ABSPATH=$(cd "$(dirname "$BASH_SOURCE[0]")"; pwd -P)

source "${ABSPATH}/../../config"

LANG=C.UTF-8

echo "Creating rootfs"

rm -r $builddir/rootfs
#cleaning failed attempts

mkdir $builddir/rootfs

debootstrap --foreign --arch $arch $suite $builddir/rootfs $mirror

cp $(which qemu-$qmeuarch-static) $builddir/rootfs/bin

cp chrootsetup.sh $builddir/rootfs/usr/local

chroot $builddir/rootfs "/bin/qemu-$qmeuarch-static" "/bin/bash" "/usr/local/chrootsetup.sh"

#or we can do this instead of a configurable choot script
#LC_ALL=C chroot $builddir/rootfs "/bin/qemu-$qmeuarch-static" "/bin/bash" <<"EOF"
#debootstrap --second-stage
#EOF

rm $builddir/rootfs/usr/local/chrootsetup.sh

echo "rootfs is done"
