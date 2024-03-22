helloworld: helloworld.c
	gcc -static -o helloworld.out helloworld.c

rootfs: helloworld.out
	echo helloworld.out | cpio -o --format=newc > rootfs
	
run: rootfs
	qemu-system-x86_64   \
     -kernel ../01_build_kernel/bzImage \
     -initrd ./rootfs  \
     -append "root=/dev/ram rdinit=/helloworld.out"

