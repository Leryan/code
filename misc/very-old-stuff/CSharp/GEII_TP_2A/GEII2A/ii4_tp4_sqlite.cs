using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SQLite;
using System.Threading;
using RabbitNET;

namespace GEII2A
{
    class II4_SQLite
    {
        public List<Rabbit> rabList(SQLiteConnection sql_con, string table, int index)
        {
            List<Rabbit> r = new List<Rabbit>();
            SQLiteDataAdapter cmd = new SQLiteDataAdapter("SELECT * FROM equipements", sql_con);
            DataTable Dtable = new DataTable();
            cmd.Fill(Dtable);

            foreach (System.Data.DataRow ligne in Dtable.Rows) {
                if (!ligne.IsNull(index)) {
                    Rabbit rab = new Rabbit();
                    rab.RabbitNum = Convert.ToByte(ligne[index].ToString());
                    r.Add(rab);
                }
            }

            return r;
        }

        public double tempRab(Rabbit rab)
        {
            if (rab.Acquisition_Synchrone()) {
                return rab.Temperature * 0.395 - 25.8;
            }

            return -273;
        }

        public void RunQuery(string query, SQLiteConnection sql_con)
        {
            SQLiteCommand s = new SQLiteCommand(query, sql_con);
            s.ExecuteNonQuery();
            s.Dispose();
        }

        public DataTable GetTable(string query, SQLiteConnection sql_con)
        {
            SQLiteDataAdapter cmd = new SQLiteDataAdapter(query, sql_con);
            DataTable Dtable = new DataTable();
            cmd.Fill(Dtable);
            return Dtable;
        }

        public void MAIN()
        {
            SQLiteConnection GEIIRabbit = null;

            try {
                GEIIRabbit = new SQLiteConnection(@"Data Source=..\..\..\TP4_II4_SQLite.sql");
            } catch (Exception e) {
                Console.WriteLine(e.Message);
                return;
            }

            GEIIRabbit.Open();
            RunQuery("DELETE FROM mesures", GEIIRabbit);

            do {
                List<Rabbit> l = rabList(GEIIRabbit, "equipements", 0);

                foreach (Rabbit r in l) {
                    RunQuery("INSERT INTO mesures (IdEq, mesure, datemesure) VALUES('" + r.RabbitNum.ToString() + "', '" + tempRab(r).ToString() + "', DATETIME('NOW'));", GEIIRabbit);
                    DataTable t = GetTable("SELECT * FROM opsalleequip WHERE RabbitNum='" + r.RabbitNum.ToString() + "'", GEIIRabbit);

                    foreach (DataRow dr in t.Rows) {
                        if (Convert.ToInt32(dr.ItemArray[4]) == Convert.ToInt32(r.RabbitNum)) {
                            double temp = Convert.ToDouble(tempRab(r).ToString());
                            double min = Convert.ToDouble(dr.ItemArray[10]);
                            double max = Convert.ToDouble(dr.ItemArray[11]);

                            if ((temp < min || temp > max) && temp != -273) {
                                //On envoi un mail avec les autres informations nécessaires au technicien, comme la position par exemple. Sinon il faut mémoriser à qui on a envoyé un mail et depuis combien de temps pour ne pas spammer la boîte mail.
                                Console.WriteLine("---------------------------\n" + dr.ItemArray[3].ToString() + " " + r.RabbitNum.ToString() + "\n\tMin: " + dr.ItemArray[10].ToString() + "\n\tMax: " + dr.ItemArray[11].ToString() + "\n\tTemperature : " + temp);
                            } else if (temp == -273) {
                                Console.WriteLine("Problème de connexion avec le Rabbit " + r.RabbitNum.ToString());
                            }
                        }
                    }

                    t.Dispose();
                }

                Thread.Sleep(2000);
            } while (!Console.KeyAvailable);

            GEIIRabbit.Close();
        }
    }
}
