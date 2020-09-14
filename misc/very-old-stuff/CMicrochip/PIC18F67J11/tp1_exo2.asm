#include <P18F67J11.INC>

a equ 0
b equ 0

CONFIG XINST = off, FOSC = HS, WDTEN = off ; XINST : jeu d'instruction r�duit ; WDTEN : watch dog
ORG 0

; Port codeur en entr�e
bsf TRISC, 0, a
bsf TRISC, 1, a
; LED1 et LED2 en sortie
bcf TRISA, 4, a
bcf TRISB, 4, a
bcf TRISG, 4, a

bc1:
    ; d�codeur voie A
    btfss PORTC, 0, a
        bcf LATA, 4, a
    btfsc PORTC, 0, a
        bsf LATA, 4, a

    ; d�codeur voie B
    btfss PORTC, 1, a
        bcf LATG, 4, a
    btfsc PORTC, 1, a
        bsf LATG, 4, a
    ;
bra bc1

END