using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RouCaf
{
    class BPPieton : Capteur
    {
        public BPPieton(short bit, ref MaCarteIO io) : base(bit, ref io)
        {
        }
    }
}
