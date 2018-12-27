using System;
using System.Threading;
using System.Net.Sockets;

namespace KirbyMap
{
    public class BaseServer
    {
        protected TcpClient client;
        protected NetworkStream stream;

        public BaseServer (TcpClient client)
        {
            this.client = client;
            new Thread (this.Run).Start ();
            Console.WriteLine ("\t=>Client connected.");
        }

        private void Run ()
        {
            this.stream = this.client.GetStream ();

            while (this.client.Connected) {
                this.RunData ();
            }

            this.stream.Close ();
            this.client.Close ();
            Console.WriteLine ("\t=>Client disconnected.");
        }

        private void RunData ()
        {
            byte[] data = new byte[256];

            try {
                this.stream.Read (data, 0, data.Length);
                this.stream.Write (data, 0, data.Length);
            } catch (Exception e) {
            }
        }
    }
}

