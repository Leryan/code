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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace petflo
{
    class Program
    {
        static int saisieNbreEntiers()
        {
            int n;
            Console.Write("Saisir le nombre d'entiers (>3) : ");

            do {
                n = Convert.ToInt32(Console.ReadLine());
            } while (n < 4); //Si l'utilisateur a saisi un nombre <= 3.

            return n;
        }

        static void saisieDesEntiers(int n, int[] tab)
        {
            int i;
            Console.WriteLine("Saisie des " + Convert.ToString(n) + " entiers :");

            //On parcourt tab de 0 à n pour y mettre nos valeurs. Vive la france.
            for (i = 0 ; i < n ; i++) {
                tab[i] = Convert.ToInt32(Console.ReadLine());
            }
        }

        static void affichageFormule(int[] tab)
        {
            int i;
            //On commence par écrire la première valeur
            //suivie d'un + et d'un espace pour la suite.
            Console.Write(Convert.ToString(tab[0]) + " + (");

            //On commence à l'indice 1 du tableau car on a plus
            //besoin de la première valeur.
            for (i = 1; i < tab.Length - 1; i++) {
                //On affiche la valeur de tab[i] compris entre 1 et n - 2
                //avec n = tab.Length, soit la longueur du tableau.
                Console.Write(Convert.ToString(tab[i]));

                //On regarde si il faut écrire un " + "
                //On ne le fera que si on est pas au n-2 ième indice.
                if (i != tab.Length - 2) {
                    Console.Write(" + ");
                }
            }

            //On ferme la parenthèse, on écrit la division et on affiche la dernière valeur.
            Console.Write(") / " + Convert.ToString(tab[tab.Length - 1]) + " = ");
        }

        static double calculResultat(int[] tab)
        {
            double result;
            double inter; //Pour le calcul de la somme de la parenthèse.
            int i;
            inter = 0.0;

            //Somme de n = 1 à n = tab.Length - 2
            for (i = 1; i < tab.Length - 1; i++)//si tab = 4; i = 1; 4 - 1 = <indice max>.
                //Si on prend "<" alors on a <indice max> - 2;
            {
                inter += Convert.ToDouble(tab[i]);
            }

            //tab[0] + (tab[1] + ... + tab[n - 2]) / tab[n - 1]
            result = tab[0] + (inter / Convert.ToDouble(tab[tab.Length - 1]));
            return result;
        }

        static void affichageResultat(double result)
        {
            //No comment.
            Console.WriteLine(Convert.ToString(result));
        }

        static void Main(string[] args)
        {
            int n;
            int[] tab;
            double result;
            n = saisieNbreEntiers();
            tab = new int[n]; //Et hop un pti tableau de taille n.
            saisieDesEntiers(n, tab);
            affichageFormule(tab);
            result = calculResultat(tab);
            affichageResultat(result);
        }
    }
}
