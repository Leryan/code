#include "rs232.h"

void putc(char c)
{
    while(!TRMT1)
    {
        ;    //Attendre que le tampon d'envoi soit vide
    }

    TXREG1 = c;
}

char getc(void)
{
    while(!RC1IF)
    {
        ;    //Attente de réception
    }

    return RCREG1;
}

void puts_rom(rom char *str)
{
    while(*str)
    {
        putc(*str++);
    }
}

void puts_ram(ram char *str)
{
    while(*str)
    {
        putc(*str++);
    }
}

char *gets(void)
{
}

void rs232_str_ful(char *str)
{
    char i;
    char size;
    size = strlen(str);

    for(i = 0; i < size; ++i)
    {
        str[i] = getc();
    }
}

void rs232_str_dec(char *str)
{
    dec_left_str(str);
    str[strlen(str) - 1] = getc();
}