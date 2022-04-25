

boot_main.o: boot_main.c
	 as -gstabs -o boot_main.o boot_main.c
boot.bin: boot.asm
	nasm boot.asm -o boot.bin
run: boot.bin
	qemu-system-x86_64 -boot order=a -fda boot.bin

clean:
	rm  boot.bin *.img *.o