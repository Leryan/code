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
#include <ctype.h>

int zIdentificator(char *word)
{
    static const char *keywords[] =
    {
        "auto", "break", "case", "char", "const", "continue", "default",
        "do", "double", "else", "enum", "extern", "float", "for", "goto",
        "if", "inline", "int", "long", "register", "restrict", "return",
        "short", "signed", "sizeof", "static", "struct", "switch",
        "typedef", "union", "unsigned", "void", "volatile", "while",
        "_Bool", "_Complex", "_Imaginary"
    };
    int i;
    char *id = word;

    if(word == NULL)
    {
        return 0;
    }

    if((*word++ == '_' && (*word == '_' || isupper(*word))) || isdigit(*--word))
    {
        return 0;
    }

    while(*word != '\0')
    {
        if(!isalnum(*word) && *word != '_')
        {
            return 0;
        }

        ++word;
    }

    for(i = 0 ; i < 37 ; i++)
    {
        if(!strcmp(keywords[i], id))
        {
            return 0;
        }
    }

    return 1;
}

int main()
{
    char *words[] = {"a",
                     "anaconda",
                     "AnAcondA42",
                     "anaConda_42",
                     "_aNacOnda",
                     "AnAc_OnDa",
                     "_42anaconda_",
                     "AnAc OnDa",
                     "42_anaconda",
                     "__anaconda",
                     "Anac-0nda",
                     "_Anaconda",
                     "ana+conda",
                     "break",
                     " ",
                     NULL
                    };
    int i;

    for(i = 0 ; i < 16 ; i++)
    {
        if(zIdentificator(words[i]))
        {
            printf("%s \t [valide]\n", words[i]);
        }
        else if(words[i] != NULL)
        {
            printf("%s \t [invalide]\n", words[i]);
        }
        else
        {
            puts("Pointeur NULL");
        }
    }

    return 0;
}
