echo "would you like to put the rootfs on an sd card or a rootfs.img (can be flashed to system/userdata etc)"
echo " "
read -r -p "[/*] E.g. 'rootfs.img': " android_rootfstype
echo " "

cat >> ${rootdir}/config.env <<EOF

android_rootfstype=$android_rootfstype
EOF

return 0
