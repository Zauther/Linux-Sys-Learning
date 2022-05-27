init: init.c
	 gcc -static -o init init.c
rootfs: init
	echo init | cpio -o --format=newc > rootfs
run: rootfs
	qemu-system-x86_64   \
	 -kernel ./bzImage \
     -initrd ./rootfs  \
     -append "root=/dev/ram rdinit=/init"

test: init
	./init

clean:
	rm  init rootfs