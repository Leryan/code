#include "words.h"

Uchar get_bit_n(Uchar val, Uchar n)
{
    --n;
    return (val >> n) & 0x1;
}

Uchar rot_left(Uchar val, Uchar n)
{
    if(get_bit_n(val, n))
    {
        val <<= 1;
        val |= 0x1;
    }
    else
    {
        val <<= 1;
    }

    return val;
}

Uchar rot_right(Uchar val, Uchar n, Uchar n_val)
{
    --n;

    if(!(val & 0x01))
    {
        val >>= 1;
        val &= ~((7 - n) << n);
    }
    else //val & 0x01 == 1
    {
        val >>= 1;
        val |= (0x01 << n);
    }

    if(!n_val)
    {
        val |= 0x80;
    }

    return val;
}