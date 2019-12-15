#include "config_hard.h"

#define demConv		ADCON0bits.GO
#define busyCAN		demConv
#define en10bits	ADCON2bits.ADFM

typedef struct
{
    octet L;
    octet H;
} s2;
// UNION pour exploiter les 2 octets d'une DATA 16b
typedef union
{
    d_octet w16;
    s2 w8;
} hhll;

//         _____________
//________/initCANnbVoie\___________________
// nb: 		nombre de voies ANA (1 à 12)
// taille:	bits de conversion; 8 ou 10 bits
void initCANnbVoie(octet nb, octet taille);
//         __________
//________/LectureCAN\________________________________
// num:		numéro x de la voie ANAx lue (1 à 12)
// valeur convertie sur un DOUBLE OCTET (XXXX ou ..XX)
d_octet LectureCAN(octet num);
