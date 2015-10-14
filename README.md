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

        zfsinstall -d /dev/ada0 -u/cdrom/10.2-RELEASE-amd64 -s 4G

8. Stop the VM.
9. Remove attached ISO
10. Boot the VM, login with `root` and execute the following commands.

        dhclient vtnet0
        fetch -o - --no-verify-peer https://raw.githubusercontent.com/JoergFiedler/freebsd-vagrant-base-box/master/update.sh | sh

10. Halt the VM.

### Create the Box File

1. To create the box file just run the following command line.

        vagrant package --base my-virtual-machine

2. The file `package.box` can be refrenced by `vm.box_url` configuration parameter within your Vagrantfile.


### Box File

#### FreeBSD 10.2 (pf enabled)
Download the final box file here: https://s3-eu-west-1.amazonaws.com/vastland.moumantai.de/public/FreeBSD/vagrant-box/FreeBSD-10.2-pf-enabled-vagrant-base.box

SHA256 Checksum: 100e0cb5a6c58d197e0e95013bf80b189356ae0f75af2f8e6089d880d8d3cb55


#### FreeBSD 10.2
Download the final box file here: https://s3-eu-west-1.amazonaws.com/vastland.moumantai.de/public/FreeBSD/vagrant-box/FreeBSD-10.2-vagrant-base.box

SHA256 Checksum: 26d251676c9747a6e1a7446bfd5e50cbdb8de09e1eb58295fd91491267a55e46

#### FreeBSD 10.1
Download the final box file here: https://s3-eu-west-1.amazonaws.com/vastland.moumantai.de/public/FreeBSD/vagrant-box/FreeBSD-10.1-vagrant-base.box

SHA256 Checksum: 67f6d3e60d26ae811b685f13ddd3683a0cc7280ac8a104203006573ea831e699

#### FreeBSD 10.0
Download the final box file here: https://s3-eu-west-1.amazonaws.com/vastland.moumantai.de/public/FreeBSD/vagrant-box/FreeBSD-10-vagrant-base.box

SHA256 Checksum: 3418526d3a67313d3763ac75eb5b46c2d5d90837342e9d4fdef46dc387128735

### Links
1. mfsBSD: https://www.freebsd.org/doc/en/articles/remote-install/preparation.html
2. mfsBSD Image: http://mfsbsd.vx.sk/
3. Vagrant Howto - Creating a Base Box: https://docs.vagrantup.com/v2/virtualbox/boxes.html
4. FreeBSD VB information: https://wiki.freebsd.org/VirtualBox
5. http://unix.stackexchange.com/questions/39524/sharing-folder-from-windows-host-to-freebsd-guest/155373#155373

### Installed Packages

    pkg info
    bash-4.3.42                    The GNU Project's Bourne Again SHell
    ca_root_nss-3.20               Root certificate bundle from the Mozilla Project
    damageproto-1.2.1              Damage extension headers
    dri-10.6.8,2                   OpenGL hardware acceleration drivers for the DRI
    dri2proto-2.8                  DRI2 prototype headers
    expat-2.1.0_3                  XML 1.0 parser written in C
    fixesproto-5.0                 Fixes extension headers
    font-util-1.3.1                Create an index of X font files in a directory
    fontsproto-2.1.2,1             Fonts extension headers
    freetype2-2.6_1                Free and portable TrueType font rendering engine
    gettext-runtime-0.19.5.1       GNU gettext runtime libraries and programs
    indexinfo-0.2.3                Utility to regenerate the GNU info page index
    kbproto-1.0.6                  KB extension headers
    libGL-10.6.8                   OpenGL library that renders using GLX or DRI
    libICE-1.0.9_1,1               Inter Client Exchange library for X11
    libSM-1.2.2_3,1                Session Management library for X11
    libX11-1.6.2_3,1               X11 library
    libXau-1.0.8_3                 Authentication Protocol library for X11
    libXaw-1.0.12_3,2              X Athena Widgets library
    libXcursor-1.1.14_3            X client-side cursor loading library
    libXdamage-1.1.4_3             X Damage extension library
    libXdmcp-1.1.2                 X Display Manager Control Protocol library
    libXext-1.3.3_1,1              X11 Extension library
    libXfixes-5.0.1_3              X Fixes extension library
    libXfont-1.4.9,2               X font library
    libXinerama-1.1.3_3,1          X11 Xinerama library
    libXmu-1.1.2_3,1               X Miscellaneous Utilities libraries
    libXp-1.0.3,1                  X print library
    libXpm-3.5.11_4                X Pixmap library
    libXrandr-1.4.2_3              X Resize and Rotate extension library
    libXrender-0.9.8_3             X Render extension library
    libXt-1.1.4_3,1                X Toolkit library
    libXv-1.0.10_3,1               X Video Extension library
    libXvMC-1.0.9                  X Video Extension Motion Compensation library
    libXxf86misc-1.0.3_3           X XF86-Misc Extension
    libXxf86vm-1.1.4_1             X Vidmode Extension
    libdevq-0.0.2_1                Generic Device Query and Monitor interface
    libdrm-2.4.60,1                Userspace interface to kernel Direct Rendering Module services
    libedit-3.1.20150325_1         Command line editor library
    libffi-3.2.1                   Foreign Function Interface
    libfontenc-1.1.2_3             The fontenc Library
    libglapi-10.6.8                Common GL api library used by Mesa based ports
    libpciaccess-0.13.3            Generic PCI access library
    libpthread-stubs-0.3_6         This library provides weak aliases for pthread functions
    libxcb-1.11_1                  The X protocol C-language Binding (XCB) library
    libxkbfile-1.0.8_3             XKB file library
    libxkbui-1.0.2_4               The xkbui library
    libxml2-2.9.2_3                XML parser library for GNOME
    libxshmfence-1.2               Shared memory 'SyncFence' synchronization primitive
    llvm36-3.6.2_2                 Low Level Virtual Machine
    pciids-20150924                Database of all known IDs used in PCI devices
    perl5-5.20.3_8                 Practical Extraction and Report Language
    pixman-0.32.6_1                Low-level pixel manipulation library
    pkg-1.6.1                      Package manager
    printproto-1.0.5               Print extension headers
    python27-2.7.10                Interpreted object-oriented programming language
    randrproto-1.4.1               Randr extension headers
    renderproto-0.11.1             RenderProto protocol headers
    sudo-1.8.14p3                  Allow others to run commands as root
    videoproto-2.3.2               Video extension headers
    virtualbox-ose-additions-4.3.30 VirtualBox additions for FreeBSD guests
    xextproto-7.3.0                XExt extension headers
    xf86miscproto-0.9.3            XFree86-Misc extension headers
    xf86vidmodeproto-2.3.1         XFree86-VidModeExtension extension headers
    xineramaproto-1.2.1            Xinerama extension headers
    xkbcomp-1.3.0                  Compile XKB keyboard description
    xkeyboard-config-2.14          X Keyboard Configuration Database
    xorg-server-1.14.7_6,1         X.Org X server and related programs
    xproto-7.0.27                  X11 protocol headers

