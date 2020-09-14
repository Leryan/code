#include "defines.h"

/* Tableaux de sélection d'un caractère à afficheur sur 7seg */
/* HEXA
static const rom unsigned char aff7segHEX[16] = {AFF7SEG_0,
                                                 AFF7SEG_1,
                                                 AFF7SEG_2,
                                                 AFF7SEG_3,
                                                 AFF7SEG_4,
                                                 AFF7SEG_5,
                                                 AFF7SEG_6,
                                                 AFF7SEG_7,
                                                 AFF7SEG_8,
                                                 AFF7SEG_9,
                                                 AFF7SEG_A,
                                                 AFF7SEG_B,
                                                 AFF7SEG_C,
                                                 AFF7SEG_D,
                                                 AFF7SEG_E,
                                                 AFF7SEG_F};
statis const rom unsigned char *ptr_aff7seg = aff7segHEX;
*/
//* DEC
static const rom unsigned char aff7segDEC[10] = {AFF7SEG_0,
        AFF7SEG_1,
        AFF7SEG_2,
        AFF7SEG_3,
        AFF7SEG_4,
        AFF7SEG_5,
        AFF7SEG_6,
        AFF7SEG_7,
        AFF7SEG_8,
        AFF7SEG_9
                                                };
static const rom unsigned char *ptr_aff7seg = aff7segDEC;
//*/
/*****************/

static Uchar uchar_cpt0;
static Uchar uchar_blink_TMR0;
static Uint uint_blink_TMR0;
static char tmp_txt_17[17];
static char mode;
static Uchar res_can_8;
