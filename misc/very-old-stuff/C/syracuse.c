#include <stdio.h>

int main(void)
{
    unsigned long iters;
    unsigned long value;
    unsigned long max_value;
    unsigned long score;
    unsigned long calc;
    unsigned char x;
    score = 0;
    iters = 0;
    for(value = 5; iters < 700; value++)
    {
        iters = 0;
        calc = value;
        //Calcul de la suite de syracuse.
        while(calc != 1)
        {
            if(calc & 0x01)
            {
                calc = (3 * calc + 1) / 2;
                iters++;
            }
            else
            {
                calc /= 2;
            }
            iters++;
        }
        if(iters > score)
        {
            score = iters;
            max_value = value;
            printf("%ld with %ld numbers.\n", value, iters);
        }
    }
}
