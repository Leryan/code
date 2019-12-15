using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RouCaf
{
    class Lampe : ES
    {
        private MaCarteIO io;
        public Lampe(short bit, ref MaCarteIO io) : base(bit)
        {
            this.io = io;
        }

        public void SetOFF()
        {
            this.io.SetOFF(this.bit);
        }
        public void SetON()
        {
            this.io.SetON(this.bit);
        }
    }
}
