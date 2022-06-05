安装nasm编译器

```shell
sudo apt install nasm
```

boot

```nasm
    ;; BIOS会把512字节的引导扇区加载到 0000:7c00 处，
    ;; 然后跳转到0000:7c00处，将控制权交给引导代码。
    org 07c00h                  ;这一行告诉编译器，我们的代码将被加载到7c00处。
    mov ax, cs                  ;将代码段寄存器的值送入AX
    mov ds, ax                  ;将数据段的地址置为代码段的地址？
    mov es, ax                  ;将附加段的地址置为代码段的地址？
    call  DispStr               ;调用显示字符串例程
    jmp $                       ;无限循环, $表示当前行编译后的地址
    ;; 以上就是整个程序的执行过程了
    ;; 下面是DispStr子程序
DispStr:
    mov ax, BootMessage         ;将字符串首地址传给寄存器ax
    mov bp, ax                  ;CPU将用ES:BP来寻址字符串
    mov cx, 16                  ;通过CX，CPU知道字符串的长度
    mov ax, 01301h              ;AH=13表示13号中断, AL=01H，表示目标字符串仅仅包含字符，属性在BL中包含，移动光标
    mov bx, 000ch               ;黑底红字, BL=0CH，高亮
    mov dl, 0                   ;dh表示在第几行显示，dl表示第几列显示
    int 10h                     ;BIOS的10H中断的13号中断用于显示字符串
    ret
BootMessage:    db "Hello, OS world!" ;对NASM来讲，标号和变量的作用一样, db表示define byte
    ;; $当前行被汇编后的地址，$$表示一个section开始处的地址，本程序只有一个section，所以指0x7c00
    times 510-($-$$) db 0           ;填充剩下空间，使生成的二进制恰好为512字节
    dw 0xaa55                       ;结束标志，如果发现扇区以0xAA55结束，则BIOS认为它是一个引导扇区，dw表示define word
```

- AX为8086CPU微处理器中8个通用寄存器之一，AX、BX、CX、DX这四个主要用于存放数据，称为数据寄存器

- CS的全拼为“Code Segment”，翻译为“代码段寄存器”，对应于内存中的存放代码的内存区域，用来存放内存代码段区域的入口地址（段基址）

- 指令指针寄存器（IP，Instruction Pointer）来确定要执行的下一条指令的内存地址

- DS, 数据段寄存器DS（Data Segment）：指出当前程序使用的数据所存放段的最低地址，即存放数据段的段基址

- SS (Stack Segment)，SS被称为堆栈段寄存器，用于存放堆栈段的基值

- ES 附加段寄存器ES：存放当前执行程序中一个辅助数据段的段地址。

- SP 堆栈指针



![](https://bkimg.cdn.bcebos.com/pic/a044ad345982b2b79b99199d3eadcbef76099b60?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2U5Mg==,g_7,xp_5,yp_5/format,f_auto)





编译

```shell
nasm boot.asm -o boot.bin
```

```shell
dd if=/dev/zero of=emptydisk.img bs=512 count=2880 #生成空白软盘镜像文件
dd if=boot.bin of=boot.img bs=512 count=1 #用 bin file 生成对应的镜像文件
dd if=emptydisk.img of=boot.img skip=1 seek=1 bs=512 count=2879 #在 bin 生成的镜像文件后补上空白，成为合适大小的软盘镜像
```

```shell
qemu-system-x86_64 -boot order=a -fda boot.bin
```

![](https://cdn.jsdelivr.net/gh/Zauther/figurebed/imgs/20220425210055.png)

re

https://segmentfault.com/a/1190000002664653
