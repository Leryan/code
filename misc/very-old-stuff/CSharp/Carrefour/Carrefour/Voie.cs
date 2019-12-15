using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RouCaf
{
    class Voie
    {
        private Feu feu1;
        private Feu feu2;
        private short voie;

        public Voie(short voie, ref MaCarteIO io)
        {
            this.voie = voie;
            this.feu1 = new Feu((short)(voie * 2), ref io);
            this.feu2 = new Feu((short)(voie * 2 + 1), ref io);
        }

        public void Vert()
        {
            this.feu1.Vert();
            this.feu2.Vert();
        }

        public void Orange()
        {
            this.feu1.Orange();
            this.feu2.Orange();
        }

        public void Rouge()
        {
            this.feu1.Rouge();
            this.feu2.Rouge();
        }
        public bool Voiture()
        {
            return (this.feu1.Voiture() || this.feu2.Voiture());
        }

        public bool BPPieton()
        {
            return (this.feu1.BPPieton() || this.feu2.BPPieton());
        }
    }
}
