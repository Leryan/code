#include "setup.h"

void setup_PORTS(void)
{
    //OUT
    TRISGbits.TRISG4 = OUT; //AFF1 / LED1
    TRISAbits.TRISA4 = OUT; //AFF2 / LED2
    TRISBbits.TRISB4 = OUT; //AFF2 / LED2
    TRISF = OUT;            //SEGMENTS
    TRISCbits.TRISC6 = OUT; //TX1
    //IN
    TRISBbits.TRISB0 = IN; //BP0
    TRISBbits.TRISB1 = IN; //BP1
    TRISBbits.TRISB2 = IN; //BP2
    TRISBbits.TRISB3 = IN; //BP3
    TRISCbits.TRISC7 = IN; //RX1
    TRISAbits.TRISA3 = IN; //ENTRE ANALOG CTN
}

void setup_IT(void)
{
    //Interruptions inactives
    INT_GIE = 0;
    INT0_IE = 0;
    INT1_IE = 0;
    INT2_IE = 0;
    INT3_IE = 0;
    //Configuration
    INT0_EDG = EDG_DOWN;
    INT1_EDG = EDG_DOWN;
    INT2_EDG = EDG_DOWN;
    INT3_EDG = EDG_DOWN;
}

void setup_TMR(void)
{
    //Timers inactifs
    TMR0_IE = 0;
    TMR1_IE = 0;
    TMR2_IE = 0;
    TMR3_IE = 0;
    //Configuration timer 0
    TMR0_ON = 0; //Arrêt
    TMR0_8B = 0; //8bits
    TMR0_OSC = 0; //OSC interne
    TMR0_EDG = 0; //front montant
    TMR0_PSA = 1; //prescaler
    TMR0_PSA2 = 1; //chargement à 2^(0x7 + 1) = 256
    TMR0_PSA1 = 1;
    TMR0_PSA0 = 1;
    TMR0H = (65535 - 123) / 256; //Chargement poids fort
    TMR0L = (65535 - 123) % 256; //Chargement poids faible
    //TMR0L = 133; //Pour multiplexage rapide afficheurs
    //Configuration timer 1
    //Configuration timer 2
    //Configuration timer 3
    //Configuration timer 4
}

void setup_CAN(Uchar chanel)
{
    while(AD_GO)
    {
        ;
    }

    //val = ADRESH * 256 + ADRESL; //Récupération du résultat du calcul sur 16bits.
    AD_VCFG1 = 0;
    AD_VCFG0 = 0;
    AD_CHS3 = (chanel >> 3) & 0x01;
    AD_CHS2 = (chanel >> 2) & 0x01;
    AD_CHS1 = (chanel >> 1) & 0x01;
    AD_CHS0 = (chanel) & 0x01;
    AD_GO = 0;
    AD_ON = 1;
    ADCON1 = 0b00100010; /* Justification Left
                            Calibration
                            2:0 : Temps chargement condo -> 8TAD = 8 * (Tck * 32)
                            Prédiv horloge par 32 -> Tck > 0.7us
                            25MHz = 0.4us
                            */
}

void setup_RS232(void)
{
    BRGH1 = 0;
    BRG16_1 = 0;
    SPBRGH1 = 0;
    SPBRG1 = 40; //fosc / (64 * vitesse) - 1
    SPEN1 = 1;
    SYNC1 = 0;
    CREN1 = 1;
    TX9_1 = 0; //Configuration du 9° bit
    RX9_1 = 0;
    TX1_EN = 1;
    RX1_EN = 1;
}