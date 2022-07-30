rootdir=$(cd "$(dirname "$BASH_SOURCE[0]")"; pwd -P)

echo "what device do you want to build for?"
echo " "
echo " "
ls ${rootdir}/devices/
echo " "
echo " "
read -r -p "[/*] E.g. 'gprime': " device
echo " "
echo "what debian suite do you want?"
echo " "
read -r -p "[/*] E.g. 'bullseye': " suite
echo " "
echo "what username do you want?"
echo " "
read -r -p "[/*] E.g. 'bob': " username
echo " "
read -r -p "password: " -s password
echo " "
echo " "
echo "what hostname do you want?"
echo " "
read -r -p "[/*] E.g. 'sbcname': " hostname
echo " "
echo "what extra packages do you want to install?"
echo " "
read -r -p "[/*] E.g. 'neofetch': " packages
echo " "
 
rm ${rootdir}/config.env
 
cat > ${rootdir}/config.env <<EOF
device=$device

suite=$suite

username=$username

password=$password #security risk, should ask this in build.sh

hostname=$hostname

packages=$packages
EOF

if [ -f ${rootdir}/devices/$device/device_options.sh ]; then
    echo "selected device has custom options, asking them now"
    echo " "
    . ${rootdir}/devices/$device/device_options.sh
fi

exit 0
