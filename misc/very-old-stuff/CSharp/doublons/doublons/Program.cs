using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using System.IO;

namespace doublons
{
    public class Fichier
    {
        private MD5 md5;
        private string m_Path;
        public string FilePath
        {
            get {
                return this.m_Path;
            }
            private set {
                this.m_Path = value;
            }
        }

        public Fichier(string path)
        {
            this.m_Path = Path.GetFullPath(path);
            this.md5 = MD5.Create();
        }

        public string GetTextMD5()
        {
            string s = "";
            byte[] h = this.GetMD5();
            foreach (byte b in h) {
                s += String.Format("{0:x2}", b);
            }
            return s;
        }

        public byte[] GetMD5()
        {
            StreamReader io = new StreamReader(this.m_Path);
            this.md5.ComputeHash(io.BaseStream);
            io.Close();
            io.Dispose();
            return this.md5.Hash;
        }
    }

    public static class RecursiveFileList
    {
        public const int Inf = -1;
        public static List<string> GetDirList(string d_start, int recurse)
        {
            List<string> dirs = Directory.GetDirectories(Path.GetFullPath(d_start)).ToList<string>();
            List<string> ld = new List<string>();
            if (recurse > 0 || recurse == RecursiveFileList.Inf) {
                foreach (string dir in dirs) {
                    if (recurse > 0) { recurse--; }
                    ld.AddRange(GetDirList(dir, recurse));
                }
            }
            ld.AddRange(dirs);
            return ld;
        }

        public static List<Fichier> GetFileList(string dir, int recurse)
        {
            List<Fichier> lf = new List<Fichier>();
            List<string> dir_list = new List<string>();
            if (recurse > 0) { dir_list.AddRange(RecursiveFileList.GetDirList(dir, --recurse)); }
            else if (recurse == RecursiveFileList.Inf) { dir_list.AddRange(RecursiveFileList.GetDirList(dir, recurse)); }
            dir_list.Add(Path.GetFullPath(dir));
            foreach (string s in dir_list) {
                string[] f = Directory.GetFiles(s);
                foreach (string d in f) {
                    lf.Add(new Fichier(d));
                }
            }
            return lf;
        }
    }

    public class DDD
    {
        private string logger_path;
        public DDD(string logger)
        {
            this.logger_path = Path.GetFullPath(logger);
        }

        public void MD5Sums(string dir, int recurse)
        {
            List<Fichier> lf = RecursiveFileList.GetFileList(dir, recurse);
            StreamWriter logger = new StreamWriter(this.logger_path);
            foreach (Fichier ff in lf) {
                try {
                    logger.WriteLine(ff.GetTextMD5() + " : " + ff.FilePath);
                } catch (Exception e) {
                    Console.Error.WriteLine(e.Message);
                }
            }
            logger.Flush();
            logger.Close();
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            DDD d = new DDD(@"C:\Users\leryan\Desktop\md5sums.txt");
            d.MD5Sums(@"C:\Users\leryan\Desktop", RecursiveFileList.Inf);
        }
    }
}
