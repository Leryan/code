#include "config_hard.h"

//         ________
//________/Dec65535\_________________________
// Converti un DOUBLE-OCTET en ASCIIZ decimal
// remplace le %d d'un printf (ici LIBRARY trop gourmande en code)
void Dec65535(char *, unsigned int);
//         ______
//________/Dec255\____________________
// Converti un OCTET en ASCIIZ decimal
// remplace le %d d'un printf (ici LIBRARY trop gourmande en code)
void Dec255(char *, unsigned char);
//         ______
//________/Hex255\________________________
// Converti un OCTET en ASCIIZ hexadecimal
// remplace le %0X d'un printf (ici LIBRARY trop gourmande en code)
void Hex255(char *, unsigned char);
//         ________
//________/CopieRAM\________________________________
// Copie de chaines de caracteres *Dest = *SourceRAM
// -------------------------------------------------
// remplace le strcpy (dans string.h)
void CopieRAM(char *, char *);
//         ________
//________/CopieROM\________________________________
// Copie de chaines de caracteres *Dest = *SourceROM
void CopieROM(char *, const rom char *);
//         _________
//________/ConCatRAM\_______________________________________
// Concatenation de 2 ch. caract. *Dest = *Dest & *SourceRAM
// ---------------------------------------------------------
// remplace le strcat (dans string.h)
void ConCatRAM(char *, char *);
//         _________
//________/ConCatRAM\_______________________________________
// Concatenation de 2 ch. caract. *Dest = *Dest & *SourceROM
void ConCatROM(char *, const rom char *);
//         _______
//________/Bourrer\_______________________________________
// Complete un chaine par des <SP> pour LG=char caractères
void Bourrer(char *, char);
