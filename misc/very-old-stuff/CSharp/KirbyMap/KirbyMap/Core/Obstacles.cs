using System;

namespace KirbyMap
{
    public class Obstacle
    {
        private Position position;

        public Position Position
        {
            get {
                return position;
            } set {
                position = value;
            }
        }

        public Obstacle (Position position, ObType obt)
        {
            this.Position = position;
            this.type = obt;
        }

        public ObType type;

        public ObType Type
        {
            get {
                return type;
            } set {
                type = value;
            }
        }

        public static bool operator == (Obstacle ob1, Obstacle ob2)
        {
            if (ob1.Position == ob2.Position) {
                return true;
            }

            return false;
        }

        public static bool operator != (Obstacle ob1, Obstacle ob2)
        {
            if (ob1.Position != ob2.Position) {
                return true;
            }

            return false;
        }

        public override bool Equals (object obj)
        {
            try {
                Obstacle o = (Obstacle)obj;
                return (this == o);
            } catch {
                return false;
            }
        }

        public bool FullEquals (Obstacle obst)
        {
            if (this == obst && this.type == obst.type) {
                return true;
            }

            return false;
        }

        public override string ToString ()
        {
            return string.Format ("[Obstacle: position={0}, type={1}]", Position, type);
        }
    }
}

public enum ObTypes {
    VOID,
    GROUND,
    BOX
}

public enum ObMods {
    EXPLOSIVE,
    HOT,
    COLD
}

public class ObType
{
    private ObTypes type;
    private ObMods mod;

    public ObTypes Type
    {
        get {
            return type;
        } set {
            type = value;
        }
    }

    public ObMods Mod
    {
        get {
            return mod;
        } set {
            mod = value;
        }
    }

    public ObType (ObMods mod, ObTypes type)
    {
        this.Mod = mod;
        this.Type = type;
    }

    public override string ToString ()
    {
        return this.Type.ToString () + " " + this.Mod.ToString ();
    }

    public static bool operator == (ObType obt1, ObType obt2)
    {
        if (obt1.Type == obt2.Type && obt1.Mod == obt2.Mod) {
            return true;
        }

        return false;
    }

    public static bool operator != (ObType obt1, ObType obt2)
    {
        if (obt1.Type != obt2.Type && obt1.Mod != obt2.Mod) {
            return true;
        }

        return false;
    }

    public override bool Equals (object obj)
    {
        try {
            ObType o = (ObType)obj;
            return (this == o);
        } catch {
            return false;
        }
    }
}
