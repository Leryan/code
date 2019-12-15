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

void rotate3(char **mat, int size);

int main(int argc, char **argv)
{
    int S;
    int i, j;
    char **mat;
    char c;

    if(argc > 1)
    {
        S = atoi(argv[1]);
    }
    else
    {
        S = 9;
    }

    /***********************************************/
    mat = malloc(sizeof(char *) * S);

    for(i = 0 ; i < S ; i++)
    {
        mat[i] = malloc(sizeof(char) * S);
    }

    /***********************************************/
    for(i = 0 ; i < S ; i++)
    {
        for(j = 0 ; j < S ; j++)
        {
            c = 'A' + j + i;
            mat[i][j] = c;
        }
    }

    for(i = 0 ; i < S ; i++)
    {
        for(j = 0 ; j < S ; j++)
        {
            printf("[%c]", mat[i][j]);
        }

        putc('\n', stdout);
    }

    puts("");
    rotate3(mat, S);

    for(i = 0 ; i < S ; i++)
    {
        for(j = 0 ; j < S ; j++)
        {
            printf("[%c]", mat[i][j]);
        }

        puts("");
    }

    /******************************************/
    for(i = 0 ; i < S ; i++)
    {
        free(mat[i]);
    }

    free(mat);
    /*****************************************/
    return 0;
}

void rotate3(char **mat, int size)
{
    int T;
    int x, y;
    int i;
    int a;
    int count;
    int Tymax;
    int Txmax;
    static char C[2];

    if(size & 0x01)
    {
        T = (--size) / 2;
        Txmax = 0;
    }
    else
    {
        T = (size / 2);
        Txmax = 1;
    }

    Tymax = T + 1;

    for(i = 0 ; i < Tymax ; i++)
    {
        x = y = i;
        C[0] = mat[x][y];

        while(x < size - (i + Txmax))
        {
            for(count = 0 ; count < 4 ; count++)
            {
                a = y;
                y = - (x + Txmax - 2 * T);
                x = a;
                C[1] = mat[x][y];
                mat[x][y] = C[0];
                C[0] = C[1];
            }

            C[0] = mat[++x][y];
        }
    }
}
