#!/bin/sh -e

INTERFACE="vtnet0"
PACKAGES="ca_root_nss virtualbox-ose-additions sudo bash"
PUBLIC_KEY="https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub"
USER="vagrant"

# Network configuration
echo 'hostname="vagrant"' >> /etc/rc.conf
echo 'ifconfig_'${INTERFACE}'="DHCP -tso"' >> /etc/rc.conf

# Enable services
echo 'sshd_enable="YES"' >> /etc/rc.conf
echo 'pf_enable="YES"' >> /etc/rc.conf
echo 'pflog_enable="YES"' >> /etc/rc.conf
echo 'pass all' >> /etc/pf.conf

# Start services
service sshd keygen
service sshd start
service pf start
service pflog start

# Add FreeBSD package repository
mkdir -p /usr/local/etc/pkg/repos
cat << EOT > /usr/local/etc/pkg/repos/FreeBSD.conf
FreeBSD: {
  url: "pkg+http://pkg.eu.FreeBSD.org/\${ABI}/latest",
  enabled: yes
}
EOT
env ASSUME_ALWAYS_YES=true /usr/sbin/pkg bootstrap -f
pkg update

# Install required packages
for package in ${PACKAGES}; do
  pkg install -y ${package}
done

# Activate vbox additions
echo 'vboxguest_enable="YES"' >> /etc/rc.conf
echo 'vboxservice_enable="YES"' >> /etc/rc.conf

# Activate installed root certifcates
ln -s /usr/local/share/certs/ca-root-nss.crt /etc/ssl/cert.pem

# Create the user
echo ${USER} | pw useradd -n ${USER} -s /usr/local/bin/bash -m -G wheel -H 0

# Enable sudo for user
mkdir /usr/local/etc/sudoers.d
echo "%${USER} ALL=(ALL) NOPASSWD: ALL" >> /usr/local/etc/sudoers.d/${USER}

# Authorize user to login without a key
mkdir /home/${USER}/.ssh
chmod 700 /home/${USER}/.ssh
touch /home/${USER}/.ssh/authorized_keys
chown -R ${USER}:${USER} /home/${USER}

# Get the public key and save it in the `authorized_keys`
fetch -o /home/${USER}/.ssh/authorized_keys ${PUBLIC_KEY}

# Speed up boot process
echo 'autoboot_delay="1"' >> /boot/loader.conf

# Clean up installed packages
pkg clean -a -y

# Shrink final box file
echo 'Preparing disk for vagrant package command'
dd if=/dev/zero of=/tmp/out bs=1m > /dev/null 2>&1 || true

# Empty out tmp directory
rm -rf /tmp/*

# Remove the history
cat /dev/null > /root/.history

# Done
echo "Done. Power off the box and package it up with Vagrant using 'vagrant package'."

