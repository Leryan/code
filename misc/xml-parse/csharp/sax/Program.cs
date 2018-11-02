using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Linq;

namespace sax
{

    class Token {
        public List<byte> tag;
        public List<byte> data;

        public Token() {
            this.data = new List<byte>();
            this.tag = new List<byte>();
        }

        public override String ToString() {
            var encoding = new UTF8Encoding();
            return String.Format("{0}:{1}", encoding.GetString(this.tag.ToArray()), encoding.GetString(this.data.ToArray()));
        }
    }

    class ParseEnd : Exception {

    }

    enum State {
        None,
        StartTag,
        Data,
        EndTag,
    }

    class SaxParser {

        private BinaryReader reader;
        private byte[] buffr;
        private UInt64 ridx;
        private UInt64 rnr;
        private State state;
        private Token tok;
        private byte leftover;

        public SaxParser(string filepath) {
            var fs = File.OpenRead(filepath);
            this.reader = new BinaryReader(fs);
            this.ridx = 0;
            this.rnr = 0;
            this.state = State.None;
            this.leftover = 0;
        }

        private void read() {
            this.buffr = this.reader.ReadBytes(8192);
            this.ridx = 0;
            this.rnr = (ulong)this.buffr.Length;
            if (this.rnr == 0) {
                throw new ParseEnd();
            }
            this.rnr--;
        }

        private bool parse() {
            byte b;
            while (this.ridx < this.rnr) {
                if (this.leftover == 0) {
                    b = this.buffr[this.ridx];
                    this.ridx++;
                } else {
                    b = this.leftover;
                    this.leftover = 0;
                }

                if (b == (byte)'<') {
                    if (this.state == State.None) {
                        this.state = State.StartTag;
                    } else if (this.state == State.Data) {
                        // <tag>data...</tag>
                        if (this.buffr[this.ridx] == (byte)'/') {
                            this.state = State.None;
                            return true;
                        }
                        // <tag><newtag>...
                        this.state = State.StartTag;
                        this.tok.tag.Clear();
                    }
                } else if (b == (byte)'>') {
                    if (this.state == State.StartTag) {
                        this.state = State.Data;
                    }
                } else if (this.state == State.Data) {
                    this.tok.data.Add(b);
                } else if (this.state == State.StartTag) {
                    this.tok.tag.Add(b);
                }
            }

            this.leftover = this.buffr[this.ridx];

            return false;
        }

        public Token Parse() {
            this.tok = new Token();
            while(true) {
                if (this.ridx == this.rnr) {
                    this.read();
                }
                if (this.parse()) {
                    return this.tok;
                }
            }
        }
    }

    class Appli {

        public void Run() {
            Console.WriteLine("start");
            var parser = new SaxParser("sitemap.xml");
            var urls = new List<byte[]>();
            var encoding = new UTF8Encoding();
            var locb = encoding.GetBytes("loc");
            try {
                while (true) {
                    //Console.WriteLine(parser.Parse().ToString());
                    var tok = parser.Parse();
                    if (locb.SequenceEqual(tok.tag.ToArray())) {
                        urls.Add(tok.data.ToArray());
                    }
                }
            } catch (ParseEnd) {
                Console.WriteLine("no more data");
            }

            Console.WriteLine("{0} results", urls.Count);
        }
    }

    class MainClass
    {
        public static void Main(string[] args)
        {
            var app = new Appli();
            app.Run();
        }
    }
}
