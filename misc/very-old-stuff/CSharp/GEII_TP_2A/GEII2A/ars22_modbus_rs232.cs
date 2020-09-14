using System;
using System.IO.Ports;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Timers;

namespace GEII2A
{
    class CommandeModbus
    {
        public System.Timers.Timer tmrErreur;
        public static SerialPort Port;
        public int LengthRepEcrire = 8;
        public byte[] TrameEcrire;
        public byte[] TrameRecue;

        public CommandeModbus(String SPort, int BaudRate, Parity PAR, int ByteLength, StopBits SB)
        {
            Port = new SerialPort(SPort, BaudRate, PAR, ByteLength, SB);
            Port.DataReceived += new SerialDataReceivedEventHandler(Port_DataReceived);
            this.TrameRecue = new byte[8];
            this.tmrErreur = new System.Timers.Timer(2000);
            this.tmrErreur.Elapsed += new ElapsedEventHandler(tmrErreur_Elapsed);
        }

        void tmrErreur_Elapsed(object sender, ElapsedEventArgs e)
        {
            this.tmrErreur.Enabled = false;
            Console.WriteLine("Erreur, esclave " + this.TrameEcrire[0].ToString() + " ne répond pas.");
        }

        void Port_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            this.TrameRecue = new byte[Port.BytesToRead];
            Port.Read(TrameRecue, 0, this.TrameRecue.Length);
            this.AfficheTrame(TrameRecue, "Trame reçue\n\t->");
        }

        public void InitTrameEcrire(byte AddrEsc, byte CodeFunc, byte AddrHFirstW, byte AddrLFirstW, byte xHWords, byte xLWords, byte xBytes, byte[] Values)
        {
            this.TrameEcrire = new byte[9 + Values.Length];
            this.TrameEcrire[0] = AddrEsc;
            this.TrameEcrire[1] = CodeFunc;
            this.TrameEcrire[2] = AddrHFirstW;
            this.TrameEcrire[3] = AddrLFirstW;
            this.TrameEcrire[4] = xHWords;
            this.TrameEcrire[5] = xLWords;
            this.TrameEcrire[6] = xBytes;
            this.SetValue(Values);
            this.Trame_Modbus_Calc_CRC(this.TrameEcrire);
        }

        public void InitTrameLire(byte AddrEsc, byte CodeFunc, byte AddrHFirstW, byte AddrLFirstW, byte xHWords, byte xLWords)
        {
            this.TrameEcrire = new byte[8];
            this.TrameEcrire[0] = AddrEsc;
            this.TrameEcrire[1] = CodeFunc;
            this.TrameEcrire[2] = AddrHFirstW;
            this.TrameEcrire[3] = AddrLFirstW;
            this.TrameEcrire[4] = xHWords;
            this.TrameEcrire[5] = xLWords;
            this.Trame_Modbus_Calc_CRC(this.TrameEcrire);
        }

        public void EnvoyerTrame()
        {
            this.tmrErreur.Enabled = true;
            this.tmrErreur.Start();
            this.Trame_Modbus_Calc_CRC(this.TrameEcrire);
            Port.Write(this.TrameEcrire, 0, this.TrameEcrire.Length);
        }

        public byte[] RecevoirTrame(int length)
        {
            byte[] bbuff = new byte[length];
            Port.Read(bbuff, 0, bbuff.Length);
            return bbuff;
        }

        public void AfficheTrame(byte[] trame, String truc)
        {
            Console.Write(truc);

            for (int i = 0; i < trame.Length; i = i + 1) {
                Console.Write(String.Format("{0:x}", trame[i]).ToUpper() + "  ");
            }

            Console.WriteLine();
        }

        public void SetEsclave(byte esc)
        {
            this.TrameEcrire[0] = esc;
        }

        public void SetValue(byte[] val)
        {
            for (int i = 0; i < val.Length; i++) {
                this.TrameEcrire[7 + i] = val[i];
            }
        }

        void Trame_Modbus_Calc_CRC(byte[] Trame)
        {
            int Retenue, Carry;
            byte CRC_H = 0xFF, CRC_L = 0xFF;
            int Taille;
            Taille = Trame.Length;

            for (int i = 0; i < Taille - 2; i++) {
                CRC_L = (byte)(CRC_L ^ Trame[i]);

                for (int j = 0; j <= 7; j++) {
                    Carry = (CRC_H & 0x01);
                    Retenue = (CRC_L & 0x01);
                    CRC_H = (byte)(CRC_H / 2);
                    CRC_L = (byte)(CRC_L / 2);

                    if (Carry == 1) {
                        CRC_L = (byte)(CRC_L | 0x80);
                    }

                    if (Retenue == 1) {
                        CRC_H = (byte)(CRC_H ^ 0xA0);
                        CRC_L = (byte)(CRC_L ^ 0x01);
                    }
                }
            }

            Trame[Taille - 2] = CRC_L;
            Trame[Taille - 1] = CRC_H;
        }

        public void MAIN()
        {
            CommandeModbus CMB = new CommandeModbus("COM4", 19200, Parity.None, 8, StopBits.One);
            byte[] ValEcr = {0x00, 0x00};
            CMB.InitTrameEcrire(0x0F, 0x10, 0x00, 0x10, 0x00, 0x01, 0x02, ValEcr);
            byte[] VALL = new byte[2];

            if (CommandeModbus.Port.IsOpen == false) {
                CommandeModbus.Port.Open();
            }

            /* Petite animation sympathique*/
            int milliW = 20;
            int milliS = 100;
            CMB.SetEsclave(0x0E);
            CMB.SetValue(ValEcr);
            CMB.EnvoyerTrame();
            CMB.AfficheTrame(CMB.TrameEcrire, "Trame ecrite :\n");
            Thread.Sleep(milliW);

            for (byte addr = 0x0F; addr > 0x0D; addr--) {
                CMB.SetEsclave(addr);

                for (byte val = 0x00; val < 0x10; val++) {
                    byte[] vall = {0x00, val};
                    CMB.SetValue(vall);
                    CMB.EnvoyerTrame();
                    CMB.AfficheTrame(CMB.TrameEcrire, "Trame ecrite :\n");
                    Thread.Sleep(milliS);
                }
            }

            for (byte val = 0x0F; val < 0xFF; val--) {
                byte[] vall = { 0x00, val };
                CMB.SetEsclave(0x0E);
                CMB.SetValue(vall);
                CMB.EnvoyerTrame();
                CMB.AfficheTrame(CMB.TrameEcrire, "Trame ecrite :\n");
                Thread.Sleep(milliW);
                CMB.SetEsclave(0x0F);
                CMB.SetValue(vall);
                CMB.EnvoyerTrame();
                CMB.AfficheTrame(CMB.TrameEcrire, "Trame ecrite :\n");
                Thread.Sleep(milliS);
            }

            /**/
            String s;

            do {
                Console.Write("Choisir l'esclave : ");
                s = Console.ReadLine();

                try {
                    CMB.SetEsclave(Convert.ToByte(s));
                    Console.Write("Choisir la valeur à écrire : ");
                    s = Console.ReadLine();
                    VALL[0] = 0x00;
                    VALL[1] = Convert.ToByte(s);
                    CMB.SetValue(VALL);
                    CMB.EnvoyerTrame();
                    Thread.Sleep(50);
                } catch {
                    break;
                }
            } while (true);

            Console.WriteLine("Recopie des entrées esclave 0x0E sur les leds de 0X0E");
            CMB.InitTrameLire(0x0E, 0x03, 0x00, 0x00, 0x00, 0x01);
            CMB.EnvoyerTrame();
            Thread.Sleep(50);
            VALL[0] = 0x00;
            VALL[1] = CMB.TrameRecue[5]; //Problème à la réception de la trame si on a pas finit de la recevoir...
            CMB.InitTrameEcrire(0x0E, 0x10, 0x00, 0x10, 0x00, 0x01, 0x02, VALL);
            CMB.EnvoyerTrame();
            Console.ReadKey();
            CommandeModbus.Port.Close();
        }
    }
}
