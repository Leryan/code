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

namespace TP1
{
    class op_int
    {
        static void Main(string[] args)
        {
            int a, titre = 31, r = 10;
            double d;
            string sa;
            ligneTraits(titre, '_', " ", "\n\n");
            Console.WriteLine("   Cube, Surface et Volume  ");
            ligneTraits(titre, '_', " ", "\n\n");
            Console.Write(" Donner une valeur entière (en millimetres) : ");
            a = Convert.ToInt32(sa = Console.ReadLine());
            ligneTraits(r, '_', "\n ", "");
            Console.Write(" résultats ");
            ligneTraits(r, '_', "", "\n\n");
            Console.WriteLine(" Cube: " + Cube(a) + " mm3");
            d = Convert.ToDouble(a);
            Console.WriteLine(" Surface sphère de rayon " + sa + " : " + SSurf(d).ToString("0.00") + " mm2");
            Console.WriteLine(" Volume sphère de rayon " + sa + " : " + SVol(d).ToString("0.00") + " mm3");
            ligneTraits(titre, '_', " ", "\n\n");
            Console.WriteLine(" Avant échange : " + a + " , " + r);
            Echange(ref a, ref r);
            Console.WriteLine(" Après échange : " + a + " , " + r);
            Console.ReadKey();
        }

        static void Echange(ref int a, ref int b)
        {
            int m;
            m = a;
            a = b;
            b = m;
        }

        static int Cube(int a)
        {
            return a * a * a;
        }

        static double SSurf(double r)
        {
            return 4.0 * 3.14 * r * r;
        }

        static double SVol(double r)
        {
            return 4.0 * 3.14 * Convert.ToDouble(Cube(Convert.ToInt32(r))) / 3.0;
        }

        static void ligneTraits(int i, char trait, string avant, string apres)
        {
            int a = i;
            Console.Write(avant);

            for (i = 0; i < a; i++) {
                Console.Write(trait);
            }

            Console.Write(apres);
        }
    }
}
