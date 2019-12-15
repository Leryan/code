using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace RouCaf
{
    class Carrefour
    {
        private MaCarteIO io;
        private bool marche;
        private Voie voie1;
        private Voie voie2;

        public Carrefour()
        {
            this.marche = false;

            try {
                this.io = new MaCarteIO();
            } catch (Exception e) {
                throw e;
            }

            this.voie1 = new Voie(0, ref io);
            this.voie2 = new Voie(1, ref io);
        }

        public void Marche()
        {
            if (this.marche) {
                return;
            } else {
                this.marche = true;
            }

            Thread t = new Thread(this.Run());
            t.Start();
            this.Arret();
        }

        public void Arret()
        {
            if (!this.marche) {
                return;
            }

            this.marche = false;
        }

        private void Wait(int time)
        {
            for (int i = time / 1000; i > 0; i--) {
                Console.Write("\rNext in : " + (i / 60).ToString() + " minutes, " + i % 60 + " sec.  ");
                Thread.Sleep(1000);
            }

            Console.WriteLine();
        }

        private bool WaitEvent(Voie v1, Voie v2, int time, int step)
        {
            for (int i = time / step; i > 0; --i) {
                this.io.Update();

                if (v1.BPPieton() || v2.Voiture()) {
                    return true;
                }

                Thread.Sleep(step);
            }

            return false;
        }

        private void Run()
        {
            this.voie1.Rouge();
            this.voie2.Rouge();
            Console.WriteLine("Attente cycles...");
            this.Wait(1000);
            Console.WriteLine("Départ.");

            while (this.marche) {
                this.voie1.Vert();

                if (!this.WaitEvent(this.voie1, this.voie2, 5000, 100)) {
                    Thread.Sleep(2000);
                }

                this.voie1.Rouge();
                this.voie2.Vert();

                if (!this.WaitEvent(this.voie2, this.voie1, 5000, 100)) {
                    Thread.Sleep(2000);
                }

                this.voie2.Rouge();
            }
        }
    }
}
