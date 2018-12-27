using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SQLite;
using System.IO;
using MegaLib;
using MegaLib.TP4_II1_SQLite_DAL;

namespace TP4_II1
{
    class Program
    {
        static void AfficheDataTable (DataTable t)
        {
            foreach (DataColumn c in t.Columns) {
                Console.Write (c.ToString () + ";");
            }

            Console.WriteLine ();

            foreach (DataRow dr in t.Rows) {
                foreach (object o in dr.ItemArray) {
                    Console.Write (o + ";");
                }

                Console.WriteLine ();
            }
        }

        static void CSV ()
        {
            IDAL csv = new DAL_CSV ();

            try {
                csv.Connexion (Path.GetFullPath (@"..\..\..\"));
                DataTable t = csv.LectureTable ("Mesures.csv");
                AfficheDataTable (t);
            } catch (Exception e) {
            }
        }

        static void SQLite ()
        {
            IDAL sql = new DAL_SQLite ();

            try {
                sql.Connexion (Path.GetFullPath (@"..\..\..\db.sql"));
            } catch {
            }

            DataTable t = sql.LectureTable ("equipements");
            AfficheDataTable (t);
            object[] s = new object[4];
            /*
             * Bien penser à protéger nos chaînes avec des simples quotes.
             * Sinon SQLite va nous jeter.
             *
             * Ca pourrait être fait dans la fonction d'enregistrement,
             * avec des tests sur ce qui est entré, mais, non, c'est peu
             * efficace et c'est bien pour ça qu'on va laisser le soin à
             * l'utilisateur de faire ces vérifications, qui revienent le
             * plus souvent à ajouter des quotes seulement là où il faut.
             */
            s [0] = "'1123354567890987654'";
            s [1] = "'135'";
            s [2] = "'coucou'";
            s [3] = sql.Maintenant ();
            t.Dispose ();

            if (sql.EcrireTable("equipements", s)) {
                DataTable v = sql.LectureTable("equipements");
                AfficheDataTable(v);
            } else {
                Console.WriteLine("Erreur lors de l'enregistrement. Un ID est identique dans la table ?");
            }
        }

        static void Main (string[] args)
        {
            //CSV();
            SQLite ();
        }
    }
}
