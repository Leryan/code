#include "config_hard.h"

#define demConv		ADCON0bits.GO
#define busyCAN		demConv
#define en10bits	ADCON2bits.ADFM

typedef struct
{
    Uchar L;
    Uchar H;
} s2;
// UNION pour exploiter les 2 octets d'une DATA 16b
typedef union
{
    Uint w16;
    s2 w8;
} hhll;

//         _____________
//________/initCANnbVoie\___________________
// nb: 		nombre de voies ANA (1 � 12)
// taille:	bits de conversion; 8 ou 10 bits
void initCANnbVoie(Uchar nb, Uchar taille);
//         __________
//________/LectureCAN\________________________________
// num:		num�ro x de la voie ANAx lue (1 � 12)
// valeur convertie sur un DOUBLE OCTET (XXXX ou ..XX)
Uint LectureCAN(Uchar num);
