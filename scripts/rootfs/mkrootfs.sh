#note: we need qemu-user-static for this to work

LANG=C.UTF-8

echo "Creating rootfs"

rm -r $builddir/rootfs
#cleaning failed attempts

mkdir $builddir/rootfs

debootstrap --foreign --arch $arch $suite $builddir/rootfs $mirror

cp $(which qemu-$qemuarch-static) $builddir/rootfs/bin

mkdir -p $builddir/rootfs/usr/local/

cp ${ABSPATH}/rootfs/chrootsetup.sh $builddir/rootfs/usr/local/

#NOTE: probably change $fstab to a path ig
cp $fstab $builddir/rootfs/etc/

chroot $builddir/rootfs "/bin/qemu-$qemuarch-static" "/bin/bash" "/usr/local/chrootsetup.sh"

#or we can do this instead of a configurable choot script
#LC_ALL=C chroot $builddir/rootfs "/bin/qemu-$qemuarch-static" "/bin/bash" <<"EOF"
#debootstrap --second-stage
#EOF

rm $builddir/rootfs/usr/local/chrootsetup.sh

touch $builddir/rootfs/.tmp 

echo "rootfs is done"
