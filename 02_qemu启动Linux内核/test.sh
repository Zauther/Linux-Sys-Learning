# gcc -static -o helloworld.out helloworld.c
# echo helloworld.out | cpio -o --format=newc > rootfs
# qemu-system-x86_64   \
#      -kernel ./bzImage \
#      -initrd ./rootfs  \
#      -append "root=/dev/ram rdinit=/helloworld.out"



make helloworld rootfs run