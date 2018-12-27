#include <p18f67j11.h>
#include <stdlib.h>
#include <string.h>

#include "config_P18F67J11.h"

#include "defines.h"
#include "wait.h"
#include "setup.h"
#include "lcd.h"
#include "rs232.h"
#include "string_lcd.h"
#include "common_vars.h"

void mode_auto(void);
void mode_manu(void);
Uchar read_CAN8(Uchar chanel);
void concatRAM(char *src, char *dest, char sec, char sep);

#pragma interruptlow run_INT_LOW
void run_INT_LOW(void)
{
    static int i;

    /* Les tests sont effectués à la suite en
    vérifiant si l'interruption associée
    est autorisée : même si elle ne l'est pas
    le flag monte à 1 si elle a été reçue.
    */
    if(INT0_FLAG & INT0_IE)
    {
        wait_n_msec(ANTI_REBONDS_MS, 1);  //Anti rebonds

        if(uchar_cpt0++ == 99)
        {
            uchar_cpt0 = 0;
        }

        INT0_FLAG = 0;
    }

    if(INT1_FLAG & INT1_IE)
    {
        wait_n_msec(ANTI_REBONDS_MS, 1);  //Anti rebonds

        if(uchar_cpt0-- == 0)
        {
            uchar_cpt0 = 99;
        }

        INT1_FLAG = 0;
    }

    if(INT2_FLAG & INT2_IE)
    {
        wait_n_msec(ANTI_REBONDS_MS, 1);  //Anti rebonds

        for(i = 0; i < 17; ++i)
        {
            tmp_txt_17[i] = '\0';
        }

        res_can_8 = read_CAN8(AN_POT);
        itoa(res_can_8, tmp_txt_17);
        CleanLCD();
        MessageLCDram(tmp_txt_17);
        INT2_FLAG = 0;
    }

    if(INT3_FLAG & INT3_IE)
    {
        wait_n_msec(ANTI_REBONDS_MS, 1);  //Anti rebonds
        mode = !mode;
        INT3_FLAG = 0;
    }

    if(TMR0_FLAG & TMR0_IE)  //Timer 1 utilisé pour le multiplexage des afficheurs
    {
        TMR0H = uchar_blink_TMR0;
        TMR0L = (uchar_blink_TMR0 * 256) % 256; //Rechargement poid faible

        if(AFF2)  //Si afficheur 1 allumé -> affichage poid fort
        {
            SEGMENTS = ptr_aff7seg[uchar_cpt0 / 10];
            AFF1 = AFF2 = !AFF2;
        }
        else //Si afficheur 2 allumé -> affichage poid faible
        {
            SEGMENTS = ptr_aff7seg[uchar_cpt0 % 10];
            AFF2 = AFF1 = !AFF1;
        }

        TMR0_FLAG = 0;
    }

    if(TMR1_FLAG & TMR1_IE)
    {
        TMR1_FLAG = 0;
    }
}

#pragma interrupt run_INT_HIGH
void run_INT_HIGH(void)
{
}

#pragma code vector_INT_LOW = 0x08
void vector_IT_LOW(void)
{
    _asm
    goto run_INT_LOW
    _endasm
}
#pragma code

#pragma code vector_INT_HIGH = 0x18
void vector_INT_HIGH(void)
{
    _asm
    goto run_INT_HIGH
    _endasm
}
#pragma code

void main(void)
{
    char c;
    char str[17];
    char i;
    char mode_old;
    setup_PORTS();
    setup_IT();
    setup_TMR();
    setup_RS232();
    OpenLCD();
    AFF1 = OFF;
    AFF2 = ON;
    LED3 = OFF;
    //Interruptions classiques
    INT0_IE = 1;
    INT1_IE = 1;
    INT2_IE = 1;
    INT3_IE = 1;
    //Interruptions timers
    TMR0_IE = 1;
    //Autorisation générale des interruptions
    INT_GIE = 1;
    TMR0_ON = 1; //Lancement du timer 0
    SEGMENTS = ptr_aff7seg[0];
    mode = 1;
    mode_old = !mode;

    // DEBUT TÂCHE DE FOND
    while(1)
    {
        if(mode_old != mode)
        {
            switch(mode)
            {
            case 1:
                    CleanLCD();
                break;
            case 0:
                    MessageLCDrom("  Mode Manuel   ");
                break;
            default:
                    break;
            }

            mode_old = mode;
        }

        if(mode)
        {
            mode_auto();
        }
        else
        {
            mode_manu();
        }
    }
}

void concatRAM(char *src, char *dest, char sec, char sep)
{
    while((*dest != sec) && *dest)
    {
        dest++;
    }

    dest += sep;

    while(*src && *dest)
    {
        *dest++ = *src++;
    }
}

Uchar read_CAN8(Uchar chanel)
{
    while(AD_GO)
    {
        ;
    }

    setup_CAN(chanel);
    AD_GO = 1;

    while(AD_GO)
    {
        ;
    }

    return ADRESH;
}

void mode_auto(void)
{
    Uchar consigne;
    Uchar temp;
    char str[17];
    Uchar i;
    init_str(tmp_txt_17, 17, ' ');
    init_str(str, 17, ' ');
    consigne = read_CAN8(AN_POT);
    temp = read_CAN8(AN_CTN);

    if(temp > consigne + 20)
    {
        LED3 = OFF;
    }
    else if(temp < consigne - 20)
    {
        LED3 = ON;
    }

    itoa(temp, tmp_txt_17);
    clean_str(tmp_txt_17, 17, ' ');
    strcpy(str, tmp_txt_17);
    init_str(tmp_txt_17, 17, ' ');
    itoa(consigne, tmp_txt_17);
    clean_str(tmp_txt_17, 17, ' ');
    concatRAM(tmp_txt_17, str, ' ', 3);
    MessageLCDram(str);
}

void mode_manu(void)
{
}

/* ANCIENNES TÂCHES DE FOND */

/*
void main(void)
{
    char c;
    char str[17];
    char i;

    setup_PORTS();
    setup_IT();
    setup_TMR();
    setup_RS232();
    OpenLCD();

    AFF1 = OFF;
    AFF2 = ON;
    LED3 = OFF;

    //Interruptions classiques
    INT0_IE = 1;
    INT1_IE = 1;
    INT2_IE = 1;
    INT3_IE = 0;
    //Interruptions timers
    TMR0_IE = 1;
    //Autorisation générale des interruptions
    INT_GIE = 1;

    TMR0_ON = 1; //Lancement du timer 0

    SEGMENTS = ptr_aff7seg[0];
    //DEBUT TÂCHE DE FOND
    init_str(str, 17, ' ');
    MessageLCDram(str);
    rs232_str_ful(str);
    MessageLCDram(str);

    while(1)
    {
        rs232_str_dec(str);
        putc(str[15]);
        MessageLCDram(str);
    }
}
*/