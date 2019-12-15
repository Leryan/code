#include "config_hard.h"

// Travail sur le Port B-FAIBLE
#define DATA_PORT      LATB
#define TRIS_DATA_PORT TRISB

// RS
#define RS_PIN   PORTAbits.RA3
#define TRIS_RS  TRISAbits.TRISA3

// Enable
#define E_PIN    PORTAbits.RA2
#define TRIS_E   TRISAbits.TRISA2

#define CMD 0
#define PUT 1
#define ADD_CG  0x40
#define ADD_LG1 0x80
#define ADD_LG2 0xC0

//         _____________
//________/MessageLCDram\_______________________________________
// Affichage *SourceRAM sur LCD (affichage remplacé)
void MessageLCDram(char *m);
//         _____________
//________/MessageLCDrom\_______________________________________
// Affichage *SourceROM sur LCD (affichage remplacé)
void MessageLCDrom(const rom char *m);

void EffaceLCD(void);
void OpenLCD(void);
void Aff_MSG_LCD(ram char *truc, const rom char *msg);

