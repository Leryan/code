using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RouCaf
{
    class Feu
    {
        private Lampe rouge;
        private Lampe orange;
        private Lampe vert;
        private DetecteurVoiture voiture;
        private BPPieton bppieton;
        private short feu;

        public Feu(short feu, ref MaCarteIO io)
        {
            this.feu = feu;
            this.vert = new Lampe((short)(feu * 3), ref io);
            this.orange = new Lampe((short)(feu * 3 + 1), ref io);
            this.rouge = new Lampe((short)(feu * 3 + 2), ref io);
            this.voiture = new DetecteurVoiture(feu, ref io);
            this.bppieton = new BPPieton((short)(feu + 4), ref io);
        }

        public void Rouge()
        {
            this.rouge.SetON();
            this.orange.SetOFF();
            this.vert.SetOFF();
        }
        public void Orange()
        {
            this.rouge.SetOFF();
            this.orange.SetON();
            this.vert.SetOFF();
        }
        public void Vert()
        {
            this.rouge.SetOFF();
            this.orange.SetOFF();
            this.vert.SetON();
        }
        public bool Voiture()
        {
            return this.voiture.GetState();
        }
        public bool BPPieton()
        {
            return this.bppieton.GetState();
        }
    }
}
