#include <p18Cxxx.h>
#include <usart.h>

#include "record_path.h"

void write_path(char cmd, char *path, char reset)
{
    if(reset)
    {
        i_path = 0;
    }

    if(i_path < 76)
    {
        * (path + i_path) = cmd;
        ++i_path;
    }
}

void read_path(char *path)
{
    switch(* (path + i_path))
    {
    case 0:
        putsUSART("End of transmission.");
        break;
    case 1:
        putcUSART('z');
        break;
    case 2:
        putcUSART('q');
        break;
    case 3:
        putcUSART('s');
        break;
    case 4:
        putcUSART('d');
        break;
    default:
        putsUSART("Default");
        break;
    }
}

char get_path(void)
{
    switch(ReadUSART())
    {
    case 'z':
        cmd = 1;
        break;
    case 'q':
        cmd = 2;
        break;
    case 's':
        cmd = 3;
        break;
    case 'd':
        cmd = 4;
        break;
    default:
        cmd = 0;
        break;
    }

    return cmd;
}
