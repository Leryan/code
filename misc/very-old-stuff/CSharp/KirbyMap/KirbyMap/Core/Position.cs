using System;

namespace KirbyMap
{
    public class Position
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

        public Position (UInt32 x, UInt32 y)
        {
            this.x = x;
            this.y = y;
        }

        public static bool operator == (Position po1, Position po2)
        {
            if (po1.x == po2.x && po1.y == po2.y) {
                return true;
            }

            return false;
        }

        public static bool operator != (Position po1, Position po2)
        {
            if (po1.x != po2.x || po1.y != po2.y) {
                return true;
            }

            return false;
        }

        public override string ToString ()
        {
            return string.Format ("[Position: x={0}, y={1}]", x, y);
        }
    }
}

