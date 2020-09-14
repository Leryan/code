//
//  Ajout constructeur static
//

using System;
using System.Collections.Generic;
using System.Text;
using System.Net.Mail;
using System.Data;

namespace Tst
{

// Une classe pour le tracage du parcours de code
    class T
    {
        static int Id = 0;
        int id;

        public T(String s)
        {
            Id++;
            id = Id;
            Console.WriteLine("T(" + id.ToString() + ") : " + s);
        }
        ~T()
        {
            Console.WriteLine("Finaliseur T(" + id.ToString() + ")");
        }
    }

    class Parent : IDisposable
    {
        // Pour test initialiseur
        T sp = new T("Preuve de passage dans Initialiseur parent");
        static T Tstaticparent = new T("Preuve de passage dans Initialiseur static parent");

        static Parent()
        {
            Console.WriteLine("Preuve de passage dans le constructeur Static Parent");
        }

        public Parent()
        {
            Console.WriteLine("Preuve de passage dans Constructeur Parent");
        }

        ~Parent()
        {
            Console.WriteLine("Preuve de passage dans Finaliseur Parent");
        }

        public virtual void Dispose()
        {
            Console.WriteLine("Appel Dispose Parent");
            GC.SuppressFinalize(this);
        }

        public virtual void Methode()
        {
            Console.WriteLine("Preuve de passage dans Methode Parent");
        }

    }

    class Enfant : Parent, IDisposable
    {
        // Pour test initialiseur
        T sp = new T("Preuve de passage dans Initialiseur Enfant");
        static T Tstaticparent = new T("Preuve de passage dans Initialiseur static enfant");

        static Enfant()
        {
            Console.WriteLine("Preuve de passage dans le constructeur Static Enfant");
        }

        public Enfant()
        {
            Console.WriteLine("Preuve de passage dans Constructeur Enfant");
        }

        ~Enfant()
        {
            Console.WriteLine("Preuve de passage dans Finaliseur Enfant");
        }

        public override void Dispose()
        {
            Console.WriteLine("Appel Dispose Enfant");
            base.Dispose();
            GC.SuppressFinalize(this);
        }

        public override void Methode()
        {
            Console.WriteLine("Preuve de passage dans Methode Enfant");
        }

    }

    class Program
    {
        static void Main(string[] args)
        {
            Parent p1, p2;
            Console.WriteLine("********************* Creation Objet 1 *********************");
            p1 = new Enfant();
            Console.WriteLine("********************* Creation Objet 2 *********************");
            p2 = new Enfant();
            Console.WriteLine("********************* Appel Methode *********************");
            p1.Methode();
            p2.Methode();
            Console.WriteLine("********************* De-referencement *********************");
            p1.Dispose();
            p2.Dispose();
            p1 = null;
            p2 = null;
        }
    }
}