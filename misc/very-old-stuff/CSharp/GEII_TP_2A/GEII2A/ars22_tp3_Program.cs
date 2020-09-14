using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Sockets;
using System.Net;
using System.Threading;
using System.Net.Mail;

namespace GEII2A
{
    class ARS22_TP3
    {
        HttpListener serveurWeb;

        public void ReceptionDmdWeb(IAsyncResult ar)
        {
            HttpListenerContext context;

            try {
                context = serveurWeb.EndGetContext(ar);
                HttpListenerResponse response = context.Response;
                System.IO.Stream output = response.OutputStream;
                string html = "<html><body><p>";
                html += "</p></body></html>";
                byte[] message = Encoding.UTF8.GetBytes(html);
                output.Write(message, 0, message.Length);
                output.Close();
                serveurWeb.BeginGetContext(new AsyncCallback(ReceptionDmdWeb), null);
            } catch (Exception e) {
            }
        }

        public void LancerServeurWebParLaFenetre(int port)
        {
            serveurWeb = new HttpListener();
            serveurWeb.Prefixes.Add("http://+:" + port + "/MesPages/");
            serveurWeb.Start();
            serveurWeb.BeginGetContext(new AsyncCallback(ReceptionDmdWeb), null);

            while (!serveurWeb.IsListening) {
                ;
            }

            Console.WriteLine("Serveur web lancé port " + port);
            serveurWeb.Close();

            while (serveurWeb.IsListening) {
                ;
            }

            Console.WriteLine("Serveur web fermé.");
        }
    }
}
