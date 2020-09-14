#include "defines.h"

/* Uchar get_bit_n(Uchar val, Uchar n);
@do
    Récupère le bit n de val
@param
    val     : valeur à traiter
    n       : bit n
*/
Uchar get_bit_n(Uchar val, Uchar n);

/* Uchar rot_left(Uchar val, Uchar n);
@do
    Rotation sur n bits à gauche
@param
    val     : valeur à traiter
    n       : rotation sur n bits à partir du poid faible
*/
Uchar rot_left(Uchar val, Uchar n);

/* Uchar rot_right(Uchar val, Uchar n, Uchar n_val);
@do
    Rotation sur n bits à droite
@param
    val     : valeur à traiter
    n       : rotation sur n bits
*/
Uchar rot_right(Uchar val, Uchar n, Uchar n_val);
