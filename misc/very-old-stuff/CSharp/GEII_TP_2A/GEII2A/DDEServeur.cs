// Copyright (C) 2008 F. Chaxel
//
//  This software is provided as-is, without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.

//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:

//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. if you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source distribution.
//
//  Requirement : NDde by Brian Gideon

using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;

/*  exemple d'usage pour 2 Items sous le topic monsujet de l'application name monappli :

            ItemDDE[] items=new ItemDDE[2];

            items[0] = new ItemDDE("var1", "129", false);   // var1 valeur initiale 129, en lecture/ecriture pour les clients
            items[1] = new ItemDDE("var2", "456", false);

            GeiiServer server = new GeiiServer("monappli", "monsujet", items);
            server.Register();  // Serveur prèt

            Console.ReadKey();

            items[0].Valeur = "dsgfsdf";    // Propage automatiquement la modif vers les clients abonnés

            Console.ReadKey();
*/


namespace NDde.Server   // same namespace as DdeServer
{

    class ItemDDE
    {
        public event EventHandler OnPoke;

        private string ItemName;
        private string ItemValue;
        private bool ReadOnly;

        public ItemDDE(String Nom, String ValInitiale, bool LectureSeule)
        {
            ItemName = Nom.ToLower();
            ItemValue = ValInitiale;
            ReadOnly = LectureSeule;
        }
        public string Valeur
        {
            get {
                return ItemValue;
            } set {
                ItemValue = value;

                if (LeServeur != null) {
                    LeServeur.Advise(this);
                }
            }
        }

        public string Nom
        {
            get {
                return ItemName;
            }
        }

        public bool LectureSeule
        {
            get {
                return ReadOnly;
            }
        }

        public GeiiServer LeServeur;

        public void Poke()
        {
            if (OnPoke != null) {
                OnPoke(this, null);
            }
        }
    }

    class GeiiServer : DdeServer
    {

        private string topic;
        private ItemDDE[] lesItems;

        public GeiiServer(string Service, string Topic, ItemDDE[] LesItems) : base(Service)
        {
            topic = Topic.ToLower();
            lesItems = LesItems;

            for (int i = 0; i < LesItems.Length; i++) {
                LesItems[i].LeServeur = this;
            }
        }

        public void Advise(ItemDDE Item)
        {
            base.Advise(topic, Item.Nom) ;
        }

        protected override bool OnBeforeConnect(string topic)
        {
            if (topic.ToLower() == this.topic) {
                return true;
            } else {
                return false;
            }
        }

        protected override bool OnStartAdvise(DdeConversation conversation, string item, int format)
        {
            item = item.ToLower();

            if (format == 1)  // Format CF_TEXT
                for (int i = 0; i < lesItems.Length; i++)
                    if (item == lesItems[i].Nom) {
                        return true;
                    }

            return false;
        }

        protected override PokeResult OnPoke(DdeConversation conversation, string item, byte[] data, int format)
        {
            item = item.ToLower();

            if (format == 1)  // Format CF_TEXT
                for (int i = 0; i < lesItems.Length; i++)
                    if (item == lesItems[i].Nom)
                        if (lesItems[i].LectureSeule == false) {
                            lesItems[i].Valeur = System.Text.Encoding.ASCII.GetString(data);
                            lesItems[i].Poke();
                            return PokeResult.Processed;
                        } else {
                            return PokeResult.NotProcessed;
                        }

            return PokeResult.NotProcessed;
        }

        protected override RequestResult OnRequest(DdeConversation conversation, string item, int format)
        {
            item = item.ToLower();

            if (format == 1)  // Format CF_TEXT
                for (int i = 0; i < lesItems.Length; i++)
                    if (item == lesItems[i].Nom) {
                        return new RequestResult(System.Text.Encoding.ASCII.GetBytes(lesItems[i].Valeur));
                    }

            return RequestResult.NotProcessed;
        }

        protected override byte[] OnAdvise(string topic, string item, int format)
        {
            item = item.ToLower();

            if (format == 1)  // Format CF_TEXT
                for (int i = 0; i < lesItems.Length; i++)
                    if (item == lesItems[i].Nom) {
                        return System.Text.Encoding.ASCII.GetBytes(lesItems[i].Valeur);
                    }

            return null;
        }

    }

}
