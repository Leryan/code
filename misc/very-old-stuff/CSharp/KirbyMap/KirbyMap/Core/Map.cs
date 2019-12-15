using System;
using System.Collections.Generic;

namespace KirbyMap
{
    public class Map
    {
        private Dimension dim;

        public Dimension Dim
        {
            get {
                return dim;
            }

            private set {
                dim = value;
            }
        }

        private List<Obstacle> obList;
        private List<Player> playerList;

        public bool AddObstacle (Obstacle ob)
        {
            if (this.playerList.Contains (new Player (ob.Position))
                || this.obList.Contains (ob)
                || ob.Position.X >= this.Dim.X
                || ob.Position.Y >= this.Dim.Y) {
                return false;
            }

            this.obList.Add (ob);
            return true;
        }

        public bool AddPlayer (Player player)
        {
            if (this.obList.Contains (new Obstacle (player.position, null))
                || this.playerList.Contains (player)
                || player.position.X >= this.Dim.X
                || player.position.Y >= this.Dim.Y) {
                return false;
            }

            this.playerList.Add (player);
            return true;
        }

        public Map (Dimension dim)
        {
            this.Dim = dim;
            this.obList = new List<Obstacle> ();
            this.playerList = new List<Player> ();
        }

        public override string ToString ()
        {
            string s;
            Position cursor = new Position (0, 0);

            for (s = ""; cursor.X < this.Dim.X; cursor.X++) {
                for (cursor.Y = 0; cursor.Y < this.Dim.Y; cursor.Y++) {
                    if (this.obList.Contains (new Obstacle (cursor, null))) {
                        s += "XX";
                    } else {
                        if (this.playerList.Contains (new Player (cursor))) {
                            s += "OO";
                        } else {
                            s += "__";
                        }
                    }
                }

                s += "\n";
            }

            return s;
        }
    }
}

