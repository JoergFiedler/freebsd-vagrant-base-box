# Create a FreeBSD Vagrant Box

Despite there are several [Vagrant boxes](http://www.vagrantbox.es/) available which run FreeBSD out of the box, it's good to know how to create such a box by yourself. An advantage might be, that the box comes with with only those packages installed you really need. That's why I decided to create a minimal FreeBSD box with only as much packages installed to run Ansible. With Ansible installed it's quite easy to perfectly adapt the box afterwards. 

### Create a VB virtual machine

1. Create an virtual machine with NAT enabled for the first network adapter and add set the adapter type to `virtio-net`. 

2. Add the [downloaded mfsBSD ISO](http://mfsbsd.vx.sk/) as bootable CD device.

3. Boot.

4. Login with `root` and `mfsroot`.

5. Mount the mfsBSD ISO.

        mount_cd9660 /dev/cd0 /cdrom`
        
6. Install FreeBSD.

        zfsinstall -d /dev/ada0 -u/cdrom/10.0-RELEASE-amd64 -s 4G
        
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
    bash-4.3.30                    The GNU Project's Bourne Again SHell
    ca_root_nss-3.17.1             The root certificate bundle from the Mozilla Project
    consolekit-0.4.3_1             Framework for defining and tracking users
    damageproto-1.2.1              Damage extension headers
    dbus-1.8.8                     Message bus system for inter-application communication
    dbus-glib-0.100.2_1            GLib bindings for the D-BUS messaging system
    dmidecode-2.12                 Tool for dumping DMI (SMBIOS) contents in human-readable format
    dri-9.1.7_5,2                  OpenGL hardware acceleration drivers for the DRI
    dri2proto-2.8                  DRI2 prototype headers
    expat-2.1.0_1                  XML 1.0 parser written in C
    fixesproto-5.0                 Fixes extension headers
    font-util-1.3.0_1              Create an index of X font files in a directory
    fontsproto-2.1.2,1             Fonts extension headers
    freetype2-2.5.3_2              Free and portable TrueType font rendering engine
    gettext-0.18.3.1_1             GNU gettext package
    glib-2.36.3_4                  Some useful routines of C programming (current stable version)
    gnome_subr-1.0                 Common startup and shutdown subroutines used by GNOME scripts
    gnomehier-3.0                  Utility port that creates the GNOME directory tree
    gobject-introspection-1.36.0_3 Generate interface introspection data for GObject libraries
    hal-0.5.14_27                  Hardware Abstraction Layer for simplifying device access
    indexinfo-0.2                  Utility to regenerate the GNU info page index
    kbproto-1.0.6                  KB extension headers
    libGL-9.1.7_2                  OpenGL library that renders using GLX or DRI
    libICE-1.0.9,1                 Inter Client Exchange library for X11
    libSM-1.2.2_2,1                Session Management library for X11
    libX11-1.6.2_2,1               X11 library
    libXau-1.0.8_2                 Authentication Protocol library for X11
    libXaw-1.0.12_2,2              X Athena Widgets library
    libXcursor-1.1.14_2            X client-side cursor loading library
    libXdamage-1.1.4_2             X Damage extension library
    libXdmcp-1.1.1_2               X Display Manager Control Protocol library
    libXext-1.3.2_2,1              X11 Extension library
    libXfixes-5.0.1_2              X Fixes extension library
    libXfont-1.4.8,2               X font library
    libXinerama-1.1.3_2,1          X11 Xinerama library
    libXmu-1.1.2_2,1               X Miscellaneous Utilities libraries
    libXp-1.0.2_2,1                X print library
    libXpm-3.5.11_2                X Pixmap library
    libXrandr-1.4.2_2              X Resize and Rotate extension library
    libXrender-0.9.8_2             X Render extension library
    libXt-1.1.4_2,1                X Toolkit library
    libXxf86misc-1.0.3_2           X XF86-Misc Extension
    libXxf86vm-1.1.3_2             X Vidmode Extension
    libdrm-2.4.52_1,1              Userspace interface to kernel Direct Rendering Module services
    libffi-3.0.13_2                Foreign Function Interface
    libfontenc-1.1.2_2             The fontenc Library
    libglapi-9.1.7_1               Common GL api library used by Mesa based ports
    libiconv-1.14_4                Character set conversion library
    libpciaccess-0.13.2_2          Generic PCI access library
    libpthread-stubs-0.3_6         This library provides weak aliases for pthread functions
    libvolume_id-0.81.1            Library to provide file system type information
    libxcb-1.10_2                  The X protocol C-language Binding (XCB) library
    libxkbfile-1.0.8_2             XKB file library
    libxkbui-1.0.2_3               The xkbui library
    libxml2-2.9.1_1                XML parser library for GNOME
    libxshmfence-1.1_3             Shared memory 'SyncFence' synchronization primitive
    pciids-20141004                Database of all known IDs used in PCI devices
    pcre-8.35_1                    Perl Compatible Regular Expressions library
    perl5-5.16.3_11                Practical Extraction and Report Language
    pixman-0.32.4_3                Low-level pixel manipulation library
    pkg-1.3.8_3                    Package manager
    policykit-0.9_8                Framework for controlling access to system-wide components
    polkit-0.105_3                 Framework for controlling access to system-wide components
    printproto-1.0.5               Print extension headers
    python2-2_3                    The "meta-port" for version 2 of the Python interpreter
    python27-2.7.8_5               Interpreted object-oriented programming language
    randrproto-1.4.0               Randr extension headers
    renderproto-0.11.1             RenderProto protocol headers
    sudo-1.8.10.p3_1               Allow others to run commands as root
    virtualbox-ose-additions-4.3.16_1 VirtualBox additions for FreeBSD guests
    xextproto-7.3.0                XExt extension headers
    xf86miscproto-0.9.3            XFree86-Misc extension headers
    xf86vidmodeproto-2.3.1         XFree86-VidModeExtension extension headers
    xineramaproto-1.2.1            Xinerama extension headers
    xkbcomp-1.2.4                  Compile XKB keyboard description
    xkeyboard-config-2.12          X Keyboard Configuration Database
    xorg-server-1.12.4_9,1         X.Org X server and related programs
    xproto-7.0.26                  X11 protocol headers
