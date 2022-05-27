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



##### RUST

> 默认情况下，Rust 将静态链接所有 Rust 代码。但是，如果使用标准库，它将动态链接到系统的 `libc` 实现。
>
> 如果您想要100％静态二进制文件，可以在 Linux 上使用 [`MUSL libc`](https://www.musl-libc.org/)
>
> ```shell
> rustup target add x86_64-unknown-linux-musl
> ```
>
> 如果你不确定你想要什么，对于64位 Linux，它可能是 `x86_64-unknown-linux-musl`。 我们将在本指南中使用此目标，但其他目标的说明保持不变，只需在我们提及目标的位置更改名称。
>
> 要获得对此目标的支持，请使用 `rustup`：
>
> ```console
> $ rustup target add x86_64-unknown-linux-musl
> ```
>
> 这将安装对默认工具链的支持; 要安装其他工具链，请添加 `--toolchain` 标志。例如：
>
> ```console
> $ rustup target add x86_64-unknown-linux-musl --toolchain=nightly
> ```
>
> 要使用这个新目标，请将 `--target` 标志传递给 Cargo：
>
> ```console
> $ cargo build --target x86_64-unknown-linux-musl
> ```
>
> 生成的二进制文件现在将使用 MUSL 构建！



```shell
cargo new helloworld
cd helloworld 
cargo build --target x86_64-unknown-linux-musl
```

![](https://cdn.jsdelivr.net/gh/Zauther/figurebed/imgs/20210801221346.png)



