#include <P18F67J11.h>
#pragma config FOSC = HS, WDTEN = OFF, XINST = OFF

#define SORTIE 0
#define ENTREE 1
#define LED1 LATGbits.LATG4
#define LED2 LATAbits.LATA4
#define COD_A PORTCbits.RC0
#define COD_B PORTCbits.RC1
#define ETEINTE 1
#define ALLUMEE 0

void main(void)
{
    TRISGbits.TRISG4 = SORTIE;
    TRISAbits.TRISA4 = SORTIE;
    TRISCbits.TRISC0 = ENTREE;
    TRISCbits.TRISC1 = ENTREE;
    TRISF = SORTIE;
    LATF = 0xFF;
    LED1 = ETEINTE;
    LED2 = ETEINTE;

    do
    {
        LED1 = !COD_A;
        LED2 = !COD_B;
    }
    while(1);
}
