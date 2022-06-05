void boot_hlt(void);

void boot_main(void) {
fin:
  boot_hlt();
  goto fin;
}