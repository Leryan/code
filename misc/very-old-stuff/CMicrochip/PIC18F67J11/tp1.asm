; Ah que coucou !
#include <P18F67J11.INC>

a equ 0

CONFIG XINST = off, FOSC = HS, WDTEN = off ; XINST : jeu d'instruction réduit ; WDTEN : 
ORG 0

    bcf TRISA, 4, a
    bcf TRISB, 4, a
    bcf TRISG, 4, a
    clrf TRISF
bc1:
    setf LATF
    bcf LATG, 4, a
    bsf LATA, 4, a
    bcf LATB, 4, a
bra bc1

END