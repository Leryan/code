using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using NDde.Server;
using Opc.Da;

namespace GEII2A
{
    class ARS4_controle
    {
        string rabbitLocal = "201.";
        string rabbitRemote = "205.";
        bool potar128 = false;
        bool dispLumiere = false;
        int potarValLocal = 255;
        int potarValRemote = 255;
        const int CH_POT = 0;
        const int CH_LUM = 1;
        const int CH_ETOR = 2;
        const int CH_STOR = 3;

        public void ServeurDDE()
        {
            /**
             * On accèdera à var1 par =ServerGEII|Cuve!Niveau dans Excel.
             */
            ItemDDE[] items = new ItemDDE[1];
            items[0] = new ItemDDE("Niveau", "0", false);
            GeiiServer server = new GeiiServer("ServerGEII", "Cuve", items);
            server.Register();

            for (int i = 0; true; i++) {
                items[0].Valeur = ((Convert.ToInt32(items[0].Valeur) + 1) % 100).ToString();
                Console.WriteLine(items[0].Valeur);
                Thread.Sleep(100);
            }
        }
        public void MAIN_DDE()
        {
            Opc.URL urlLocal = new Opc.URL("opcda://localhost/kepdde");
            Server srvLocal = new Server(new OpcCom.Factory(), urlLocal);

            /**
             * Pas la peine d'aller plus loin si la connexion
             * échoue.
             */
            try {
                srvLocal.Connect();
            } catch {
                Console.WriteLine("Connexion impossible : " + srvLocal.Name);
                Console.ReadKey();
                return;
            }

            Subscription groupLocal;
            SubscriptionState groupStateLocal = new SubscriptionState();
            groupStateLocal.Name = "GroupLocal";
            groupStateLocal.Active = true;
            groupStateLocal.ClientHandle = 1;
            groupStateLocal.UpdateRate = 500;
            groupLocal = (Subscription)srvLocal.CreateSubscription(groupStateLocal);
            groupLocal.DataChanged += new DataChangedEventHandler(OnTransactionCompletedLocal);
            /* Déclaration des items */
            Item[] itemsLocal = InitItems(1);
            /* Configuration des items */
            /* La correspondance CH_XXX et l'indice de tableau est ici
             * faisable car on utilise tout. Ca n'est pas le cas
             * pour itemsRemote
             */
            itemsLocal[0].ItemName = rabbitLocal + "Entrees.Ana2";
            itemsLocal[0].ClientHandle = 0;
            itemsLocal = groupLocal.AddItems(itemsLocal);
            ItemValue[] itemvalLocal = InitItemsVal(ref itemsLocal);
            /***************************/
            srvLocal.Disconnect();
            ServeurDDE();
            Console.ReadKey();
        }

        public void MAIN_OPC()
        {
            Opc.URL urlLocal = new Opc.URL("opcda://localhost/GEII_Nancy.OPC.Rabbit");
            Server srvLocal = new Server(new OpcCom.Factory(), urlLocal);

            /**
             * Pas la peine d'aller plus loin si la connexion
             * échoue.
             */
            try {
                srvLocal.Connect();
            } catch {
                Console.WriteLine("Connexion impossible : " + srvLocal.Name);
                Console.ReadKey();
                return;
            }

            Subscription groupLocal;
            SubscriptionState groupStateLocal = new SubscriptionState();
            groupStateLocal.Name = "GroupLocal";
            groupStateLocal.Active = true;
            groupStateLocal.ClientHandle = 1;
            groupStateLocal.UpdateRate = 500;
            groupLocal = (Subscription)srvLocal.CreateSubscription(groupStateLocal);
            groupLocal.DataChanged += new DataChangedEventHandler(OnTransactionCompletedLocal);
            /* Déclaration des items */
            Item[] itemsLocal = InitItems(4);
            /* Configuration des items */
            /* La correspondance CH_XXX et l'indice de tableau est ici
             * faisable car on utilise tout. Ca n'est pas le cas
             * pour itemsRemote
             */
            itemsLocal[CH_POT].ItemName = rabbitLocal + "Entrees.Ana2";
            itemsLocal[CH_POT].ClientHandle = CH_POT;
            itemsLocal[CH_LUM].ItemName = rabbitLocal + "Entrees.Lumiere";
            itemsLocal[CH_LUM].ClientHandle = CH_LUM;
            itemsLocal[CH_ETOR].ItemName = rabbitLocal + "Entrees.Etor";
            itemsLocal[CH_ETOR].ClientHandle = CH_ETOR;
            itemsLocal[CH_STOR].ItemName = rabbitLocal + "Sorties.Stor";
            itemsLocal[CH_STOR].ClientHandle = CH_STOR;
            itemsLocal = groupLocal.AddItems(itemsLocal);
            ItemValue[] itemvalLocal = InitItemsVal(ref itemsLocal);
            /***************************/
            Subscription groupRemote;
            SubscriptionState groupStateRemote = new SubscriptionState();
            groupStateRemote.Name = "GroupRemote";
            groupStateRemote.Active = true;
            groupStateRemote.ClientHandle = 2;
            groupStateRemote.UpdateRate = 500;
            groupRemote = (Subscription)srvLocal.CreateSubscription(groupStateRemote);
            groupRemote.DataChanged += new DataChangedEventHandler(OnTransactionCompletedRemote);
            Item[] itemsRemote = InitItems(1);
            itemsRemote[0].ItemName = rabbitRemote + "Sorties.Stor";
            itemsRemote[0].ClientHandle = CH_STOR;
            itemsRemote[1].ItemName = rabbitRemote + "Entrees.Ana2";
            itemsRemote[1].ClientHandle = CH_POT;
            itemsRemote = groupRemote.AddItems(itemsRemote);
            ItemValue[] itemvalRemote = InitItemsVal(ref itemsRemote);
            int j = 0;

            while (j < 256) {
                /* Local */
                if (j > 255) {
                    j = 0;
                }

                //itemvalLocal[2].Value = j;
                j++;

                if (potar128) {
                    itemvalLocal[CH_STOR].Value = 255;
                } else {
                    itemvalLocal[CH_STOR].Value = 0;
                }

                groupLocal.Write(itemvalLocal);
                /* Remote */
                itemvalRemote[0].Value = potarValLocal;
                groupRemote.Write(itemvalRemote);
                /* END */
                Thread.Sleep(200);
            }

            srvLocal.Disconnect();
        }

        public Item[] InitItems(int size)
        {
            Item[] items = new Opc.Da.Item[size];

            for (int i = 0; i < items.Length; i++) {
                items[i] = new Opc.Da.Item();
            }

            return items;
        }

        public ItemValue[] InitItemsVal(ref Item[] items)
        {
            ItemValue[] itemval = new Opc.Da.ItemValue[items.Length];

            for (int i = 0; i < itemval.Length; i++) {
                itemval[i] = new ItemValue(items[i]);
            }

            return itemval;
        }

        protected void OnTransactionCompletedLocal(object grphandle, object hReq, ItemValueResult[] itemsres)
        {
            for (int i = 0; i < itemsres.Length; i++) {
                int iCH = Convert.ToInt32(itemsres[i].ClientHandle);

                if (iCH == CH_POT) {
                    Console.WriteLine("Local POT : " + itemsres[i].Value);
                    /*if (Convert.ToInt32(itemsres[i].Value) >= 128) potar128 = true;
                    else potar128 = false;*/
                    potarValLocal = Convert.ToInt32(itemsres[i].Value);
                } else if (iCH == CH_LUM) {
                    if (dispLumiere) {
                        Console.WriteLine("Local LUM : " + itemsres[i].Value);
                    }
                } else if (iCH == CH_ETOR) {
                    Console.WriteLine("Local ETOR : " + itemsres[i].Value);
                } else if (iCH == CH_STOR) {
                    Console.WriteLine("Local STOR : " + itemsres[i].Value);
                }
            }
        }

        protected void OnTransactionCompletedRemote(object grphandle, object hReq, ItemValueResult[] itemsres)
        {
            for (int i = 0; i < itemsres.Length; i++) {
                int iCH = Convert.ToInt32(itemsres[i].ClientHandle);

                if (iCH == CH_STOR) {
                    Console.WriteLine("Remote STOR : " + itemsres[i].Value);
                } else if (iCH == CH_POT) {
                    Console.WriteLine("Remote POT : " + itemsres[i].Value);
                    potarValRemote = Convert.ToInt32(itemsres[i].Value);
                }
            }
        }
    }
}
