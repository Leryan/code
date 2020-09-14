using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Sockets;
using System.Net;
using System.Threading;

namespace GEII2A
{
    class MyOpenModbus
    {
        TcpClient sok;

        public MyOpenModbus(string address, int port)
        {
            this.sok = new TcpClient(AddressFamily.InterNetwork);

            try {
                this.sok.Connect(address, port);
            } catch (Exception e) {
                Console.WriteLine("Connexion au serveur non effectuée.");
            }

            Console.WriteLine("Connexion au serveur OpenModbus effectuée.");
        }

        ~MyOpenModbus()
        {
            if (this.sok.Connected) {
                this.sok.Close();
            }
        }

        // Envoi de la requete de demande d'écriture d'un mot
        // Provoque une exception en cas de problème sur le port
        //    à l'appelant de mettre en place un try catch autour de l'appel
        public void WriteTcpWordRequest(short AddrMot, short Valeur)
        {
            byte[] Trame = new byte[15];
            Trame[0] = 0; //Entête
            Trame[1] = 0; //Entête 2
            Trame[2] = 0; // 0
            Trame[3] = 0; // 0
            Trame[4] = 0; // 0
            Trame[5] = 9; // Taille Modbus = 9
            Trame[6] = 0; // Esclave : osef -> 0
            Trame[7] = 0x10; // Ecriture de n Mots de 16 Bits.
            Trame[8] = (byte)(AddrMot / 256); // Découpage de l'adresse sur deux octets.
            Trame[9] = (byte)(AddrMot % 256);
            Trame[10] = 0; // Un seul mot à écrire.
            Trame[11] = 1;
            Trame[12] = 2; // Un seul mot à écrire sur deux octets.
            Trame[13] = (byte)(Valeur / 256);
            Trame[14] = (byte)(Valeur % 256);
            // Emission avec TimeOut de 100ms
            this.sok.SendTimeout = 100;

            try {
                this.sok.Client.Send(Trame);
            } catch (Exception e) {
                Console.WriteLine("Envoi échoué");
            }
        }

        public void ReadTcpWordRequest(short AddrMot)
        {
            byte[] Trame = new byte[12];
            Trame[0] = 0; //Entête
            Trame[1] = 0; //Entête 2
            Trame[2] = 0; // 0
            Trame[3] = 0; // 0
            Trame[4] = 0; // 0
            Trame[5] = 6; // Taille Modbus = 6
            Trame[6] = 0; // Esclave : osef -> 0
            Trame[7] = 3; // Lecture de n Mots de 16 Bits.
            Trame[8] = (byte)(AddrMot / 256); // Découpage de l'adresse sur deux octets.
            Trame[9] = (byte)(AddrMot % 256);
            Trame[10] = 0; // Un seul mot à lire.
            Trame[11] = 1;
            // Emission avec TimeOut de 100ms
            this.sok.SendTimeout = 100;

            try {
                this.sok.Client.Send(Trame);
            } catch (Exception e) {
                Console.WriteLine("Envoi échoué");
            }
        }
        // Récupération de la reponse en provenance de l'équipement
        // analyse de la trame
        // retourne false si rien reçu ou réception d'un truc sans intéret
        // retourne true si tout est OK
        // Provoque une exception en cas de problème sur le port
        //    à l'appelant de mettre en place un try catch autour de l'appel
        public bool ReadTcpWordConfirm(out short Valeurlue, int TimeOut)
        {
            Valeurlue = 0;
            byte[] TrameRecp = new byte[32];
            int NbOct;
            this.sok.Client.ReceiveTimeout = TimeOut;

            try {
                NbOct = this.sok.Client.Receive(TrameRecp);
            } catch (Exception e) {
                return false;
            }

            // Code fonction 3 ou 4, 2 octets en retour et taille de la trame de 11 octets.
            if ((((TrameRecp[7] == 0x3) || (TrameRecp[7] == 0x4)) && (TrameRecp[8] == 2)) && NbOct == 11) {
                Valeurlue = (short)(TrameRecp[9] * 256 + TrameRecp[10]);
                return true;
            }

            return false;
        }

        // Récupération de la reponse en provenance de l'équipement
        // analyse de la trame
        // retourne false si rien reçu ou réception d'un truc sans intéret
        // retourne true si tout est OK
        // Provoque une exception en cas de problème sur le port
        //    à l'appelant de mettre en place un try catch autour de l'appel
        public bool WriteTcpWordConfirm(int TimeOut)
        {
            byte[] TrameRecp = new byte[32];
            int NbOct;
            this.sok.Client.ReceiveTimeout = TimeOut;

            try {
                NbOct = this.sok.Client.Receive(TrameRecp);
            } catch (Exception e) {
                return false;
            }

            // Code fonction 0x10 ou 0x05, taille de la trame de 12 octets.
            if ((((TrameRecp[7] == 0x10) || (TrameRecp[7] == 0x05))) && NbOct == 12) {
                return true;
            }

            return false;
        }

        public bool ReadTcpWord(short AddrMot, out short Val, int TimeOut)
        {
            this.ReadTcpWordRequest(AddrMot);
            return this.ReadTcpWordConfirm(out Val, TimeOut);
        }

        public bool WriteTcpWord(short AddrMot, short Val, int TimeOut)
        {
            this.WriteTcpWordRequest(AddrMot, Val);
            return this.WriteTcpWordConfirm(TimeOut);
        }
    }
}
