#include "config_hard.h"

void MessageSERIE(char *m);
void delay(Uint);
//         ________
//________/Dec65535\_________________________
// Converti un DOUBLE-OCTET en ASCIIZ decimal
// remplace le %d d'un printf (ici LIBRARY trop gourmande en code)
void Dec65535(Uchar *, Uint);
//         ______
//________/Dec255\____________________
// Converti un OCTET en ASCIIZ decimal
// remplace le %d d'un printf (ici LIBRARY trop gourmande en code)
void Dec255(Uchar *, Uchar);
//         ______
//________/Hex255\________________________
// Converti un OCTET en ASCIIZ hexadecimal
// remplace le %0X d'un printf (ici LIBRARY trop gourmande en code)
void Hex255(Uchar *, Uchar);
//         ________
//________/CopieRAM\________________________________
// Copie de chaines de caracteres *Dest = *SourceRAM
// -------------------------------------------------
// remplace le strcpy (dans string.h)
void CopieRAM(Uchar *, Uchar *);
//         ________
//________/CopieROM\________________________________
// Copie de chaines de caracteres *Dest = *SourceROM
void CopieROM(Uchar *, const rom char *);
//         _________
//________/ConCatRAM\_______________________________________
// Concatenation de 2 ch. caract. *Dest = *Dest & *SourceRAM
// ---------------------------------------------------------
// remplace le strcat (dans string.h)
void ConCatRAM(Uchar *, Uchar *);
//         _________
//________/ConCatRAM\_______________________________________
// Concatenation de 2 ch. caract. *Dest = *Dest & *SourceROM
void ConCatROM(Uchar *, const rom char *);
//         _______
//________/Bourrer\_______________________________________
// Complete un chaine par des <SP> pour LG=char caract�res
void Bourrer(Uchar *, Uchar);
