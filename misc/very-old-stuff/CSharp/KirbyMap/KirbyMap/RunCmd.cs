using System;
using SimpleTchatUDP_TCP;

namespace KirbyMap
{
    public class RunCmd
    {
        private TchatBox tchat;

        public RunCmd (TchatBox tchat)
        {
            this.tchat = tchat;
        }

        public void run (byte[] buf, bool resend)
        {
            string s = TchatBox.Encoding.GetString (buf).Replace ("\r\n", "").Trim ();
            string cmd = s.Split ('|') [1];
            Console.Write ("[TCHATBOX " + tchat.ID + "] Received: " + cmd + " | ");

            switch (cmd) {
                case "MSG":
                    this.tchat.MyTchatRoom.SendString (s.Split ('|') [3], this.tchat, resend);
                    break;
                case "PSEUDO":
                    this.tchat.Pseudo = s.Split ('|') [2];
                    this.tchat.MyTchatRoom.SendString ("Changement de nom : ", this.tchat, resend);
                    break;
                case "QUIT":
                    Console.WriteLine ("QUIT");
                    string pseudo = this.tchat.ID.ToString ();

                    if (this.tchat.Pseudo != "") {
                        pseudo += " (" + this.tchat.Pseudo + ")";
                    }

                    this.tchat.MyTchatRoom.SendString ("Client " + pseudo + " has quit.\n", this.tchat, resend);
                    this.tchat.Client.Close ();
                    this.tchat.MyTchatRoom.DelClient (this.tchat);
                    break;
                case "JOIN":
                    string ps = s.Split ('|') [2];
                    Console.WriteLine ("pseudo: " + ps);

                    if (ps.Length > 2) {
                        this.tchat.Pseudo = ps;
                        Console.WriteLine ("[TCHATBOX " + this.tchat.ID + "] Pseudo " + this.tchat.Pseudo + " accepted.");
                        this.tchat.MyTchatRoom.SendString ("Client " + this.tchat.ID + " is now called " + this.tchat.Pseudo + "\n", this.tchat, resend);
                    }

                    break;
                default:
                    this.tchat.Send (TchatBox.Encoding.GetBytes ("Command \"" + cmd + "\" not recognized.\n"));
                    break;
            }
        }
    }
}

