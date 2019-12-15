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
#include <time.h>
#include <string.h>

char *alea_gen(int len, char *charas);

int main(int argc, char *argv[])
{
    char *password = NULL;
    char *alpha = NULL;
    int len;
    int i;
    srand(time(NULL));
    alpha = "abcdefghijklm01234nopqrstuvwxyzABCDEFGHIJKLM56789NOPQRSTUVWXYZ";

    if(argc > 1)
    {
        len = atoi(argv[1]);
    }

    if(argc == 3)
    {
        if(atoi(argv[2]) == 2)
        {
            alpha = "abcdefghijklm01234nopqrstuvwxyz&~|@#{[-_}])(!:.;?,ABCDEFGHIJKLM56789NOPQRSTUVWXYZ";
        }
        else
        {
            puts("Mode alphanumérique.\n");
        }
    }
    else
    {
        len = 12;
    }

    password = alea_gen(len, alpha);

    for(i = 0; i < len; i++)
    {
        putc(password[i], stdout);
    }

    putchar('\n');
    free(password);
    return 0;
}

char *alea_gen(int len, char *charas)
{
    char *word = malloc(sizeof(char) * len);
    int i;
    int len_ = strlen(charas);

    for(i = 0; i < len; i++)
    {
        word[i] = charas[rand() % len_];
    }

    return word;
}
