#!/bin/sh -e

HOSTNAME="${HOSTNAME:-""}"
INTERFACE="${EXT_IF:-"vtnet0"}"
PACKAGES="${PACKAGES:-"ca_root_nss sudo bash python"}"
PUBLIC_KEY="${PUBLIC_KEY:-"https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub"}"
SSH_USER="${SSH_USER:-"vagrant"}"
ZPOOL_NAME="${ZPOOL_NAME:-"tank"}"

# ZFS filesystems
zfs create -o mountpoint=/home ${ZPOOL_NAME}/home

# Network configuration
echo 'hostname="'${HOSTNAME}'"' >> /etc/rc.conf
echo 'ifconfig_'${INTERFACE}'="DHCP"' >> /etc/rc.conf

# Enable services
echo 'sendmail_enable="NONE"' >> /etc/rc.conf
echo 'sshd_enable="YES"' >> /etc/rc.conf
echo 'pf_enable="YES"' >> /etc/rc.conf
echo 'pflog_enable="YES"' >> /etc/rc.conf
echo 'pass all' >> /etc/pf.conf

# Update Base
freebsd-update fetch --not-running-from-cron
freebsd-update install --not-running-from-cron

# Start services
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

# Create the user
echo "*" | pw useradd -n ${SSH_USER} -s /usr/local/bin/bash -m -G wheel -H 0

# Disable root's password
chpass -p "*" root

# Enable sudo for user
mkdir -p /usr/local/etc/sudoers.d
echo "%${SSH_USER} ALL=(ALL) NOPASSWD: ALL" >> /usr/local/etc/sudoers.d/${SSH_USER}

# Authorize user to login without a key
mkdir /home/${SSH_USER}/.ssh
chmod 700 /home/${SSH_USER}/.ssh
touch /home/${SSH_USER}/.ssh/authorized_keys
chown -R ${SSH_USER}:${SSH_USER} /home/${SSH_USER}

# Get the public key and save it in the `authorized_keys`
fetch -o /home/${SSH_USER}/.ssh/authorized_keys ${PUBLIC_KEY}

# Speed up boot process
echo 'autoboot_delay="2"' >> /boot/loader.conf

# Clean up installed packages
pkg clean -a -y

# Empty out tmp directory
rm -rf /tmp/*

# Make bash happy
echo "fdesc /dev/fd fdescfs rw 0 0" >> /etc/fstab

# Remove the history
cat /dev/null > /root/.history

# Done
echo "Minial FreeBSD box set up. Power off, take a snapshot, or package it. Whatever, enjoy!"

