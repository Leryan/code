using System;
using System.Threading;
using System.Net;
using System.Net.Sockets;

namespace KirbyMap
{
    public class KirbyServer
    {
        private Thread kirbyThread;
        private Map map;

        public Map Map
        {
            get {
                return map;
            }

            private set {
                map = value;
            }
        }

        private bool isLaunched;

        public bool IsLaunched
        {
            get {
                return isLaunched;
            }

            private set {
                isLaunched = value;
            }
        }

        private TcpListener server;

        public void Start ()
        {
            this.kirbyThread = new Thread (this.RunServer);
            this.kirbyThread.Start ();
        }

        public void Stop ()
        {
        }

        public KirbyServer (Map map, IPAddress IP, UInt16 port, bool IPv6)
        {
            this.Map = map;
            this.server = new TcpListener (IP, port);
        }

        private void RunServer ()
        {
            this.server.Start ();
            this.IsLaunched = true;
            Console.WriteLine ("KirbyServer ready !");

            while (this.kirbyThread.IsAlive) {
                TcpClient client = server.AcceptTcpClient ();
                new BaseServer (client);
            }

            this.IsLaunched = false;
        }
    }
}

