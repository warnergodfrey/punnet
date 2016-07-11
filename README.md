# punnet

Example project demonstrating how to use packer to automate the creation of a raspberry pi SD card image

Utilises a Qemu [kernel](https://github.com/dhruvvyas90/qemu-rpi-kernel) for emulating Rpi on QEMU.

Downloads a [customised](https://github.com/dhruvvyas90/qemu-rpi-kernel/wiki/Emulating-Jessie-image-with-4.x.xx-kernel) [raspbian jessie image](http://raspbian-qemu.s3-website-ap-southeast-2.amazonaws.com/2016-05-27-raspbian-jessie.img) as part of the packer build process.
