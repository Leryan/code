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

namespace tp5
{
    class Tab
    {
        public class Init
        {
            public static void Int (int[] tab, int value)
            {
                int i;

                for (i = 0; i < tab.Length; i++) {
                    tab[i] = value;
                }
            }

            public static void Dou (double[] tab, double value)
            {
                int i;

                for (i = 0; i < tab.Length; i++) {
                    tab[i] = value;
                }
            }

            public static void Dou2D (int[,] tab, int value)
            {
                int i;
                int j;

                for (i = 0; i < Math.Sqrt (tab.Length); i++) {
                    for (j = 0; j < Math.Sqrt (tab.Length); j++) {
                        tab[i, j] = value;
                    }
                }
            }
        }
        /* ######################################################### */
        public class Invert
        {
            public static void TabI (int[] tab)
            {
                int i;
                int tmp;

                for (i = 0; i < tab.Length / 2; i++) {
                    tmp = tab[i];
                    tab[i] = tab[tab.Length - i - 1];
                    tab[tab.Length - i - 1] = tmp;
                }
            }

            public static void TwoI (int[] tab, int i, int j)
            {
                int tmp;
                tmp = tab[i];
                tab[i] = tab[j];
                tab[j] = tmp;
            }

            public static void TwoD (double[] tab, int i, int j)
            {
                double tmp;
                tmp = tab[i];
                tab[i] = tab[j];
                tab[j] = tmp;
            }
        }
        /* ######################################################### */
        public class Display
        {
            public static void TabI (int[] tab)
            {
                int i;

                for (i = 0; i < tab.Length; i++) {
                    Console.Write (tab[i].ToString () + " ");
                }

                Console.WriteLine ("");
            }

            public static void TabI2D (int[,] tab)
            {
                int i;
                int j;

                for (i = 0; i < Math.Sqrt (tab.Length); i++) {
                    for (j = 0; j < Math.Sqrt (tab.Length); j++) {
                        if (tab[i, j] != 0) {
                            Console.Write (tab[i, j].ToString () + " ");
                        }
                    }

                    Console.WriteLine ("");
                }

                Console.WriteLine ("");
            }

            public static void TabD (double[] tab)
            {
                int i;

                for (i = 0; i < tab.Length; i++) {
                    Console.Write (tab[i].ToString () + " ");
                }

                Console.WriteLine ("");
            }
        }
        /* ######################################################### */
        public class Fifo
        {
            public static void TabD (double[] tab, double new_value)
            {
                int i;

                for (i = 0; i < tab.Length - 1; i++) {
                    tab[i] = tab[i + 1];
                }

                tab[i] = new_value;
            }

            public static void TabI (int[] tab, int new_value)
            {
                int i;

                for (i = 0; i < tab.Length - 1; i++) {
                    tab[i] = tab[i + 1];
                }

                tab[i] = new_value;
            }
        }
        /* ######################################################### */
        public class MathT
        {
            public static double sumTabD (double[] tab)
            {
                int i;
                double sum;

                for (i = 0, sum = 0; i < tab.Length; i++) {
                    sum += tab[i];
                }

                return sum;
            }

            public static void pascalTabI (int size)
            {
                int[,] tab = new int[++size, size];
                int i;
                int j;
                Tab.Init.Dou2D (tab, 0);
                tab[0, 0] = 1;

                for (i = 1; i < size; i++) {
                    tab[i, 0] = 1;

                    for (j = 1; j < i + 1; j++) {
                        tab[i, j] = tab[i - 1, j] + tab[i - 1, j - 1];
                    }
                }

                Tab.Display.TabI2D (tab);
            }

            public static double MoyD (double[] tab)
            {
                return (Tab.MathT.sumTabD (tab)) / Convert.ToDouble (tab.Length);
            }

            public static double MinD (double[] tab, int @from)
            {
                int i;
                int j;

                for (j = @from, i = j + 1; i < tab.Length; i++) {
                    if (tab[i] < tab[j]) {
                        j = i;
                    }
                }

                return tab[j];
            }

            public static int MinIi (int[] tab, int @from)
            {
                int i;
                int j;

                for (j = @from, i = j + 1; i < tab.Length; i++) {
                    if (tab[i] < tab[j]) {
                        j = i;
                    }
                }

                return j;
            }

            public static int MinDi (double[] tab, int @from)
            {
                int i;
                int j;

                for (j = @from, i = j + 1; i < tab.Length; i++) {
                    if (tab[i] < tab[j]) {
                        j = i;
                    }
                }

                return j;
            }

            public static double MaxD (double[] tab, int @from)
            {
                int i;
                int j;

                for (j = @from, i = j + 1; i < tab.Length; i++) {
                    if (tab[i] > tab[j]) {
                        j = i;
                    }
                }

                return tab[j];
            }

            public static int MaxIi (int[] tab, int @from)
            {
                int i;
                int j;

                for (j = @from, i = j + 1; i < tab.Length; i++) {
                    if (tab[i] > tab[j]) {
                        j = i;
                    }
                }

                return j;
            }

            public static int MaxDi (double[] tab, int @from)
            {
                int i;
                int j;

                for (j = @from, i = j + 1; i < tab.Length; i++) {
                    if (tab[i] > tab[j]) {
                        j = i;
                    }
                }

                return j;
            }
        }
        /* ######################################################### */
        public static void FromToTabS (string[] tab, int start)
        {
            int i;

            for (i = start; i < tab.Length; i++) {
                Console.WriteLine (tab[i]);
            }

            for (i = 0; i < start; i++) {
                Console.WriteLine (tab[i]);
            }
        }
        /* ######################################################### */
        public class Tri
        {
            public static void MinMaxI (int[] tab)
            {
                int i;
                int imin;

                for (i = 0; i < tab.Length - 1; i++) {
                    imin = Tab.MathT.MinIi (tab, i + 1);

                    if (tab[i] > tab[imin]) {
                        Tab.Invert.TwoI (tab, i, imin);
                    }
                }
            }

            public static void MaxMinI (int[] tab)
            {
                int i;
                int imax;

                for (i = 0; i < tab.Length - 1; i++) {
                    imax = Tab.MathT.MaxIi (tab, i + 1);

                    if (tab[i] < tab[imax]) {
                        Tab.Invert.TwoI (tab, i, imax);
                    }
                }
            }

            public static void MinMaxD (double[] tab)
            {
                int i;
                int imin;

                for (i = 0; i < tab.Length - 1; i++) {
                    imin = Tab.MathT.MinDi (tab, i + 1);

                    if (tab[i] > tab[imin]) {
                        Tab.Invert.TwoD (tab, i, imin);
                    }
                }
            }

            public static void MaxMinD (double[] tab)
            {
                int i;
                int imax;

                for (i = 0; i < tab.Length - 1; i++) {
                    imax = Tab.MathT.MaxDi (tab, i + 1);

                    if (tab[i] < tab[imax]) {
                        Tab.Invert.TwoD (tab, i, imax);
                    }
                }
            }
        }
    }
}
