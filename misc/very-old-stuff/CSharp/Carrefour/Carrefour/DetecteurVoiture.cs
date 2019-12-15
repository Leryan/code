using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RouCaf
{
    class DetecteurVoiture : Capteur
    {
        public DetecteurVoiture(short bit, ref MaCarteIO io) : base(bit, ref io)
        {
        }
    }
}
