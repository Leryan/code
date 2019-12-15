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
    class autonomie_vehicule
    {
        static void Main(string[] args)
        {
            double conso_100, capa, distance, max;
            Console.Write("Indiquez la capacité de votre réservoire en litres: ");
            capa = Convert.ToDouble(Console.ReadLine());
            Console.Write("Indiquez la consommation moyenne de votre véhicule aux 100Km en litres: ");
            conso_100 = Convert.ToDouble(Console.ReadLine());
            Console.Write("Indiquez la distance à parcourir en Km: ");
            distance = Convert.ToDouble(Console.ReadLine());
            max = (capa / conso_100) * 100;
            Console.WriteLine("\nVous pouvez parcourir, avec un plein: " + Convert.ToString(max) + "Km");
            Console.Write("Le nombre de plein(s) à faire sera de: " + (distance / max - 1.0).ToString("0.000"));
            Console.WriteLine(" soit " + (distance / max - 1.0) * capa + " litres.");
            Console.ReadKey();
        }
    }
}
