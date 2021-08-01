### qemu启动Linux内核

##### init 程序

```c
#include <stdio.h>
void main()
{
    printf("Hello World, I'm is the first programe.\n");
　　/*强制刷新输出，不然可能打印不出来*/
    fflush(stdout);
    while(1);
}
```

##### 静态编译

```shell
gcc -static -o helloworld helloworld.c
```

##### 制作rootfs

```shell
echo helloworld | cpio -o --format=newc > rootfs
```

##### qemu启动

```shell
qemu-system-x86_64   \
     -kernel ./bzImage \
     -initrd ./rootfs  \
     -append "root=/dev/ram rdinit=/helloworld"
```

![](https://cdn.jsdelivr.net/gh/Zauther/figurebed/imgs/20210801214558.png)



##### 附：

##### qemu编译安装

从https://www.qemu.org/ 下载源码

安装依赖

```shell
sudo apt-get install zlib1g-dev libglib2.0-dev libtool autoconf
```

配置

```shell
./configure 
# --prefix=/usr/bin/qemu --localstatedir=/var --sysconfdir=/etc
#--prefix用以指定安装的目的路径。默然qemu会安装到/usr/local/bin中
```

编译安装

```shell
make
```

