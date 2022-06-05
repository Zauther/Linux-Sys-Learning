GLOBAL	_io_hlt
[SECTION .text]		; 目标文件中写了这些后再写程序

_boot_hlt:	; void boot_hlt(void);
		HLT
		RET