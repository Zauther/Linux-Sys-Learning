#!/bin/sh
gcc -static -o helloworld helloworld.c
echo helloworld | cpio -o --format=newc > rootfs