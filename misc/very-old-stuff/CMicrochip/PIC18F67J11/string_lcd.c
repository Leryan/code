#include "string_lcd.h"

void dec_left_str(char *str)
{
    while(* (++str))
    {
        * (str - 1) = *str;
    }
}

void init_str(char *str, char size, char c)
{
    char i;
    --size;

    for(i = 0; i < size; ++i)
    {
        str[i] = c;
    }

    str[i] = '\0';
}

void clean_str(char *str, char size, char c)
{
    char i;
    --size;

    while(*str && i < size)
    {
        str++;
        ++i;
    }

    if(i < size)
    {
        *str = c;
    }
}