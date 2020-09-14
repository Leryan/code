#include <p18Cxxx.h>
#define USE_AND_MASKS
#include <pconfig.h>	// choix des fonctions en fonction du type de pic
#include <delays.h>
#include <stdio.h>
#include <timers.h>				// Timers
#include <usart.h>				// RS232
#include <portb.h>				// Interruptions Externes
#include "HardwareProfile.h"
#include "coucou.h"
#include "can.h"
#include "commun.h"
#include "lcd pic.h"
#include "config_hard.h"
#include "record_path.h"

#pragma config OSC = INTIO67	// horloge interne
//#pragma config OSC = HS		// horloge externe
#pragma config WDT = OFF		// whatch dog
#pragma config LVP = OFF

#define Rel1 PORTBbits.RB4
#define Rel2 PORTBbits.RB5

void Setup(void)
{
    PRESCL = 1; //Pretscaler à 16
    OSCCON	= 0x70; // 0 111 00 0 00pas de prédiviseur => 8MHz horloge interne
    /*REN = 1;
    TEN = 1;
    SEN = 1;
    IO_RX = !SORTIE;
    IO_TX = SORTIE;
    SPBRG = 8000000/9600/16;*/
    // Initialisation de la liaison série à 9600b
    OpenUSART(USART_TX_INT_OFF  &
              USART_RX_INT_OFF  &
              USART_ASYNCH_MODE &		// mode asynchrone
              USART_EIGHT_BIT   &		// 8bits
              USART_CONT_RX     &
              //USART_BRGH_HIGH,71);  // [(11059200/9600)/16]-1 si hrl ext
              USART_BRGH_HIGH, 51);  	// 51=[(8000000/9600)/16]-1	si hrl int 8MHz
    //USART_BRGH_HIGH, 207);// 207=[(8000000/2400)/16]-1	si hrl int 8MHz
}

void main(void)
{
    char c232;					// caractère reçu sur rs232
    int i;
    char string[27] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    char path[75];
    char cmd;
    i = 2011;
    //configuration des PORTbits BTs et LCD en Digital
    ADCON1 = TOUT_DIGIT;
    Setup();
    OpenLCD();
    puts("TEST\r");
    printf("valeur=%i\r", i);
#define BOUCLE 0

    for(; BOUCLE;)
    {
        if(DataRdyUSART())
        {
            write_path(get_path(), path);
        }

        PAUSE_x10ms(100);

        for(i = 0; i < 27; ++i)
        {
            putcUSART(string[i]);
            PAUSE_x10ms(5);
        }

        for(i = 0; i < 5; ++i)
        {
            putcUSART('A');
        }
    }

    CloseUSART();

    for(;;)
    {
        ;
    }
}
