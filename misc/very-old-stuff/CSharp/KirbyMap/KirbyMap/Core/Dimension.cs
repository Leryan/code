using System;

namespace KirbyMap
{
    public class Dimension
    {
        private UInt32 x;
        private UInt32 y;

        public UInt32 X
        {
            get {
                return x;
            } set {
                x = value;
            }
        }

        public UInt32 Y
        {
            get {
                return y;
            } set {
                y = value;
            }
        }

        public Dimension (UInt32 x, UInt32 y)
        {
            this.x = x;
            this.y = y;
        }
    }
}

