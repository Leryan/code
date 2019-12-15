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
#include <string.h>

char give_code(char *string, size_t len);

int main(int nbarg, char **argv)
{
    int one = 0;
    int two = 1;
    int number = 0;
    int i;
    int max;
    int n;
    int len;
    char *string = NULL;

    if(nbarg < 3)
    {
        max = 40;
        //string = malloc(sizeof(char) * 5);
        string = "LOST";
        len = 4;
    }
    else
    {
        len = strlen(argv[2]);
        string = malloc(sizeof(char) * len);
        string[len - 1] = '\0';

        for(i = 0; i < len; string[i] = argv[2][i], i++)
        {
            ;
        }

        max = atoi(argv[1]);
    }

    while(number < max)
    {
        for(n = 0; putchar(give_code(string, len)), n < len; n++)
            for(i = 0; i < number; putchar(' '), i++)
            {
                ;
            }

        putchar('\n');
        one = two;
        two = number;
        number += one;
    }

    if(nbarg > 2)
    {
        free(string);
    }

    getchar();
    return 0;
}

char give_code(char *string, size_t len)
{
    static size_t i = -1;

    if(i == len)
    {
        i = -1;
    }

    i++;
    return string[i];
}
