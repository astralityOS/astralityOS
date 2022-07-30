#!/bin/bash

cp ${ABSPATH}/rootfs/chrootsetup.sh $builddir/rootfs/usr/local/

set -a 

chroot $builddir/rootfs "/bin/qemu-$qemuarch-static" "/bin/bash" "/usr/local/chrootsetup.sh"
