using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace Composants
{
    class DeTousMesCircuit
    {
        /**
         * Certes le nom de la fonction ne sera pas explicite pour quelqu'un
         * ne regardant pas Futurama, mais avec pareil sujet de TP, il est
         * difficile de penser à autre chose quand on s'est regardé plus de
         * dix épisodes en une soirée.
         *
         * Merci de votre compréhension.
         */
        public void TuEsLeMeilleur ()
        {
            Dipole da = this.Calculon (new Resistance (0), "");
            Console.Write ("Evaluer à la fréquence (Hz) : ");
            double frequence = Convert.ToDouble (Console.ReadLine ().Replace ('.', ','));
            Complexe c = da.Impedance (frequence);
            Console.WriteLine ("Complexe équivalent circuit : " + c);
            Console.WriteLine ("Impédance totale à " + frequence + "Hz : " + c.Module);
            StreamWriter sw;

            try {
                sw = new StreamWriter (@"..\..\..\circuit.csv", false, Encoding.UTF8);
                sw.WriteLine ("Fréquence;Valeur");
            } catch (Exception e) {
                Console.WriteLine (e.Message);
                return;
            }

            Console.Write ("Fréquence mini Baude : ");
            double mini = Convert.ToDouble (Console.ReadLine ().Replace ('.', ','));
            Console.Write ("Fréquence maxi Baude : ");
            double maxi = Convert.ToDouble (Console.ReadLine ().Replace ('.', ','));
            Console.Write ("Pas des fréquences : ");
            double pas = Convert.ToDouble (Console.ReadLine ().Replace ('.', ','));

            for (double i = mini; Math.Pow(10, i) < maxi; i += pas) {
                try {
                    sw.WriteLine (Math.Pow (10, i) + ";" + 20 * Math.Log10 (da.Impedance (Math.Pow (10, i)).Module));
                } catch {
                    break;
                }
            }

            try {
                sw.Flush ();
            } catch (Exception e) {
                Console.WriteLine (e.Message);
            }
        }

        public Dipole Calculon (Dipole d, string spacing)
        {
            Console.Write (spacing + "Type d'assemblage (1: S, 2: P, 3: R, 4: C, 5: H) : ");
            int i = Convert.ToInt32 (Console.ReadLine ());

            switch (i) {
                case 1:
                    d = new DipoleSerie (this.Calculon (d, spacing + "  "), this.Calculon (d, spacing + "  "));
                    break;
                case 2:
                    d = new DipoleParallele (this.Calculon (d, spacing + "  "), this.Calculon (d, spacing + "  "));
                    break;
                case 3:
                    Console.Write (spacing + "Valeur R : ");
                    d = new Resistance (Convert.ToDouble (Console.ReadLine ().Replace ('.', ',')));
                    break;
                case 4:
                    Console.Write (spacing + "Valeur C : ");
                    d = new Capacite (Convert.ToDouble (Console.ReadLine ().Replace ('.', ',')));
                    break;
                case 5:
                    Console.Write (spacing + "Valeur H : ");
                    d = new Inductance (Convert.ToDouble (Console.ReadLine ().Replace ('.', ',')));
                    break;
                default:
                    break;
            }

            return d;
        }
    }
}
