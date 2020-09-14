using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using SimpleTchatUDP_TCP;

namespace KirbyMap
{
    public class TchatRoom
    {
        static private UInt32 tchatRoomsID = 0;
        private List<TchatBox> tchatBoxList = new List<TchatBox> ();
        private UInt32 tchatRoomID;
        private UInt32 connections = 0;

        public UInt32 TchatRoomID
        {
            get {
                return this.tchatRoomID;
            }
        }

        public TchatRoom ()
        {
            this.tchatRoomID = TchatRoom.tchatRoomsID++;
        }

        public UInt32 GetFreeTchatBoxID ()
        {
            lock (this.tchatBoxList) {
                return this.connections++;
            }
        }

        public void AddClient (TcpClient client)
        {
            TchatBox tchat = new TchatBox (client, this.GetFreeTchatBoxID (), this);

            lock (this.tchatBoxList) {
                this.tchatBoxList.Add (tchat);
            }

            Console.WriteLine ("[TCHATROOM " + this.tchatRoomID + "] Client " + tchat.ID + " accepted: " + tchat.Client.ToString ());
            this.SendString ("[TCHATROOM " + this.tchatRoomID + "] Client " + tchat.ID + " joined us !\n", tchat, false);
        }

        public void SendString (string s, TchatBox tchat, bool resend)
        {
            string toSend = this.GetPrefix (tchat.ID) + s;
            this.SendBytes (Encoding.UTF8.GetBytes (toSend), tchat, resend);
        }

        public string GetPrefix (UInt32 ID)
        {
            return DateTime.Now.ToString () + " " + this.GetPseudoByID (ID) + ": ";
        }

        public string GetPseudoByID (UInt32 ID)
        {
            lock (this.tchatBoxList) {
                foreach (TchatBox tchat in this.tchatBoxList) {
                    if (tchat != null && tchat.ID == ID && tchat.Pseudo != "") {
                        return tchat.Pseudo;
                    }
                }

                return ID.ToString ();
            }
        }

        public void SendBytes (byte[] b, TchatBox tchat, bool resend)
        {
            List<TchatBox> toDelete = new List<TchatBox> ();

            lock (this.tchatBoxList) {
                foreach (TchatBox t in this.tchatBoxList) {
                    if (tchat.ID != t.ID || resend) {
                        try {
                            t.Client.SendBufferSize = b.Length;
                            t.Send (b);
                        } catch (Exception e) {
                            Console.WriteLine (e.Message);
                            toDelete.Add (t);
                            t.Client.Close ();
                        }
                    }
                }

                foreach (TchatBox t in toDelete) {
                    this.tchatBoxList.Remove (t);
                }
            }
        }

        public void DelAllClients ()
        {
            lock (this.tchatBoxList) {
                foreach (TchatBox tchat in this.tchatBoxList) {
                    if (tchat.Client != null && tchat.Client.Connected) {
                        tchat.Client.Close ();
                    }
                }

                this.tchatBoxList.Clear ();
            }
        }

        public void DelClient (TchatBox tchat)
        {
            lock (this.tchatBoxList) {
                this.tchatBoxList.Remove (tchat);
                Console.WriteLine ("[TCHATROOM " + this.tchatRoomID + "] Client " + tchat.ID + " deleted.");
            }
        }

        ~TchatRoom ()
        {
            this.DelAllClients ();
        }
    }
}

