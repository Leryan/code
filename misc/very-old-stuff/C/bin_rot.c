/* Copyright (c) 2010-2011, Florent PETERSCHMITT
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of Florent PETERSCHMITT nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/


#include <stdio.h>
#include <stdlib.h>

unsigned int BinRot(unsigned int n, unsigned int mask);
unsigned int MaskLength(unsigned int mask);
void DisplayBin(unsigned int n);

int main(void)
{
    unsigned int n = 0xAAAA;
    unsigned int mask = 0x400;
    printf("%d\n", n);
    DisplayBin(n);
    printf("%d\n",  n = BinRot(n, mask));
    DisplayBin(n);
    return 0;
}

unsigned int BinRot(unsigned int n, unsigned int mask)
{
    if((n & mask) != 0)
    {
        n <<= 1;
        n++;
    }
    else
    {
        n <<= 1;
    }

    return n & MaskLength(mask);
}

unsigned int MaskLength(unsigned int mask)
{
    int i;

    for(i = 0 ; (mask & 0x01) != 1 ; i++)
    {
        mask >>= 1;
    }

    while(i > 0)
    {
        mask = (mask << 1) + 1;
        i--;
    }

    return mask;
}

void DisplayBin(unsigned int n)
{
    int i;

    for(i = 1 ; n > 0 ; i++)
    {
        printf("%d", (n % 2));
        n /= 2;

        if(i / 4 == 1)
        {
            putc(' ', stdout);
            i = 0;
        }
    }

    putc('\n', stdout);
}
