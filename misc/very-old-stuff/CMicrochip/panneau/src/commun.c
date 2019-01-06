#include "commun.h"

/* ===============================================================================================
| Fonctions propres a la gestion des chaines de caract�res
================================================================================================*/

// Converti x en ASCIIZ decimal et le copie dans *txt
// --------------------------------------------------
// remplace le %d d'un printf (ici LIBRARY trop gourmande en code)
//             ==============

void Dec65535(Uchar *txt, Uint x)
{
    Uint n;
    Uchar posi;
    posi = 0;
    n = x / 10000;
    x = x % 10000;

    if(n != 0)
    {
        txt[posi++] = n + '0';
    }

    n = x / 1000;
    x = x % 1000;

    if((n != 0) || (posi != 0))
    {
        txt[posi++] = n + '0';
    }

    n = x / 100;
    x = x % 100;

    if((n != 0) || (posi != 0))
    {
        txt[posi++] = n + '0';
    }

    n = x / 10;
    x = x % 10;

    if((n != 0) || (posi != 0))
    {
        txt[posi++] = n + '0';
    }

    txt[posi++] = x + '0';
    txt[posi] = 0;
}

void Dec255(Uchar *txt, Uchar x)
{
    Uchar n, posi;
    posi = 0;
    n = x / 100;
    x = x % 100;

    if(n != 0)
    {
        txt[posi++] = n + '0';
    }

    n = x / 10;
    x = x % 10;

    if((n != 0) || (posi != 0))
    {
        txt[posi++] = n + '0';
    }

    txt[posi++] = x + '0';
    txt[posi] = 0;
}

// Converti x en ASCIIZ hexadecimal et le copie dans *txt
// ------------------------------------------------------
// remplace le %x d'un printf (ici LIBRARY trop gourmande en code)
//             ==============

void Hex255(Uchar *txt, Uchar x)
{
    Uchar n, posi;
    posi = 0;
    n = x / 16;

    if(n > 9)
    {
        n = n + 7;
    }

    txt[posi++] = n + '0';
    x = x % 16;

    if(x > 9)
    {
        x = x + 7;
    }

    txt[posi++] = x + '0';
    txt[posi++] = 'h';
    txt[posi] = 0;
}

// Copie de chaines de caracteres *Dest = *Source
// --------------------------------------------------------------
// remplace le strcpy (dans string.h, ici LIBRARY trop gourmande en code)
//             ======

void CopieRAM(Uchar *Dest, Uchar *Source)
{
    do
    {
        *Dest++ = *Source++;
    }
    while(* Source);

    *Dest = 0;
}

void CopieROM(Uchar *Dest, const rom char *Source)
{
    do
    {
        *Dest++ = *Source++;
    }
    while(* Source);

    *Dest = 0;
}

// Concatenation de 2 chaines de caracteres *Dest = *Dest & *Source
// --------------------------------------------------------------
// remplace le strcat (dans string.h, ici LIBRARY trop gourmande en code)
//             ======

void ConCatRAM(Uchar *Dest, Uchar *Source)
{
    while(*Dest)
    {
        Dest++;    //se placer a la fin de la chaine
    }

    CopieRAM(Dest, Source);
}

void ConCatROM(Uchar *Dest, const rom char *Source)
{
    while(*Dest)
    {
        Dest++;    //se placer a la fin de la chaine
    }

    CopieROM(Dest, Source);
}

void Bourrer(Uchar *Dest, Uchar nb)
{
    Uchar x;
    x = 0;

    while(*Dest++)
    {
        x++;    //se placer a la fin de la chaine
    }

    Dest--;

    for(; x < nb; x++)
    {
        *Dest++ = ' ';
    }

    *Dest = 0;
}
