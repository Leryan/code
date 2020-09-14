using System;
using System.Net;
using System.Threading;

namespace KirbyMap
{
    class MainClass
    {
        public static void Main (string[] args)
        {
            /*Map MyMap = new Map (new Dimension (10, 10));
            MyMap.AddPlayer (new Player (new Position (0, 0), "Doo"));
            MyMap.AddObstacle (new Obstacle (new Position (1, 2), new ObType (ObMods.EXPLOSIVE, ObTypes.GROUND)));
            MyMap.AddObstacle (new Obstacle (new Position (9, 2), new ObType (ObMods.COLD, ObTypes.GROUND)));
            MyMap.AddObstacle (new Obstacle (new Position (5, 5), new ObType (ObMods.HOT, ObTypes.GROUND)));
            KirbyServer SRVGame = new KirbyServer (MyMap, IPAddress.Parse ("127.0.0.1"), 60606, false);
            SRVGame.Start ();*/
            STchat SRVTchat = new STchat (60606);
            SRVTchat.Start ();
            bool cont = true;

            while (cont) {
                Console.WriteLine ("Commands : \n\t/quit\n\t/restart\n\t/start\n\t/stop");
                string s = Console.ReadLine ().Trim ().ToLower ();

                if (s [0] == '/') {
                    switch (s) {
                        case "/quit":
                            SRVTchat.Quit ();
                            cont = false;
                            break;
                        case "/restart":
                            SRVTchat.Restart ();
                            break;
                        case "/start":
                            SRVTchat.Start ();
                            break;
                        case "/stop":
                            SRVTchat.Stop ();
                            break;
                        default:
                            break;
                    }
                }
            }

            //SRVGame.Stop ();
        }
    }
}
