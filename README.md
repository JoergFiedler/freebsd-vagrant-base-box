# Create a FreeBSD Vagrant Box

Despite there are several [Vagrant boxes](http://www.vagrantbox.es/) available which run FreeBSD out of the box, it's good to know how to create such a box by yourself. An advantage might be, that the box comes with with those packages installed you probably you really need. That's why I decided to create a minimal FreeBSD box with only as much packages installed to run Ansible. With Ansible installed it's quite easy to perfectly adapt the box to match your needs. 

Create a VB virtual machine

1. Create an virtual machine with NAT enabled for the first network adapter and add set the adapter type to `virtio-net`.
2. Add the [downloaded mfsBSD ISO](http://mfsbsd.vx.sk/) as bootable CD device.
3. Boot.
4. Login with `root` and `mfsroot`.
5. Mount the mfsBSD ISO: `mount_cd9660 /dev/cd0 /cdrom`
6. Install FreeBSD: `zfsinstall -d /dev/ada0 -u/cdrom/10.0-RELEASE-amd64 -s 4G`
7. Stop th VM.
8. Remove attached ISO.
9. Boot the VM, login with `root` and execute the following commands.

        dhclient vtnet0
        fetch -o - --no-verify-peer https://raw.githubusercontent.com/JoergFiedler/freebsd-vagrant-base-box/master/update.sh | sh

10. Halt the VM. 

Create the Box File

1) To create the box file just run the following command line.

    vagrant package --base my-virtual-machine

2) Done.

# Links
1. mfsBSD: https://www.freebsd.org/doc/en/articles/remote-install/preparation.html
2. mfsBSD Image: http://mfsbsd.vx.sk/
3. Vagrant Howto: Creating a Base Box: https://docs.vagrantup.com/v2/virtualbox/boxes.html
4. FreeBSD VB information: https://wiki.freebsd.org/VirtualBox
5. http://unix.stackexchange.com/questions/39524/sharing-folder-from-windows-host-to-freebsd-guest/155373#155373

