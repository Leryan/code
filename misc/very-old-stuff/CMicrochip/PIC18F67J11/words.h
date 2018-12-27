#include "defines.h"

/* Uchar get_bit_n(Uchar val, Uchar n);
@do
    R�cup�re le bit n de val
@param
    val     : valeur � traiter
    n       : bit n
*/
Uchar get_bit_n(Uchar val, Uchar n);

/* Uchar rot_left(Uchar val, Uchar n);
@do
    Rotation sur n bits � gauche
@param
    val     : valeur � traiter
    n       : rotation sur n bits � partir du poid faible
*/
Uchar rot_left(Uchar val, Uchar n);

/* Uchar rot_right(Uchar val, Uchar n, Uchar n_val);
@do
    Rotation sur n bits � droite
@param
    val     : valeur � traiter
    n       : rotation sur n bits
*/
Uchar rot_right(Uchar val, Uchar n, Uchar n_val);
