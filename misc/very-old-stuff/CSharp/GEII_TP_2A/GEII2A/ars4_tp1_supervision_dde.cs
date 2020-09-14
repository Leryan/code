using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NDde.Client;

namespace GEII2A
{
    class SupervisionDDE
    {
        public void MAIN()
        {
            /**
             * Déclaration d'un objet permettant de discuter
             * en DDE. L'objet est paramétré dès sa création
             * pour pouvoir discuter avec l'application Excel
             * et avec le sujet Feuil1.
             *
             * Ensuite on se connecte avec la méthode Connect()
             *
             * Le try-catch permet de quitter le programme
             * proprement en signalant l'erreur à l'utilisateur.
             *
             * Pour tester ce code il suffira de fermer Excel.
             */
            DdeClient client = new DdeClient("Excel", "Feuil1");

            try {
                client.Connect();
            } catch {
                Console.WriteLine("Erreur de connexion.");
                Console.ReadKey();
                return;
            }

            /**
             * Une fois connecté (après vérifications avec un zoli
             * try-catch bien placé) on peut récupérer des valeurs
             * ou en écrire.
             *
             * Ici on récupère la valeur au format texte de la
             * cellule L1C1 dans la Feuil1 de l'application Excel,
             * avec un timeout de 50ms qui permet de dire qu'il
             * y a un problème si l'application n'a pas répondue
             * dans ce laps de temps.
             *
             * Et comme on ne fait pas les choses pour rien, on
             * affiche au moins la valeur récupérée.
             */
            try {
                String value = client.Request("L1C1", 50);
                Console.WriteLine("Value L1C1 : " + value.ToString());
            } catch {
                Console.WriteLine("(E) Valeur L1C1 non récupérée.");
            }

            /**
             * On pousse une valeur dans la cellule L1C3 avec un
             * timeout de 50ms, pour la même raison évoquée plus
             * haut.
             */
            try {
                Console.WriteLine("Ecriture sur L2C3");
                client.Poke("L2C3", "Bidule", 50);
            } catch {
                Console.WriteLine("(E) écriture sur L2C3.");
            }

            /**
             * Ici on réalise un abonnement sur la cellule L1C2
             * avec les paramètres suivants :
             *
             * String  : nom de l'Item
             * Int32   : type de retour
             * Boolean : on précise si la donnée doit être avec
             * la notification de changement -> HotLink
             * Int32   : un timeout qui donne le temps à attendre
             * avant de recevoir une réponse.
             */
            try {
                Console.WriteLine("Abonnement L2C3.");
                client.StartAdvise("L2C3", 1, true, 1000);
                /**
                 * On lie une fonction à la réception d'un changement
                 * par HotLink. Ici, OnAdvise déclarée plus loin.
                 */
                client.Advise += OnAdvise;
            } catch {
                Console.WriteLine("(E) abonnement L2C3.");
            }

            //Soyons polit.
            client.Disconnect();
            Console.ReadKey();
        }

        /**
         * Fonction qui est utilisée quand on recoit un changement
         * avec l'abonnement. Il y a des arguments qui sont la/les valeur(s)
         * récupérées par l'abonnement.
         */
        private void OnAdvise(object sender, DdeAdviseEventArgs args)
        {
            Console.WriteLine("OnAdvise : " + args.Text);
        }
    }
}