
    jmp entry

entry:   
    ;; BIOS会把512字节的引导扇区加载到 0000:7c00 处，
    ;; 然后跳转到0000:7c00处，将控制权交给引导代码。
    org 07c00h                  ;这一行告诉编译器，我们的代码将被加载到7c00处。
    mov ax, cs                  ;CS对应于内存中的存放代码的内存区域，用来存放内存代码段区域的入口地址（段基址）
                                ;AX为8086CPU微处理器中8个通用寄存器之一，AX、BX、CX、DX这四个主要用于存放数据，称为数据寄存器
                                ;
    mov ds, ax                  ;DS, 数据段寄存器DS（Data Segment）：指出当前程序使用的数据所存放段的最低地址，即存放数据段的段基址
                                ; 
    mov es, ax                  ;ES 附加段寄存器ES：存放当前执行程序中一个辅助数据段的段地址

    ;; 到这里，代码段寄存器CS 数据段寄存器DS 附加段寄存器ES 全部为代码段寄存器CS，




    call  DispStr               ;调用显示字符串例程
    jmp fin
    ;jmp $                       ;无限循环, $表示当前行编译后的地址
    ;; 以上就是整个程序的执行过程了
    ;; 下面是DispStr子程序
fin:
    hlt
    jmp fin

DispStr:
    mov ax, BootMessage         ;将字符串首地址传给寄存器ax
    mov bp, ax                  ;CPU将用ES:BP来寻址字符串
    mov cx, 16                  ;通过CX，CPU知道字符串的长度
    mov ax, 01301h              ;AH=13表示13号中断, AL=01H，表示目标字符串仅仅包含字符，属性在BL中包含，移动光标
    mov bx, 000ch               ;黑底红字, BL=0CH，高亮
    mov dl, 0                   ;dh表示在第几行显示，dl表示第几列显示
    int 10h                     ;BIOS的10H中断的13号中断用于显示字符串
    ret
BootMessage:    
	db 0x0a, 0x0a
    db "Hello, OS world!  " ;对NASM来讲，标号和变量的作用一样, db表示define byte
    db 0x0a
    ;; $当前行被汇编后的地址，$$表示一个section开始处的地址，本程序只有一个section，所以指0x7c00
    times 510-($-$$) db 0           ;填充剩下空间，使生成的二进制恰好为512字节
    dw 0xaa55                       ;结束标志，如果发现扇区以0xAA55结束，则BIOS认为它是一个引导扇区，dw表示define word