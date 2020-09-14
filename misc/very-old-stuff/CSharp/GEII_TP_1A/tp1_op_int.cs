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
            int a, b, i;
            string sa, sb;
            Console.WriteLine(" ----------------------------- ");
            Console.WriteLine("  opérations sur deux entiers  ");
            Console.WriteLine(" ----------------------------- ");
            Console.Write(" donner un premier entier : ");
            a = Convert.ToInt32(sa = Console.ReadLine());
            Console.Write(" donner un second entier  : ");
            b = Convert.ToInt32(sb = Console.ReadLine());
            Console.WriteLine("\nValeur de a : " + sa);
            Console.Write("Valeur de b : " + sb + "\n\n ");

            for (i = 0; i < 15; i++) {
                Console.Write('-');
            }

            Console.Write(" résultats ");

            for (i = 0; i < 15; i++) {
                Console.Write('-');
            }

            Console.Write("\nSomme   : " + sa + " + " + sb + " = " + Convert.ToString(a + b));
            Console.WriteLine("\t  Différence : " + sa + " - " + sb + " = " + Convert.ToString(a - b));
            Console.Write("Produit : " + sa + " * " + sb + " = " + Convert.ToString(a * b));

            if (b != 0) {
                Console.Write("\t  Quotient   : " + sa + " / " + sb + " = " + Convert.ToString(a / b));
                Console.WriteLine("  Modulo : " + sa + " % " + sb + " = " + Convert.ToString(a % b));
            } else {
                Console.WriteLine("\npas de résultat pour / et % avec b = 0");
            }

            Console.ReadKey();
        }
    }
}
