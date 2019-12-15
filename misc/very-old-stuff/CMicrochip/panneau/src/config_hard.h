#include <p18cxxx.h>
#include <delays.h>

//****************A DEFINIR pour la compilation***************
#define H_8MHZ // FREQUENCE clk (sinon H_25MHZ)
#define FAIBLE // data LCD sur demi-octet FAIBLE (sinon FORT voir LCD pic.C)
//************************************************************

typedef unsigned int Uint;
typedef unsigned char Uchar;

#define SORTIE	0
#define TOUT_DIGIT	0xF

#ifdef H_8MHZ
#define OSC_PROG 0x72	/* 0 111 0 0 10pas de pr�diviseur => 8MHz horloge interne */
#define PAUSE_x10us(us) Delay10TCYx(2*(us))		/* valeur parametre <=127 */
#define PAUSE_x10ms(ms) Delay10KTCYx(2*(ms))	/* valeur parametre <=127 */
#define PAUSE_ms(us) 	Delay100TCYx(20*(us))	/* valeur parametre <=12  */
#endif
#ifdef H_4MHZ
#define OSC_PROG 0x62	/* 0 110 0 0 10pas de pr�diviseur => 4MHz horloge interne */
#define PAUSE_x10us(us) Delay10TCYx(us)			/* valeur parametre <=255 */
#define PAUSE_x10ms(ms) Delay10KTCYx(ms)		/* valeur parametre <=255 */
#define PAUSE_ms(us) 	Delay100TCYx(10*(us))	/* valeur parametre <=25  */
#endif
#ifdef H_25MHZ
#define PAUSE_x10us(us)  Delay10TCYx(6*(us))	/* valeur parametre <=42 */
#define PAUSE_x100us(us) Delay10TCYx(62*(us))	/* valeur parametre <=4  */
#define PAUSE_ms(ms) 	 Delay100TCYx(62*(ms))	/* valeur parametre <=4  */
#define PAUSE_x10ms(ms)  Delay1KTCYx(62*(ms))	/* valeur parametre <=4  */
#define PAUSE_x100ms(ms) Delay10KTCYx(62*(ms))	/* valeur parametre <=4  */
#endif

