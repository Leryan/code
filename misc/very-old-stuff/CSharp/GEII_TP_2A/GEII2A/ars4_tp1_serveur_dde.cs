using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using NDde.Server;
using System.Globalization;

namespace GEII2A
{
    class RAS4_ServeurDDE
    {
        public void ServeurGEII()
        {
            /**
             * On accèdera à var1 par =ServerGEII|Sinus!var1 dans Excel.
             */
            ItemDDE[] items = new ItemDDE[1];
            items[0] = new ItemDDE("var1", "129", false);
            GeiiServer server = new GeiiServer("ServerGEII", "Sinus", items);
            server.Register();

            for (double i = 0; true; i = i + 1.0) {
                items[0].Valeur = Math.Sin(Math.PI * i / 180).ToString(new CultureInfo("en-US"));
                Console.WriteLine(items[0].Valeur);
                Thread.Sleep(10);
            }
        }
    }
}
