using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using SimpleTchatUDP_TCP;

namespace KirbyMap
{
    public class TchatBox
    {
        static public System.Text.UTF8Encoding encoding = new UTF8Encoding ();
        private TcpClient client;
        private UInt32 id;
        private TchatRoom myTchatRoom;
        private string pseudo;
        private NetworkStream clientStream;
        private RunCmd runCmd;

        public static System.Text.UTF8Encoding Encoding
        {
            get {
                return TchatBox.encoding;
            }

            private set {
                TchatBox.encoding = value;
            }
        }

        public TcpClient Client
        {
            get {
                return this.client;
            }

            private set {
                this.client = value;
            }
        }

        public UInt32 ID
        {
            get {
                return this.id;
            }

            private set {
                this.id = value;
            }
        }

        public string Pseudo
        {
            get {
                return this.pseudo;
            } set {
                this.pseudo = value;
            }
        }

        public TchatRoom MyTchatRoom
        {
            get {
                return this.myTchatRoom;
            }

            private set {
                this.myTchatRoom = value;
            }
        }

        public TchatBox (TcpClient client, UInt32 ID, TchatRoom myChatRoom)
        {
            this.id = ID;
            this.client = client;
            this.pseudo = "";
            this.myTchatRoom = myChatRoom;
            this.clientStream = this.Client.GetStream ();
            this.runCmd = new RunCmd (this);
            Thread t = new Thread (this.Run);
            t.Start ();
        }

        public override bool Equals (object obj)
        {
            TchatBox tchat;

            try {
                tchat = (TchatBox)(obj);
            } catch {
                return false;
            }

            if (this.id == tchat.id) {
                return true;
            }

            return false;
        }

        public void Send (byte[] b)
        {
            try {
                this.clientStream.Write (b, 0, b.Length);
                this.clientStream.Flush ();
            } catch (Exception e) {
                throw new Exception ("[TCHATBOX " + this.id + "] Problem while sending.");
            }
        }

        private void Run ()
        {
            while (this.Client != null && this.Client.Connected) {
                byte[] buf = new byte[256];

                try {
                    this.clientStream.Read (buf, 0, buf.Length);
                } catch (Exception e) {
                    this.client.Close ();
                    Console.WriteLine ("[TCHATBOX " + this.id + " ] Nothing to receive.");
                    break;
                }

                if (buf.Length > 0 && buf [0] == encoding.GetBytes ("/") [0]) {
                    this.runCmd.run (buf, false);
                } else if (buf.Length > 0) {
                    this.myTchatRoom.SendString (encoding.GetString (buf), this, false);
                } else {
                    this.client.Close ();
                    break;
                }
            }
        }

        ~TchatBox ()
        {
            if (this.client != null && this.client.Connected) {
                this.client.Close ();
            }
        }
    }
}

