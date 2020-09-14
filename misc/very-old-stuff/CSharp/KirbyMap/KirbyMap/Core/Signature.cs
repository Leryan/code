using System;
using System.Collections.Generic;

namespace KirbyMap
{
    public class Signature
    {
        protected static UInt32 maxID = 0;
        private UInt32 id;

        public UInt32 Id
        {
            get {
                return id;
            }

            private set {
                id = value;
            }
        }

        public Signature ()
        {
            this.id = ++Signature.maxID;
        }
    }
}

