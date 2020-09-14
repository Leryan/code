using System;

namespace KirbyMap
{
    public class Player
    {
        public Position position;
        public Signature localSignature;
        public Signature remoteSignature;
        public string name;

        public Player (Position position)
        {
            this.position = position;
            this.localSignature = new Signature ();
        }

        public Player (Position position, string name) : this(position)
        {
            this.name = name;
        }

        public static bool operator == (Player p1, Player p2)
        {
            if (p1.position == p2.position) {
                return true;
            }

            return false;
        }

        public static bool operator != (Player p1, Player p2)
        {
            if (p1.position != p2.position) {
                return true;
            }

            return false;
        }

        public override bool Equals (object obj)
        {
            try {
                Player o = (Player)obj;
                return (this == o);
            } catch {
                return false;
            }
        }
    }
}

