using System;
using System.Collections.Generic;
using System.IO;

namespace sax
{

    class Token {
        public List<sbyte> tag;
        public List<sbyte> data;

        public Token() {
            this.data = new List<sbyte>();
            this.tag = new List<sbyte>();
        }
    }

    class ParseEnd : Exception {

    }

    class SaxParser {

        private FileStream fs;
        private byte[] buffr;
        private UInt64 ridx;
        private UInt64 rnr;

        public SaxParser(string filepath) {
            this.fs = File.OpenRead(filepath);
            this.buffr = new byte[8192];
            this.ridx = 0;
            this.rnr = 0;
        }

        private void read() {
            this.rnr = (ulong)this.fs.Read(this.buffr, 0, this.buffr.Length);
            if (this.rnr == 0) {
                throw new ParseEnd();
            }
        }

        public Token Parse() {
            if (this.ridx == this.rnr) {
                this.read();
            }

            while (this.ridx < this.rnr) {
                this.ridx++;
            }

            this.ridx = 0;
            this.rnr = 0;
            return new Token();
        }
    }

    class MainClass
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("start");
            var parser = new SaxParser("sitemap.xml");
            try {
                while (true) {
                    var tok = parser.Parse();
                }
            } catch (ParseEnd) {
                Console.WriteLine("no more data");
            }
        }
    }
}
