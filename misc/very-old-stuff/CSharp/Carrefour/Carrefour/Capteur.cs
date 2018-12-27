using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RouCaf
{
    class Capteur : ES
    {
        private MaCarteIO io;

        public Capteur(short bit, ref MaCarteIO io) : base(bit)
        {
            this.io = io;
        }

        public bool GetState()
        {
            return this.io.GetEntree(this.bit);
        }
    }
}
