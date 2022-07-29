#!/bin/bash

#NOTE: a bit wip

/debootstrap/debootstrap --second-stage

cat > /etc/apt/sources.list <<EOF
deb http://deb.debian.org/debian $suite main
deb-src http://deb.debian.org/debian $suite main

deb http://deb.debian.org/debian $suite-updates main
deb-src http://deb.debian.org/debian $suite-updates main
EOF

if [[ $suite == *"bullseye"* ]]; then

cat >> /etc/apt/sources.list <<EOF
deb http://deb.debian.org/debian-security/ bullseye-security main
deb-src http://deb.debian.org/debian-security/ bullseye-security main
EOF

else

cat >> /etc/apt/sources.list <<EOF
deb http://deb.debian.org/debian-security/ $suite/updates main
deb-src http://deb.debian.org/debian-security/ $suite/updates main
EOF

fi

apt-get update

#we should give some sort of option for this idk perhaps
# tasksel install standard

apt-get install -y $packages

adduser --disabled-password --shell /bin/bash --home /home/$username --gecos "" $username

echo "$username:$password" | chpasswd

echo $hostname > /etc/hostname

apt clean

exit 
