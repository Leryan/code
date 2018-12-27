// F. Chaxel 2008
using System;
using System.Threading;
using System.Net.Sockets;
using System.Net;

namespace RouCaf
{

    class CarteIO : IDisposable
    {
        private UdpClient Udp = null;
        private static CarteIO instance = null;

        private byte EtatE;
        private System.Threading.AutoResetEvent EvRecp;


        private void Init(string HostIP)
        {
            if (instance != null) {
                throw new ApplicationException("Désole, un seul objet de cette classe : je suis un Singleton");
            }

            instance = this;
            Udp = new UdpClient();
            Udp.Connect(HostIP, 31167);
            EvRecp = new AutoResetEvent(false);
        }

        public CarteIO(string Add)
        {
            Init(Add);
        }
        public CarteIO()
        {
            Init("127.0.0.1");
        }

        public static CarteIO Instance
        {
            get {
                return instance;
            }
        }

        private void Destruction()
        {
            Udp.Close();
            EvRecp = null;
            instance = null;
        }

        ~CarteIO()
        {
            Destruction();
        }

        public void Dispose()
        {
            if (this != instance) {
                throw new ObjectDisposedException("Tu plaisantes ou quoi ?");
            }

            Destruction();
            GC.SuppressFinalize(this);
        }


        // Ev de reception
        private void ReceiveCallback(IAsyncResult ar)
        {
            byte[] reception = null;
            IPEndPoint RemoteIpEndPoint = new IPEndPoint(IPAddress.Any, 0);
            reception = Udp.EndReceive(ar, ref RemoteIpEndPoint);
            EtatE = reception[0];
            EvRecp.Set();
        }

        public byte EntreesSorties(short Sorties)
        {
            if (this != instance) { // Appel realisable après un dispose
                throw new InvalidOperationException("Tu plaisantes ou quoi ?");
            }

            // Envoi
            byte[] Envoi = new byte[2];
            Envoi[0] = (byte)(Sorties & 0xFF);
            Envoi[1] = (byte)((Sorties & 0xFF00) >> 8);

            try {
                // S'il y a des données en stock dans le buffer provenant du coup précédent (avec TimeOut), alors on vide
                if (Udp.Available != 0) {
                    IPEndPoint RemoteIpEndPoint = new IPEndPoint(IPAddress.Any, 0);
                    byte[] poubelle = Udp.Receive(ref RemoteIpEndPoint);
                }

                Udp.Send(Envoi, 2);
                // Reception Asynchrone avec TimeOut 100 ms C'est la seule façon de faire ça sans utiliser explicitement un Thread
                EvRecp.Reset();
                Udp.BeginReceive(new AsyncCallback(ReceiveCallback), null);

                if (EvRecp.WaitOne(100, true) == true) {
                    return EtatE;
                } else {
                    throw new SocketException();
                }
            } catch {
                throw new SocketException();
            }
        }
    }
}