using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SQLite;
using System.Threading;
using System.IO;
using RabbitNET;

namespace TP4_II4_SQLite
{
    class Program
    {
        static List<Rabbit> rabList (SQLiteConnection sql_con, string table, int index)
        {
            List<Rabbit> r = new List<Rabbit> ();
            SQLiteDataAdapter cmd = new SQLiteDataAdapter ("SELECT * FROM equipements", sql_con);
            DataTable Dtable = new DataTable ();
            cmd.Fill (Dtable);

            foreach (System.Data.DataRow ligne in Dtable.Rows) {
                if (!ligne.IsNull (index)) {
                    Rabbit rab = new Rabbit ();
                    rab.RabbitNum = Convert.ToByte (ligne [index].ToString ());
                    r.Add (rab);
                }
            }

            return r;
        }

        public static void RunQuery (string query, SQLiteConnection sql_con)
        {
            SQLiteCommand s = new SQLiteCommand (query, sql_con);
            s.ExecuteNonQuery ();
            s.Dispose ();
        }

        public static DataTable GetTable (string query, SQLiteConnection sql_con)
        {
            SQLiteDataAdapter cmd = new SQLiteDataAdapter (query, sql_con);
            DataTable Dtable = new DataTable ();
            cmd.Fill (Dtable);
            return Dtable;
        }

        static void Main (string[] args)
        {
            SQLiteConnection GEIIRabbit = null;

            try {
                GEIIRabbit = new SQLiteConnection ("Data Source=" + Path.GetFullPath (@"..\..\..\TP4_II4_SQLite.sql"));
            } catch (Exception e) {
                Console.WriteLine (e.Message);
                return;
            }

            GEIIRabbit.Open ();
            RunQuery ("DELETE FROM mesures", GEIIRabbit);
            List<Rabbit> rabl = rabList (GEIIRabbit, "equipements", 0);
            List<ReleveRabbit> releves = new List<ReleveRabbit> ();

            foreach (Rabbit r in rabl) {
                DataTable t = GetTable ("SELECT * FROM opsalleequip WHERE RabbitNum='" + r.RabbitNum.ToString () + "'", GEIIRabbit);

                foreach (DataRow dr in t.Rows) {
                    releves.Add (new ReleveRabbit (dr, 4, 10, 11, 3));
                }

                t.Dispose ();
            }

            rabl.Clear ();
            bool cont = true;

            do {
                foreach (ReleveRabbit rel in releves) {
                    try {
                        RunQuery ("INSERT INTO mesures (IdEq, mesure, datemesure) VALUES('" + rel.RabbitNum ().ToString () + "', '" + rel.Temperature ().ToString () + "', DATETIME('NOW'));", GEIIRabbit);
                        Console.WriteLine(rel.Temperature());

                        if (!rel.VerifierTemperature()) {
                            /**
                             * En cas de mauvaise température, dévalidation de l'acquitement
                             * et envoi de mail.
                             *
                             * Si on a pas acquité, ça veut dire que le mail a déjà été envoyé
                             * et donc on ne le renvoi pas.
                             */
                            if (rel.Temperature_ack) {
                                rel.EnvoyerMailTemperature();
                                rel.Temperature_ack = false;
                            } else {
                                Console.WriteLine("Erreur signalée Rabbit " + rel.RabbitNum().ToString());
                            }
                        } else {
                            /**
                             * Si la température est bonne, on acquite automatiquement.
                             */
                            rel.Temperature_ack = true;
                        }
                    } catch (Exception e) {
                        Console.WriteLine("Rabbit " + rel.RabbitNum().ToString() + " injoignable");
                    }
                }

                for (int i = 0; i < 200; i++) {
                    if (Console.KeyAvailable) {
                        cont = false;
                        break;
                    }

                    Thread.Sleep (10);
                }
            } while (cont);

            GEIIRabbit.Close ();
        }
    }
}
