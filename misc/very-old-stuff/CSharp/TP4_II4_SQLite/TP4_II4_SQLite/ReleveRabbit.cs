using System;
using System.Data;
using System.Data.SQLite;
using RabbitNET;

namespace TP4_II4_SQLite
{
    public class ReleveRabbit
    {
        private Rabbit rabbit;
        private DataRow informations;
        private int sql_min;
        private int sql_max;
        private int sql_mail;
        private int sql_rabnum;
        public bool Temperature_ack;

        public int RabbitNum ()
        {
            return (int)(this.rabbit.RabbitNum);
        }

        public ReleveRabbit (DataRow informations, int rabnum, int min, int max, int mail)
        {
            this.informations = informations;
            this.sql_mail = mail;
            this.sql_max = max;
            this.sql_min = min;
            this.sql_rabnum = rabnum;
            this.Temperature_ack = true;
            this.rabbit = new Rabbit ();
            this.rabbit.RabbitNum = Convert.ToByte (this.informations.ItemArray [rabnum]);
        }

        public bool VerifierTemperature ()
        {
            double temp;

            try {
                temp = Convert.ToDouble (this.Temperature ().ToString ());
            } catch (Exception e) {
                return false;
            }

            double min = Convert.ToDouble (this.informations.ItemArray [this.sql_min]);
            double max = Convert.ToDouble (this.informations.ItemArray [this.sql_max]);

            if ((temp < min || temp > max)) {
                return false;
            }

            return true;
        }

        public bool EnvoyerMailTemperature ()
        {
            Console.WriteLine("Mail envoyé à " + this.informations.ItemArray[this.sql_mail]);
            /**
             * code pour l'envoi du mail avec SMTP et bla bla et blabla...
             */
            return true;
        }

        public double Temperature ()
        {
            if (this.rabbit.Acquisition_Synchrone ()) {
                return this.rabbit.Temperature * 0.395 - 25.8;
            }

            throw new Exception ("Acquisition Temperature sur Rabbit " + this.rabbit.RabbitNum.ToString () + " a échoué.");
        }
    }
}

