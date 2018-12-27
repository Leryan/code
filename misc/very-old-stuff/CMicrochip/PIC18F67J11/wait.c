#include "wait.h"

void wait_n_sec(Uint n, Uchar mux)
{
    for(n *= 620; n > 0; --n)
    {
        Delay10KTCYx(mux);
    }
}

void wait_n_msec(Uint n, Uchar mux)
{
    for(n *= 62; n > 0; --n)
    {
        Delay100TCYx(mux);
    }
}