// F. Chaxel 2008 d'après code D. Dubosc pour 8031

#include <p18cxxx.h>
#include <delays.h>
#include "lcd.h"

#define CMD 0
#define PUT 1
#define ADD_CG 0x40
#define ADD_LG1 0x80
#define ADD_LG2 0xC0

// Travail sur le Port E
#define DATA_PORT      LATE
#define TRIS_DATA_PORT TRISE

// RS
#define RS_PIN   PORTEbits.RE4
#define TRIS_RS  TRISEbits.TRISE4

// Enable
#define E_PIN    PORTEbits.RE5
#define TRIS_E   TRISEbits.TRISE5

#if defined(__18F67J11)
#define CLOCK_FREQ			(25000000ul)      // Hz
#else
#define CLOCK_FREQ			(41666667ul)      // Hz
#endif

#define GetSystemClock()		CLOCK_FREQ
#define GetInstructionClock()	(GetSystemClock()/4)
#define GetPeripheralClock()	GetInstructionClock()

#define Delay10us(us)		Delay10TCYx(((GetInstructionClock()/1000000)*us))
#define DelayMs(ms)												\
do																\
{																\
	unsigned int _iTemp = (ms); 								\
	while(_iTemp--)												\
		Delay1KTCYx((GetInstructionClock()+999999)/1000000);	\
} while(0)

unsigned char AddCar;

// ****************************************************************************************
void EcrireLCDdemi(unsigned char c, unsigned char Put_Cmd)
{
    RS_PIN = Put_Cmd;
    DATA_PORT &= 0xf0;
    DATA_PORT |= c;
    E_PIN = 1;                      // Clock the cmd in
    Nop();
    E_PIN = 0;
    Delay10us(46);
}
// ****************************************************************************************
void EcrireLCD(unsigned char c, unsigned char Put_Cmd)
{
    EcrireLCDdemi((c >> 4) & 0x0F, Put_Cmd);
    EcrireLCDdemi(c & 0x0F, Put_Cmd);
}
// ****************************************************************************************
void EffaceLCD(void)
{
    AddCar = ADD_LG1;
    EcrireLCD(1, CMD);
    DelayMs(2);  //efface ecran avec respect des (1.6+0.04) ms
}
// ****************************************************************************************
void AffCar(char ch)
{
    if(AddCar == ADD_LG1 + 8)
    {
        AddCar = ADD_LG2;
        EcrireLCD(AddCar, CMD);  // saut  (2eme lg en DD RAM)
    }

    EcrireLCD(ch, PUT);
    AddCar++;
}
// ****************************************************************************************
void MessageLCDram(char *m)
{
    AddCar = ADD_LG1;
    EcrireLCD(AddCar, CMD);

    while(*m != 0)
    {
        AffCar(*m++);
    }
}
// ****************************************************************************************
void MessageLCDrom(const rom char *m)
{
    AddCar = ADD_LG1;
    EcrireLCD(AddCar, CMD);

    while(*m != 0)
    {
        AffCar(*m++);
    }
}
// ****************************************************************************************
void OpenLCD(void)
{
    DATA_PORT &= 0xf0;
    TRIS_DATA_PORT |= 0x0f;
    TRIS_RS = 0;
    TRIS_E = 0;
    RS_PIN = 0;                     // select pin
    E_PIN = 0; 						// enable pin
    DelayMs(15);
    TRIS_DATA_PORT &= 0xf0;
    EcrireLCDdemi(3, CMD);
    DelayMs(5);
    EcrireLCDdemi(3, CMD);
    DelayMs(1);
    EcrireLCDdemi(3, CMD);
    DelayMs(1);
    EcrireLCDdemi(2, CMD);            //on force en mode 4bits (un seul demi-octet)
    EcrireLCD(0x28, CMD);  //......................, 2 lignes, 5x7 pix
    EcrireLCD(0x0C, CMD);  //Display=ON, Cursor=OFF, Blink=OFF
    EcrireLCD(6, CMD);    //Inc, NO shift
    EffaceLCD();
}
