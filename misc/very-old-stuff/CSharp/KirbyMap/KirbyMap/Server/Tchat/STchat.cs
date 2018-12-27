using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using SimpleTchatUDP_TCP;

namespace KirbyMap
{
    public class STchat
    {
        private TcpListener listener;
        private int port;
        private System.Text.UTF8Encoding encoding;
        private bool started;
        private bool firststart;
        private List<TchatRoom> tchatRooms;

        public STchat (int port)
        {
            this.encoding = new System.Text.UTF8Encoding ();
            this.tchatRooms = new List<TchatRoom> ();
            this.port = port;
            this.started = false;
            this.firststart = false;
        }

        public void Stop ()
        {
            foreach (TchatRoom tchatRooms in this.tchatRooms) {
                tchatRooms.DelAllClients ();
            }

            this.started = false;
        }

        public void Start ()
        {
            if (this.started) {
                return;
            }

            if (this.listener == null) {
                this.listener = new TcpListener (IPAddress.Parse ("127.0.0.1"), this.port);
                this.listener.Start (1);
            } else {
                this.listener.Start (1);
            }

            Thread t = new Thread (this.RunServer);
            t.Start ();
            this.started = true;
        }

        public void Restart ()
        {
            if (this.started && this.listener != null) {
                this.Stop ();
                this.Start ();
            } else {
                this.Start ();
            }
        }

        public void Quit ()
        {
            if (this.started) {
                this.Stop ();
            }

            this.listener.Stop ();
        }

        private void RunServer ()
        {
            if (this.started && this.firststart) {
                this.firststart = true;
                return;
            }

            this.tchatRooms.Add (new TchatRoom ());
            TcpClient client;
            Console.WriteLine ("[SERVER] Tchat server ready !");

            while (this.started) {
                try {
                    client = this.listener.AcceptTcpClient ();
                } catch (Exception e) {
                    Console.WriteLine ("[SERVER] Server stopped.");
                    return;
                }

                this.tchatRooms [0].AddClient (client);
            }

            Console.WriteLine ("[SERVER] Server stopped.");
            this.started = false;
        }
    }
}

