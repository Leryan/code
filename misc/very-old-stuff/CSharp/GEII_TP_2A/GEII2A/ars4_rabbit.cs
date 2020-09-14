using System;
using System.Text;
using RabbitNET;
using System.Threading;
using System.Globalization;
using NDde.Server;
using NDde.Client;
using NDde.Advanced;

namespace GEII2A
{
    class ARS4_Rabbit
    {
        public void ServeurDDE()
        {
            Rabbit R = new Rabbit();
            R.RabbitNum = 203;
            ItemDDE[] items = new ItemDDE[8];
            items[0] = new ItemDDE("temp", "", true);
            items[1] = new ItemDDE("lum", "", true);

            for (int i = 2; i < 8; i++) {
                items[i] = new ItemDDE("tor" + i.ToString(), "", true);
            }

            GeiiServer server = new GeiiServer("ServerRabbit", "Board", items);
            server.Register();

            while (true) {
                if (R.Acquisition_Synchrone() == true) {
                    items[0].Valeur = R.Temperature.ToString();
                    items[1].Valeur = R.Lumiere.ToString();

                    for (int i = 2; i < 8; i++) {
                        items[i].Valeur = (R.ETOR & (1 << (i - 2))).ToString();
                        Console.WriteLine(items[i].Valeur.ToString());
                    }
                } else {
                    Console.WriteLine("Ca marche pas !");
                }

                Thread.Sleep(100);
            }
        }
    }
}
