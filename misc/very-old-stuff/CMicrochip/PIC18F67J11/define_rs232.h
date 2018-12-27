/* RS232 */

#define BRGH1 TXSTA1bits.BRGH
#define BRG16_1 BAUDCON1bits.BRG16
#define SPEN1 RCSTA1bits.SPEN
#define SYNC1 TXSTA1bits.SYNC
#define TX9_1 TXSTA1bits.TX9 //Et pas TX9D qui sert à stocker la valeur du 9° bit
#define RX9_1 RCSTA1bits.RX9
#define TX1_EN TXSTA1bits.TXEN
#define RX1_EN RCSTA1bits.CREN
#define TRMT1 TXSTA1bits.TRMT
#define RC1IF PIR1bits.RC1IF
#define CREN1 RCSTA1bits.CREN