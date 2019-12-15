// F. Chaxel 2008 d'après code D. Dubosc pour 8031
#include "lcd pic.h"
#include "commun.h"

unsigned char AddCar;

// ****************************************************************************************
void EcrireLCDdemi(unsigned char c, unsigned char Put_Cmd)
{
    RS_PIN = Put_Cmd;
#ifdef FAIBLE
    DATA_PORT &= 0xF0;
    DATA_PORT |= c;
#else
    DATA_PORT &= 0x0F;
    DATA_PORT |= (c << 4);
#endif
    E_PIN = 1;
    Nop();
    E_PIN = 0;
    PAUSE_x10us(5);	//50 µs
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
    PAUSE_ms(2);  //efface ecran avec respect des (1.6+0.04) ms
}
// ****************************************************************************************
void AffCar(char ch)
{
    if(AddCar == ADD_LG1 + 8)
    {
        AddCar = ADD_LG2;
        EcrireLCD(AddCar, CMD);  // saut 2eme lg en DD RAM
    }

    EcrireLCD(ch, PUT);
    AddCar++;
}
// ****************************************************************************************
void MessageLCDram(char *m)
{
    AddCar = ADD_LG1;
    EcrireLCD(AddCar, CMD);  // Position 1ère lg en DD RAM

    while(*m != 0)
    {
        AffCar(*m++);
    }
}
// ****************************************************************************************
void MessageLCDrom(const rom char *m)
{
    AddCar = ADD_LG1;
    EcrireLCD(AddCar, CMD);  // Position 1ère lg en DD RAM

    while(*m != 0)
    {
        AffCar(*m++);
    }
}
// ****************************************************************************************
void OpenLCD(void)
{
    // forcage port ZERO puis mise en SORTIE
#ifdef FAIBLE
    DATA_PORT &= 0xF0;
    TRIS_DATA_PORT &= 0xF0;
#else
    DATA_PORT &= 0x0F;
    TRIS_DATA_PORT &= 0x0F;
#endif
    RS_PIN = 0;
    TRIS_RS = 0;		// select pin
    E_PIN = 0;
    TRIS_E = 0;		 	// enable pin
    PAUSE_x10ms(20);		// pause de 200ms (RESET +long)
    EcrireLCDdemi(3, CMD);
    PAUSE_ms(5);
    EcrireLCDdemi(3, CMD);
    PAUSE_ms(1);
    EcrireLCDdemi(3, CMD);
    PAUSE_ms(1);
    EcrireLCDdemi(2, CMD);            //on force en mode 4bits (un seul demi-octet)
    EcrireLCD(0x28, CMD);  //......................, 2 lignes, 5x7 pix
    EcrireLCD(0x0C, CMD);  //Display=ON, Cursor=OFF, Blink=OFF
    EcrireLCD(6, CMD);    //Inc, NO shift
    EffaceLCD();
}