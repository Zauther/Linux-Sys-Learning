### Linux 内核编译

安装依赖

```shell
sudo apt-get update
sudo apt-get install bison
sudo apt-get install flex
sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc
```
下载内核

```shell
curl  https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.13.7.tar.xz -O
```

解压内核

```
xz -d linux-5.13.7.tar.xz
tar xvf linux-5.13.7.tar
cd linux-5.13.7
```

编译

```shell
make menuconfig
```

执行编译

```shell
make bzImage -j 12
```

`-j` 指定编译线程数

内核的各种类型

> bzImage是vmlinuz经过gzip压缩后的文件，适用于大内核
>
> vmlinux是未压缩的内核
>
> vmlinuz是vmlinux的压缩文件。
>
> vmlinux 是ELF文件，即编译出来的最原始的文件。
>
> vmlinuz应该是由ELF文件vmlinux经过OBJCOPY后，并经过压缩后的文件
>
> zImage是vmlinuz经过gzip压缩后的文件，适用于小内核

