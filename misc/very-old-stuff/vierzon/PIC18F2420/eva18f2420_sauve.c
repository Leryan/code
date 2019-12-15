#include <p18cxxx.h>
#include <delays.h>
#include <stdio.h>
#include <timers.h>		// Timers
#include <usart.h>		// RS232
#include <adc.h>		// CAN
#include <portb.h>		// Interruptions Externes

#include "HardwareProfile.h"
#define  USE_AND_MASKS

#pragma config OSC = INTIO67	// horloge interne
//#pragma config OSC = HS		// horloge externe
#pragma config WDT=OFF			// whatch dog

/********************************************************************************************************/
#define led1 PORTCbits.RC0
#define led2 PORTCbits.RC1



/********************************************************************************************************/
void Setup(void)
{
    TRISC = 0;			// Port C en Sortie
    OSCCON = 0x70;		//0 111 00 0 00pas de prédiviseur => 8MHz horloge interne
    // Initialisation de la liaison série à 9600b
    OpenUSART(USART_TX_INT_OFF  &
              USART_RX_INT_OFF  &
              USART_ASYNCH_MODE &
              USART_EIGHT_BIT   &
              USART_CONT_RX     &
              //USART_BRGH_HIGH,71);  // [(11059200/9600)/16]-1 si hrl ext
              USART_BRGH_HIGH, 51); // [(8000000/9600)/16]-1	si hrl int 8MHz
    // Init du convertisseur AD spécifique au pic18f2420  ADC_V5
    OpenADC(ADC_FOSC_32      &
            ADC_RIGHT_JUST   &
            ADC_12_TAD,
            ADC_CH0          &
            ADC_REF_VDD_VSS  &
            ADC_INT_OFF, ADC_1ANA);		// AN0=A AN1->AN12=D
    // Validation de l'interruption ext0 sur front descendant
    OpenRB0INT(PORTB_CHANGE_INT_ON &
               FALLING_EDGE_INT    &
               PORTB_PULLUPS_ON);
}
/********************************************************************************************************/
void main(void)
{
    unsigned int result;
    Setup();
    puts(" PIC16F2420 ");				// Prompt sur rs232
    SetChanADC(ADC_CH0);				// Select  AN0 du convertisseur

    for(;;)
    {
        /************************************************************************************************/
        // lecture du convertisseur AD
        ConvertADC();        			// Start conversion

        while(BusyADC())
        {
            ;    // Wait for completion
        }

        result = ReadADC();   			// Read result
        printf("can=%i\r\n", result);	// Envoi sur valeur convertie sur rs232
        /************************************************************************************************/
        led1 = !led1;						// Clignotement led
        DelayMs(50);
    }
}
/********************************************************************************************************/

/********************************************************************************************************/