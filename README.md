# Create a FreeBSD 10.2 Vagrant Box File

Despite there are several [Vagrant boxes](http://www.vagrantbox.es/) available which run FreeBSD out of the box, it's good to know how to create such a box by yourself. An advantage might be, that the box comes with only those packages installed you really need. That's why I decided to create a minimal FreeBSD box with only as much packages installed to run Ansible. With Ansible installed it's quite easy to perfectly adapt the box afterwards.

### Prerequisites

1. Virtualbox installed, [download page](https://www.virtualbox.org/wiki/Downloads)

2. Vagrant installed, [download page](https://www.vagrantup.com/downloads.html)

### Create a VB virtual machine

1. Create an virtual machine with NAT enabled for the first network adapter and add set the adapter type to `virtio-net`. Make sure the size of the configured hard disk is at least 8 GB.

2. Add the [downloaded mfsBSD ISO](http://mfsbsd.vx.sk/) as bootable CD device.

3. Boot.

4. Login with `root` and `mfsroot`.

5. Mount the mfsBSD ISO.

        mount_cd9660 /dev/cd0 /cdrom`

6. Install FreeBSD.

        zfsinstall -d /dev/ada0 -u /cdrom/10.2-RELEASE-amd64 -s 4G

8. Stop the VM.
9. Remove attached ISO
10. Boot the VM, login with `root` and execute the following commands.

        dhclient vtnet0
        fetch -o - --no-verify-peer \
         https://raw.githubusercontent.com/JoergFiedler/freebsd-vagrant-base-box/master/update.sh \
         | sh | tee out.log

Note: You may use this short link instead: `http://bit.ly/1lEHtrx`.

10. Halt the VM.

### Create the Box File

1. To create the box file just run the following command line.

        vagrant package --base my-virtual-machine

2. The file `package.box` can be refrenced by `vm.box_url` configuration parameter within your Vagrantfile.


### Box File

#### FreeBSD 10.2

Download the final box file here: http://vastland.moumantai.de/FreeBSD/vagrant-box/FreeBSD-10.2-vagrant-abe25b9.box

SHA256 Checksum: abe25b9b2b934053a624632323f7c62c1fe6dce0fd7453fb484cc2aba17f4056

#### FreeBSD 10.1
Download the final box file here: http://vastland.moumantai.de/FreeBSD/vagrant-box/FreeBSD-10.1-vagrant-base.box

SHA256 Checksum: 67f6d3e60d26ae811b685f13ddd3683a0cc7280ac8a104203006573ea831e699

#### FreeBSD 10.0
Download the final box file here: http://vastland.moumantai.de/FreeBSD/vagrant-box/FreeBSD-10-vagrant-base.box

SHA256 Checksum: 3418526d3a67313d3763ac75eb5b46c2d5d90837342e9d4fdef46dc387128735

### Links
1. mfsBSD: https://www.freebsd.org/doc/en/articles/remote-install/preparation.html
2. mfsBSD Image: http://mfsbsd.vx.sk/
3. Vagrant Howto - Creating a Base Box: https://docs.vagrantup.com/v2/virtualbox/boxes.html
4. FreeBSD VB information: https://wiki.freebsd.org/VirtualBox
5. http://unix.stackexchange.com/questions/39524/sharing-folder-from-windows-host-to-freebsd-guest/155373#155373

### Installed Packages

`pkg info`

    bash-4.3.42_1                  The GNU Project's Bourne Again SHell
    ca_root_nss-3.21               Root certificate bundle from the Mozilla Project
    gettext-runtime-0.19.6         GNU gettext runtime libraries and programs
    indexinfo-0.2.4                Utility to regenerate the GNU info page index
    iocage-1.7.3                   Full featured, no dependency Jail container manager
    libffi-3.2.1                   Foreign Function Interface
    pkg-1.6.2                      Package manager
    python-2.7_2,2                 The "meta-port" for the default version of Python interpreter
    python2-2_3                    The "meta-port" for version 2 of the Python interpreter
    python27-2.7.11_1              Interpreted object-oriented programming language
    sudo-1.8.15                    Allow others to run commands as root
