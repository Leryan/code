#include <P18F67J11.INC>

CBLOCK
    val : 1
    cpt1 : 1
    cpt2 : 1
    cpt3 : 1
ENDC

a equ 0
CONFIG XINST = off, FOSC = HS, WDTEN = off

ORG 0

bcf TRISG, 4, a
clrf TRISF

bcf LATG, 4, a
setf LATF

movlw 0xFE
movwf val, a

bc1:
    rlncf val, 1, a
    movff val, LATF

    ;tempo
    movlw 0xFF
    movwf cpt1
    movwf cpt2
    movlw 0x64
    movwf cpt3
    tempo1:
        dcfsnz cpt3, 1, a
        bra tempo1
        
        dcfsnz cpt2, 1, a
        bra tempo1
        
        decfsz cpt1, 1, a
        bra tempo1
            
        
    ;fin tempo
    bra bc1

END