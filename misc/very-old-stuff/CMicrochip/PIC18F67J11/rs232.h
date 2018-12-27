#include <string.h>
#include "defines.h"
#include "lcd.h"
#include "string_lcd.h"

void putc(char);
char getc(void);
void puts_rom(rom char *str);
void puts_ram(ram char *str);
char *gets(void);
void rs232_str_ful(char *str);
void rs232_str_dec(char *str);
