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
#include <pthread.h>
#include <SDL/SDL.h>

#define _SDL_INIT_FLAGS (SDL_INIT_VIDEO | SDL_INIT_AUDIO)

SDL_Event event;
char runme = 1;

void *_SDL_EventCheck(void *data);

int main(void)
{
    SDL_Surface *Ecran = NULL;
    SDL_Rect PosiDC;
    pthread_t _SDL_EventReport;


    if(SDL_Init(_SDL_INIT_FLAGS) == -1)
    {
        fputs("Erreur d'itinisialisation de SDL : ", stderr);
        fputs(SDL_GetError(), stderr);
        fputc('\n', stderr);
        exit(EXIT_FAILURE);
    }

    SDL_SetVideoMode(255, 255, 32, SDL_HWSURFACE | SDL_RESIZABLE | SDL_DOUBLEBUF);
    SDL_WM_SetCaption("Projet SDL", "Kedall");

    Ecran = SDL_SetVideoMode(255, 255, 32, SDL_HWSURFACE);
    PosiDC.x = PosiDC.y = 0;

    if(pthread_create(&_SDL_EventReport, NULL, _SDL_EventCheck, NULL))
    {
        fputs("quit thread\n", stderr);
        exit(EXIT_FAILURE);
    }

    while(runme)
    {
        SDL_FillRect(Ecran, NULL, SDL_MapRGB(Ecran->format, 0, 0, 0));
    }

    pthread_join(_SDL_EventReport, NULL);

    SDL_FreeSurface(Ecran);
    SDL_Quit();

    return EXIT_SUCCESS;
}

void *_SDL_EventCheck(void *data)
{
    while(runme)
    {
        SDL_WaitEvent(&event);
        switch(event.type)
        {
        case SDL_QUIT:
            fputs("quit\n", stdout);
            runme = 0;
            break;
        }
    }

    return NULL;
}
