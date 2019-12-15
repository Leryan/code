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
*     * Neither the name of Florent PETERSCHMITT, nor the
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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading;
using CmdCrf;

namespace FeuxCarrefour
{
    class Program
    {
        public static void Main(string[] args)
        {
            Crossroads obCrossroads;
            string path = "..\\..\\..\\";
            string ip = "127.0.0.1";
            int doCycles = 0;
            char sepChar = '\t';

            if (args.Length > 0) {
                if (args[0] == "M") {
                    ip = "172.20.54.111";
                }
            }

            if (args.Length > 1) {
                doCycles = Convert.ToInt32(args[1]);
            }

            if (args.Length > 2) {
                if (args[2] == "tab") {
                    sepChar = '\t';
                } else {
                    sepChar = Convert.ToChar(args[2]);
                }
            }

            if (args.Length > 3) {
                if (args[3] == "UNIX") {
                    path = path.Replace("\\", "/");
                }
            }

            /* string  sfConfR   : fichier de config,
             * string  sfHistoW  : fichier historique,
             * bool    EF        : append sur historique,
             * bool    AF        : autoflush historique,
             * char    SEP       : caractère séparateur historique,
             * string  CIP       : adresse IP carrefour,
             * int     ST        : temps minimum de communication programme/carrefour (ms),
             * int     STO       : temps feu orange (ms),
             * int     STS       : temps passage rouge/vert (ms),
             */
            obCrossroads = new Crossroads(
                path + "Config.txt",
                path + "History.csv",
                true,
                true,
                sepChar,
                ip,
                10,
                2000,
                2000
            );
            /* Lancement pour 10 cycles. Envoyer 0 si on veut que le programme
             * se déroule à l'infinie. Ou du moins jusqu'à ce que mort s'en
             * suive.
             */
            obCrossroads.RunCrossroads(doCycles);
        }
    }
}