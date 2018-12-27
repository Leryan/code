#include <p18cxxx.h>
#define  USE_AND_MASKS
#include <pconfig.h>	// choix des fonctions en fonction du type de pic
#include <delays.h>
#include <stdio.h>
#include <timers.h>		// Timers
#include <usart.h>		// RS232
#include <adc.h>		// CAN
#include <portb.h>		// Interruptions Externes
#include <pwm.h>		// PWM
#include "HardwareProfile.h"
#pragma config OSC = INTIO67	// horloge interne
//#pragma config OSC = HS		// horloge externe
#pragma config WDT=OFF			// whatch dog
#pragma config LVP = OFF
/***********************************************************************************************/
#define Rel1 PORTBbits.RB4
#define Rel2 PORTBbits.RB5
/***********************************************************************************************/
//  D.Nardi
/***********************************************************************************************/
void Setup(void)
{
    TRISA = 0xFC;;			// PortA
    TRISB = 0;				// PortB en sortie
    TRISC = 0;				// Port C en Sortie
    OSCCON = 0x70;			// 0 111 00 0 00pas de prédiviseur => 8MHz horloge interne
    ADCON1 = 0x0D;			// AN0 et AN1 = A toutes les autres entrées en analogique D
    INTCON2bits.RBPU = 0;	// PullUP PortB ON
    // Initialisation de la liaison série à 9600b
    OpenUSART(USART_TX_INT_OFF  &
              USART_RX_INT_OFF  &
              USART_ASYNCH_MODE &		// mode asynchrone
              USART_EIGHT_BIT   &		// 8bits
              USART_CONT_RX     &
              //USART_BRGH_HIGH,71);  // [(11059200/9600)/16]-1 si hrl ext
              USART_BRGH_HIGH, 51);  	// 51=[(8000000/9600)/16]-1	si hrl int 8MHz
    // 207=[(8000000/2400)/16]-1	si hrl int 8MHz
    // Init du convertisseur AD spécifique au pic18f2420  ADC_V5
    OpenADC(ADC_FOSC_32      &
            ADC_RIGHT_JUST   &		// résultat de coversion sur 2oct justifié à droite
            ADC_12_TAD,
            ADC_CH0          &		// AN0
            ADC_REF_VDD_VSS  &
            ADC_INT_OFF, ADC_1ANA); // AN0=A AN1->AN12=D
}

/*******************************************************************************************/
void main(void)
{
    unsigned int result;				// résultat de conversion CAN
    unsigned char car;					// caractère reçu sur rs232
    long int j;
    Setup();
    puts("\r");							// Initialisation
    puts(" PIC16F2420\r ");				// Prompt sur rs232
    SetChanADC(ADC_CH0);				// Select  AN0 du convertisseur
    SetDCPWM1(512);						// Rapport cyclique 50% sur RC2/PWM1
    Rel1 = 1;
    Rel2 = 1;

    for(;;)
    {
        /***********************************************************************************/
        // lecture du convertisseur AD
        ConvertADC();        			// Start conversion

        while(BusyADC())
        {
            ;    // Wait for completion
        }

        result = ReadADC();   			// Read result
        printf("can=%i\r\n", result);	// Envoi sur valeur convertie sur rs232

        while(!DataRdyUSART())
        {
            ;    // Attend un caractere reçu sur la liaison rs232
        }

        car = ReadUSART();				// lecture du caractère reçu sur rs232

        while(car != 0x61)
        {
            ;    // Attend tant que le caractere est different de "a"
        }

        puts(" ");						// blanc
        Rel1 = 0;

        for(j = 1; j < 10000; j = j + 1)
        {
            ;    // Tempo
        }

        Rel1 = 1;
        /***********************************************************************************/
    }
}
