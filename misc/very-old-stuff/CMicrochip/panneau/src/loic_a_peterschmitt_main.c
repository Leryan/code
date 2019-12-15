/*

	alips_peterschmitt_main.c

	Loic	A.
	Florent PETERSCHMITT

	Derniere modification : 22 Juin 2011 11h42
*/

#include <p18cxxx.h>
#include <string.h>
#include "coucou.h"
#include "can.h"
#include "commun.h"
#include "lcd_pic.h"
#include "config_hard.h"

//Horloge interne, SANS whatch dog
#pragma config  OSC = INTIO67
#pragma config  WDT=OFF
#pragma config  LVP=OFF

#define TVEILLE			10	//Temps avant mise en veille dans le menu
#define DECALAGE        4	//Decalage pour centrage de l'heure
#define SIZE_STR_LCD    17	//Taille d'une chaine ASCII pour ecran LCD 16 digits

#define CleanLCD()  MessageLCDrom("                "); //J'aime pas EffaceLCD();
#define INT_GIE     INTCONbits.GIE
#define TMR0_FLAG   INTCONbits.TMR0IF
#define TMR0_IE     INTCONbits.TMR0IE
#define TMR0_ON     T0CONbits.TMR0ON

/*  Je reste tant que PAS (BPcentre ET (BPgauche OU BPdroit)) enfonces :
    -> Equation         :   !(!BPcentre & (!BPgauche | !BPdroit))
    -> Simplification   :   BPcentre | (BPgauche & BPdroit)
*/
#define COND_WHILE  (BPcentre | (BPgauche & BPdroit))
#define EN_VEILLE	(Veille >= TVEILLE)

/* GLOB VAR */
Uchar Consigne = 35;
Uchar CptTMR;
Uchar MsgHeure[SIZE_STR_LCD];
Uchar Quit = 0;
Uchar Menus[][SIZE_STR_LCD] =  {"<-    AUTO    ->",
                                "<-    MANU    ->",
                                "<-  REGLAGES  ->",
                                "MODE AUTOMATIQUE",
                                "<- G        D ->",
                                "     GAUCHE     ",
                                "     DROITE     ",
                                "<-  CONSIGNE  ->",
                                "<-   HEURE    ->"
                               };
Uchar LocalTime[3];
Uchar Veille;

/* PROTOTYPES */
Uchar ReadCAN(Uchar voie);
Uchar SubAbs(Uchar val1, Uchar val2);
void CalculHeure(void);
void CleanSTR(Uchar *str, Uchar size, Uchar c);
void CopieSTR(Uchar *src, Uchar *dest, Uchar posi);
void InitSTR(Uchar *str, Uchar size, Uchar c);
void MenuReglage(void);
void MiseEnVeille(void);
void ModeManu(void);
void ModeAuto(void);
void RecupHeure(void);
void ReglageHeure(void);
void ReglageConsigne(void);
void RelacheBPs(void);
void SetupTMR(void);

/* INT */
#pragma interruptlow run_INT_LOW
void run_INT_LOW(void)
{
    if(TMR0_FLAG & TMR0_IE)
    {
        TMR0L = 256 - 78;   //Rechargement du timer : 8bit, psc = 256
        //TMR0L = 256 - 5;  //Rechargement du timer : 8bit, psc = 256 //Pour tester.
        CptTMR++;          	//Incrementation du compteur 10 millisec

        if(CptTMR == 100) 	//Ca veut dire qu'on a atteint 1 sec
        {
            CptTMR = 0;
            Veille++;		//Incrementation de la veille
            LocalTime[2]++; //Incrementation des secondes
            CalculHeure();	//Calcul de l'heure
            RecupHeure(); 	//Recupere l'heure dans MsgHeure pour pouvoir l'afficher partout
        }

        TMR0_FLAG = 0;
    }
}

#pragma code vector_INT_LOW = 0x08
void vector_INT_LOW(void)
{
    _asm
    goto run_INT_LOW
    _endasm
}
#pragma code

/* FONCTIONS CREES */
/*
	void CopieSTR(Uchar *src, Uchar *dest, Uchar posi);

	Copie une chaine src dans dest jusqu'a fin de chaine de str non inclu
	a partir de dest[posi]
*/
void CopieSTR(Uchar *src, Uchar *dest, Uchar posi)
{
    Uchar i;

    for(i = 0; src[i]; i++)
    {
        dest[i + posi] = src[i];
    }
}

/*
	void MiseEnVeille(void);

	Pour avoir l'affichage de l'heure au bout de TVEILLE
	secondes d'inactivite sur le pupitre
*/
void MiseEnVeille(void)
{
    if(!(BPcentre & BPdroit & BPgauche))
    {
        Veille = 0;
        RelacheBPs();
    }
    else if(EN_VEILLE)
    {
        Veille = TVEILLE;
        MessageLCDram(MsgHeure);
    }
}

/*
	void CalculHeure(void);

	Calcul de l'heure pour ne pas avoir 255:100:10...
*/
void CalculHeure(void)
{
    /*
        Time[2] -> Secondes
        Time[1] -> Minutes
        Time[0] -> Heures
     */
    if(LocalTime[2] > 59)  //Si arrive a 60 secondes OU PLUS (initialisation)
    {
        LocalTime[2] = 0;   //Remise a zero
        LocalTime[1]++;     //Incrementation des minutes
    }

    if(LocalTime[1] > 59)  //Et on recommence avec les minutes et les heures
    {
        LocalTime[1] = 0;
        LocalTime[0]++;
    }

    if(LocalTime[0] > 23)
    {
        LocalTime[0] = 0;
    }
}

/*
    void CleanSTR(Uchar *str, Uchar size, Uchar c);

    Remplace tous les caracteres 00 d'une chaine de taille TOTALE size par c.
*/
void CleanSTR(Uchar *str, Uchar size, Uchar c)
{
    char i;
    --size; //Pour prendre en compte la fin de chaine

    for(i = 0; i < size; ++i)
    {
        if(str[i] == '\0')
        {
            str[i] = c;
        }
    }

    str[i] = '\0';  //Ici on est arrive a la valeur size -> fin de chaine
}

/*
    void InitSTR(Uchar *str, Uchar size, Uchar c);

    Initialise une chaine de taille TOTALE size avec le caractere c.
*/
void InitSTR(Uchar *str, Uchar size, Uchar c)
{
    char i;
    --size; //Pour prendre en compte la fin de chaine

    for(i = 0; i < size; ++i)
    {
        str[i] = c;
    }

    str[i] = '\0';
}

/*
    void MenuReglage(void);

    Fonction dediee a l'affichage du menu de reglage.
    Le gros probleme c'est qu'une fois entre la dedans, cette fonction
    remplace la tache de fond et si on y fait des choses, bah elles ne se font
    pas.

    Non, vous n'aimez vraiment pas ca.

    Moi non plus.

    Et le pire c'est que c'est partout comme ca !
*/
void MenuReglage(void)
{
    Uchar i = 7;
    CleanLCD(); //Y'a plus rien a voir

    do
    {
        if(!BPgauche | !BPdroit)
        {
            if(i == 7)
            {
                i = 8;
            }
            else
            {
                i = 7;
            }
        }
        else if(!BPcentre)
        {
            while(!BPcentre)
            {
                ;
            }

            switch(i)
            {
            case 7:
                    ReglageConsigne();
                break;
            case 8:
                    ReglageHeure();
                break;
            default:
                    break;
            }
        }

        RelacheBPs();
        MessageLCDram(Menus[i]);
    }
    while(!Quit);

    Quit = 0;
}

/*
    void ModeAuto(void);

    Mode automatique.
*/
void ModeAuto(void)
{
    Uchar txt[2][4];
    Uchar MsgAuto[17];
    Uint CAN_P[2];
    MessageLCDram(Menus[3]);
    PAUSE_x10ms(100);

    do
    {
        Veille = 0;
        CopieRAM(MsgAuto, MsgHeure);
        //Lecture des CAN et conversion Uchar -> Uchar[]
        CAN_P[0] = 255 - ReadCAN(0);
        CAN_P[1] = 255 - ReadCAN(1);
        Dec255(txt[0], CAN_P[0]);
        Dec255(txt[1], CAN_P[1]);
        //Trucs moches pour afficher les valeurs.
        CleanLCD();
        CopieSTR(txt[0], MsgAuto, 0);
        CopieSTR(txt[1], MsgAuto, 13);
        MessageLCDram(MsgAuto);

        //Commande du panneau par hysteresis reglable avec Consigne
        if(SubAbs(CAN_P[0], CAN_P[1]) > Consigne)
        {
            //Dans quel sens faut-il tourner ?
            if(CAN_P[0] > CAN_P[1])
            {
                RelaisV = 0;
                RelaisR = 0;
            }
            else
            {
                RelaisV = 0;
                RelaisR = 1;
            }
        }
        else
        {
            RelaisV = RelaisR = 1;
        }

        PAUSE_x10ms(25);
    }
    while(COND_WHILE);

    RelacheBPs();
}

/*
	void ModeManu(void);

	Mode manuel.
*/
void ModeManu(void)
{
    //RelaisV = 0 pour mise en marche du moteur
    do
    {
        while(!BPgauche & BPcentre)
        {
            MessageLCDram(Menus[5]);
            RelaisV = 0;
            RelaisR = 1;
        }

        while(!BPdroit & BPcentre)
        {
            MessageLCDram(Menus[6]);
            RelaisV = 0;
            RelaisR = 0;
        }

        PAUSE_x10ms(25);
        RelaisR = RelaisV = 1;
        MessageLCDram(Menus[4]);
        PAUSE_x10ms(25);
    }
    while(COND_WHILE);

    RelacheBPs();
}

/*
    void RelacheBPs(void)

    Permet, quand on l'appel, d'attendre le relachement de tous les BP.
*/
void RelacheBPs(void)
{
    //Je tourne tant qu'un ou plusieurs boutons sont enfoncÃ©s
    /*
    while(!BPgauche | !BPdroit);
    while(!BPcentre);
    */
    while(!BPcentre | !BPgauche | !BPdroit)
    {
        ;
    }
}

/*
    Uchar SubAbs(Uchar val1, Uchar val2);

    Retourne la soustraction de val1 et val2 en valeur absolue.
*/
Uchar SubAbs(Uchar val1, Uchar val2)
{
    if(val1 >= val2)
    {
        return val1 - val2;
    }
    else
    {
        return val2 - val1;
    }
}

/*
    void ReglageConsigne(void);

    Fonction de reglage de la consigne.
*/
void ReglageConsigne(void)
{
    Uchar resultat[] = "   ";
    Uchar txt[] = "Consigne :   ";
    Uchar res[17] = "Consigne :   ";
    Quit = 1;
    CleanLCD();

    do
    {
        if(!BPdroit)
        {
            ++Consigne;
        }
        else if(!BPgauche)
        {
            --Consigne;
        }

        PAUSE_x10ms(15);
        CleanLCD();
        Dec255(resultat, Consigne);
        ConCatRAM(res, resultat);
        MessageLCDram(res);
        CopieRAM(res, txt);
        CopieROM(resultat, " ");
    }
    while(BPcentre);

    RelacheBPs();
}

/*
	void RecupHeure(void)

	Formatage de l'heure dans la chaine MsgHeure
*/
void RecupHeure(void)
{
    Uchar txt[3];
    Uchar i;
    InitSTR(MsgHeure, SIZE_STR_LCD, ' ');

    if(CptTMR == 0 | TMR0_ON == 0)  //N'importequelle valeur entre 0 et 100.
    {
        for(i = 0; i < 3; i++)
        {
            Dec255(txt, LocalTime[i]);

            if(LocalTime[i] < 10)
            {
                MsgHeure[DECALAGE + 0 + 3 * i] = '0';
                MsgHeure[DECALAGE + 1 + 3 * i] = txt[0];
            }
            else
            {
                MsgHeure[DECALAGE + 0 + 3 * i] = txt[0];
                MsgHeure[DECALAGE + 1 + 3 * i] = txt[1];
            }
        }

        MsgHeure[DECALAGE + 2] = ':';
        MsgHeure[DECALAGE + 5] = ':';
    }
}

/*
    void ReglageHeure(void);

    Le nom de la fonction est tres mal choisie mais permet d'afficher l'heure
    qui n'a absolument pas ete reglee.
*/
void ReglageHeure(void)
{
    Uchar i = 0;
    Quit = 1;
    TMR0_ON = 0;

    do
    {
        /* */
        if(!BPgauche & BPcentre)
        {
            LocalTime[i]--;
        }
        else if(!BPdroit & BPcentre)
        {
            LocalTime[i]++;
        }
        else if(!BPcentre & BPgauche & BPdroit)
        {
            while(!BPcentre)
            {
                ;
            }

            ++i;
        }

        CalculHeure();
        RecupHeure();
        MessageLCDram(MsgHeure);
        PAUSE_x10ms(15);
    }
    while(i < 2);

    TMR0_ON = 1;
}

/*
    void SetupTMR(void);

    Configuration du Timer 0
*/
void SetupTMR(void)
{
    CptTMR = 0;
    //Timer inactif
    TMR0_IE = 0;
    //Configuration timer 0
    /*  -> Arret;
        -> 8bits;
        -> OSC interne;
        -> front montant (osef);
        -> prescaler actif;
        -> chargement psc a 2^(0x7 + 1) = 256;
    */
    T0CON = 0b01000111;
    /*  Chargement poid fort
        -> comptage 78
        -> Tcy = 0.5us
        -> 78 * 0.5us * 256 = 9.984ms
    */
    TMR0L = 256 - 78;
}

/* FONCTION _PAS_ CREE */
Uchar ReadCAN(Uchar voie)
{
    Uchar Capteur;
    Uint tmp;
    ADCON0 = 4 * voie + 1;
    ADCON2bits.ADFM = 1; //conv ds ADRESH et ADRESL
    ADCON0bits.GO = 1;

    while(ADCON0bits.GO == 1)
    {
        ;
    }

    Capteur = ADRESL / 4;
    tmp = ADRESH * 64;
    Capteur = Capteur + tmp;
    return (Capteur);
}

/* MAIN */
void main(void)
{
    Uchar i;
    ADCON1 = TOUT_DIGIT;
#ifndef H_25MHZ
    OSCCON = OSC_PROG;
#endif
    TRIS_RelR = SORTIE;
    TRIS_RelV = SORTIE;
    TRISAbits.TRISA0 = 1;
    TRISAbits.TRISA1 = 1;
    RelaisR = RelaisV = 1;  //Relais eteints
    SetupTMR();             //Configuration du timer0
    initCANnbVoie(0, 8);    //Configuration des CAN
    initCANnbVoie(1, 8);
    OpenLCD();
    Veille = 0;
    TMR0_IE = 1;
    INT_GIE = 1;
    TMR0_ON = 1;
    MessageLCDrom("    Bienvenue   ");
    //Pauses tres laides pour laisser afficher le menu un certain temps.
    PAUSE_x10ms(100);
    PAUSE_x10ms(100);
    ModeAuto();

    /*  Tache de fond dont on profite pour mettre l'indice de menu a 0

        Dans tous les cas, on se debrouille pour qu'une commande (appui sur BP)
        ne soit actif qu'au relachement.
    */
    for(i = 0;;)
    {
        RelaisV = RelaisR = 1;  /*  Quand on quitte le mode auto on s'assure
                                    que les relais ne sont pas actifs */

        if(!EN_VEILLE)
        {
            /*  Calcul de l'indice de menu.
                /!\ cet indice est en correspondance avec le tableau Menus[][17] */
            if(!BPgauche)
            {
                if(i == 0)
                {
                    i = 2;
                }
                else
                {
                    --i;
                }

                Veille = 0;
            }
            else if(!BPdroit)
            {
                i = ++i % 3;
                Veille = 0;
            }
            //Si appui sur le bouton de validation
            else if(!BPcentre)
            {
                while(!BPcentre)
                {
                    ;    //Attente du relachement du BPcentre
                }

                switch(i)           //Kekonfe ?
                {
                case 0:
                        ModeAuto();
                    break;
                case 1:
                        ModeManu();
                    break;
                case 2:
                        MenuReglage();
                    break;
                default:
                        break;
                }

                Veille = 0;	//Une fois sorti des fonctions on reset la Veille
            }

            RelacheBPs(); /*Attente du relachement des deux BP
	                            avant d'afficher le menu. */
            MessageLCDram(Menus[i]);    //Affichage du menu
        }
        else
        {
            MiseEnVeille();
        }
    }
}
/*
 * MPLAB X dit 12% de RAM et 32% de ROM utilisee. Pas terrible.
*/
