#include "defines.h"

#include <delays.h>

/* wait_n_sec()
@do
    Attendre jusqu'à 105 * 255 secondes
@param
    n       : nombre de secondes à attendre jusqu'à 105
    mux     : multiplicateur jusqu'à 255
*/
void wait_n_sec(Uint n, Uchar mux);

/* wait_n_msec()
@do
    Attendre jusqu'à 1057 * 255 millisecondes
@param
    n       : nombre de ms à attendre jusqu'à 1057
    mux     : multiplicateur jusqu'à 255
*/
void wait_n_msec(Uint n, Uchar mux);
