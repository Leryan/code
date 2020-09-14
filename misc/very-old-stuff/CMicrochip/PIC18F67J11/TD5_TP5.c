#include <p18f67j11.h>

#define	LED3	LATBbits.LATB4
#define	IO_LED3	TRISBbits.TRISB4
#define	VALID	0
#define	SORTIE	0

// ------------------------------------------------redéfinitions de types
typedef	unsigned char	octet;

// ------------------------------------------------configuration
#pragma config 	FOSC = HS, WDTEN = OFF, XINST = OFF

// -----------------Bits de gestion du TIM0
#define _T0CS		T0CONbits.T0CS
#define _PSA		T0CONbits.PSA
#define _T08BIT		T0CONbits.T08BIT
#define _T0PS2		T0CONbits.T0PS2
#define _T0PS1		T0CONbits.T0PS1
#define _T0PS0		T0CONbits.T0PS0
#define _TMR0ON		T0CONbits.TMR0ON
#define _TMR0H		TMR0H
#define _TMR0L		TMR0L

#define _TMR0IF		INTCONbits.TMR0IF
#define _TMR0IE		INTCONbits.TMR0IE
#define _GIE		INTCONbits.GIE
#define VRAI		1

octet divH, divL;

void init_TIM()
{
    _T0CS = 0;
    _PSA = 0;
    _T0PS2 = _T0PS1 = _T0PS0 = 1;
    _T08BIT = 0;
    divH = (-24414u) / 0x100;
    divL = (-24414u) % 0x100;
    _TMR0H = divH;
    _TMR0L = divL;
    _TMR0ON = 1;
    _TMR0IE = VRAI;
}

#pragma interruptlow Tled3
void Tled3(void)
{
    if(_TMR0IF)
    {
        _TMR0H = divH;
        _TMR0L = divL;
        LED3 = !LED3;
        _TMR0IF = 0;
    }
}

/*              _____________________
_______________/ programme principal \________________
*/
void main()
{
    init_TIM();
    IO_LED3 =	SORTIE;
    _GIE = VRAI;

    for(;;)
    {
        ;
    }
}

#pragma code VecteurIT=0x8
void VecteurIT(void)
{
    _asm
    goto Tled3
    _endasm
}
