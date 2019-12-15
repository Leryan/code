/* PORTS */

//AFF (LED)
#define AFF1 LATGbits.LATG4
#define AFF2 LATAbits.LATA4
#define SEGMENTS LATF //7 sorties, octets utilisable mais attention au 8° bit

//LED (AFF)
#define LED1 LATGbits.LATG4
#define LED2 LATAbits.LATA4
#define LED3 LATBbits.LATB4

//BP
#define BP0 PORTBbits.RB0 //BP actif à 0
#define BP1 PORTBbits.RB1 //BP actif à 0
#define BP2 PORTBbits.RB2 //BP actif à 0
#define BP3 PORTBbits.RB3 //BP actif à 0

//AN
#define AN_POT 3
#define AN_CTN 4
/***************/