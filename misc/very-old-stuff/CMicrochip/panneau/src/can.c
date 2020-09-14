#include "can.h"

void initCANnbVoie(Uchar nb, Uchar taille)
{
    Uchar voie, i;
    nb--;
    voie = 0x0E;

    for(i = 0; i < nb; i++)
    {
        voie--;
    }

    ADCON1 = voie; // Ref=alim + AN0 en analogique
    ADCON2 = 0x00; // Fosc/2, tTad=0	(tavernier ADCON2)

    if(taille == 10)
    {
        en10bits = 1;    // dans ce cas CONV sur 10 bits
    }
}

Uint LectureCAN(Uchar num)
{
    hhll Can; // UNION de deux octets (Can.w8.H et Can.w8.L)
    ADCON0 = num * 4 + 1; //===== (*4)  ANAnum en analog 		(+01) GO=0 et ADON=1
    demConv = 1;

    while(busyCAN)
    {
        ;    // demande de conversion puis ATTENTE
    }

    if(en10bits)
    {
        Can.w8.H = ADRESH;
        Can.w8.L = ADRESL;
    } // lecture CAN en 10 bits
    else
    {
        Can.w8.L = ADRESH;    // lecture CAN en 8 bits
    }

    return Can.w16; // valeur convertie
}
