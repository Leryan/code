using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RouCaf
{
    class MaCarteIO : CarteIO
    {
        private byte entrees;
        private short sorties;

        public MaCarteIO() : base()
        {
        }

        public MaCarteIO(string address) : base(address)
        {
        }

        public void SetON(short bit)
        {
            this.sorties = (short)(this.sorties | (0x1 << bit));
            this.entrees = this.EntreesSorties(this.sorties);
        }
        public void SetOFF(short bit)
        {
            this.sorties = (short)(this.sorties & ~(0x1 << bit));
            this.entrees = this.EntreesSorties(this.sorties);
        }
        public void Update()
        {
            this.entrees = this.EntreesSorties(this.sorties);
        }
        public bool GetEntree(int bit)
        {
            if ((this.entrees >> bit & 0x01) == 1) {
                return true;
            }

            return false;
        }
    }
}
