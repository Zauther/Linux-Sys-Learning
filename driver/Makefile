ifneq ($(KERNELRELEASE),)

    obj-m := hello.o

else

    KERN_DIR ?= /home/zauther/workspace/WSL2-Linux-Kernel-linux-msft-wsl-5.10.y/
    PWD := $(shell pwd)

default:
    $(MAKE) -C $(KERN_DIR) M=$(PWD) modules

endif


clean:
    rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions