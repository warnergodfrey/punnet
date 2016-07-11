# punnet

Example project demonstrating how to use packer to automate the creation of a raspberry pi SD card image

Includes a customised [Raspberry Pi kernel](https://github.com/dhruvvyas90/qemu-rpi-kernel) for emulating a Raspberry Pi on [QEMU](http://wiki.qemu.org/Main_Page).

Downloads a [customised](https://github.com/dhruvvyas90/qemu-rpi-kernel/wiki/Emulating-Jessie-image-with-4.x.xx-kernel) [raspbian jessie image](http://raspbian-qemu.s3-website-ap-southeast-2.amazonaws.com/2016-05-27-raspbian-jessie.img) as part of the packer build process.
