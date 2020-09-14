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

#define true 1
#define false 0

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef unsigned char bool;

/*♥ ♥ ♥ ♥ ♥ ♥  ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ */

int main(int argc, char **argv)
{
    int i;
    int j;
    short a;
    short maxdots;
    short lines;
    short icountlines;
    char mark;
    char *string;
    char howmuch;
    bool infinite;
    infinite = false;

    if(argc == 4)
    {
        lines = atoi(argv[1]);
        string = argv[2];
        maxdots = atoi(argv[3]);
    }
    else
    {
        maxdots = 7;
        string = "i love you";
        lines = 0;
        infinite = true;
    }

    mark = true;
    a = 0;
    icountlines = 0;

    while(infinite || icountlines < lines)
    {
        howmuch = 1;

        if(mark)
        {
            a++;
        }
        else
        {
            a--;
        }

        if(a == maxdots || a == 0)
        {
            mark = !mark;
            howmuch = 3;
        }

        for(j = 0; j < howmuch; j++)
        {
            for(i = 0; i < a; i++)
            {
                putc('.', stdout);
            }

            puts(string);
            usleep(200000);

            if(!infinite)
            {
                ++icountlines;
            }
        }
    }

    return 0;
}
