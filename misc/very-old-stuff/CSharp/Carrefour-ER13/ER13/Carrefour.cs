/* Copyright (c) 2010-2011, Florent PETERSCHMITT
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of Florent PETERSCHMITT, nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading;
using CmdCrf;

public class Crossroads
{
    /* DEBUT Membres */
    private CmdFeux fx;
    private StreamReader fConfR;
    private StreamWriter fHistoW;
    private int cycles;
    private int[] times;
    private int tMax;
    private int ms;
    private int sleepCommon;
    private int sleepOrange;
    private int sleepSwitch;
    private char sepChar;
    private readonly bool way1;
    private readonly bool way2;
    private bool memEventFlag;
    private bool curWay;

    public string redText;
    public string orangeText;
    public string greenText;
    public string errorText;
    public string conText;
    public string pbText;
    public string groundText;
    public string badColorText;
    public bool run;
    /* FIN Membres */

    /* string  sfConfR   : fichier de config,
     * string  sfHistoW  : fichier historique,
     * bool    EF        : append sur historique,
     * bool    AF        : autoflush historique,
     * char    SEP       : caract�re s�parateur historique,
     * string  CIP       : adresse IP carrefour,
     * int     SC        : temps minimum de communication programme/carrefour (ms),
     * int     STO       : temps feu orange (ms),
     * int     STS       : temps passage rouge/vert (ms),
     */
    public Crossroads(string sfConfR, string sfHistoW, bool EF, bool AF, char SEP, string CIP, int SC, int STO, int STS)
    {
        bool internalRun = true;

        try {
            this.fHistoW = new StreamWriter(sfHistoW, EF);

            try {
                this.fConfR = new StreamReader(sfConfR);
            } catch {
                internalRun = false;
                this.WriteHistory("Erreur", "Fichier " + sfConfR + " introuvable");
            }
        } catch {
            internalRun = false;
        }

        if (internalRun) {
            this.times = new int[4];
            this.fx = new CmdFeux();
            this.fHistoW.AutoFlush = AF;
            this.sepChar = SEP;
            this.memEventFlag = false;
            this.redText = "Rouge";
            this.orangeText = "Orange";
            this.greenText = "Vert";
            this.errorText = "Erreur";
            this.conText = "Connexion";
            this.pbText = "Appui BP";
            this.groundText = "Detecteur";
            this.badColorText = "Couleur invalide";
            this.fx.IPCarrefour = CIP;
            this.sleepCommon = SC;
            this.sleepOrange = STO;
            this.sleepSwitch = STS;
            this.curWay = this.way1 = !(this.way2 = true);
        }
    }

    /* int  sleepTime  : temps en ms pour lequel on ne fait rien,
     * bool writeNet   : �criture sur le r�seau avant la pause de sleepTime ms,
     */
    private void SleepCrossroads(int sleepTime, bool writeNet)
    {
        int i;
        this.RWNetwork(writeNet);

        for (i = 0; i * this.sleepCommon < sleepTime; ++i) {
            Thread.Sleep(this.sleepCommon);
            this.RWNetwork(false);
        }
    }

    /* bool  way     : savoir si way correspond a this.way1,
     *
     * bool  IsWay1  : true ou false si way == this.way1
     */
    public bool IsWay1(bool way)
    {
        if (way == this.way1) {
            return true;
        } else {
            return false;
        }
    }

    /* Fonction inutilis�e, mais qui aurait pu l'�tre.
     *
     * bool  way     : savoir si way correspond a this.way2,
     *
     * bool  IsWay2  : true ou false si way == this.way2
     */
    public bool IsWay2(bool way)
    {
        if (way == this.way2) {
            return true;
        } else {
            return false;
        }
    }

    /* Fonction inutilis�e dans le programme, hormis dans
     * la phase de test.
     *
     * bool  way             : r�cup�rer les num�ros des feux de la voie way,
     *
     * string  GetWayLights  : num�ros des feux sur la voie way
     */
    private string GetWayLights(bool way)
    {
        if (way == this.way1) {
            return "1 2";
        } else {
            return "3 4";
        }
    }

    /* Met tous les feux de CurWay � false
     *
     * bool  way      : mettre tous les feux de way � false,
     * bool  writeNet : �crire les donn�es sur le r�seau,
     */
    private void ResetWayLights(bool way, bool writeNet)
    {
        short i;
        short offset;

        if (way == this.way1) {
            offset = 0;
        } else {
            offset = 2;
        }

        for (i = offset; i < 2 + offset; ++i) {
            this.fx.LesFeux[i].Rouge = false;
            this.fx.LesFeux[i].Orange = false;
            this.fx.LesFeux[i].Vert = false;
        }

        this.RWNetwork(writeNet);
    }

    /* Positionne les feux d'une voie � une couleur donn�e.
     *
     * char  color     : couleur des feux,
     * bool  way       : les feux sur la voie way,
     * cool  writeNet  : �crire les donn�es sur le r�seau,
     */
    private void SetWay(char color, bool way, bool writeNet)
    {
        this.ResetWayLights(way, false);
        short i;
        short offset;

        if (this.IsWay1(way)) {
            offset = 0;
        } else {
            offset = 2;
        }

        for (i = offset; i < 2 + offset; ++i) {
            switch (color) {
                case 'R':
                    this.fx.LesFeux[i].Rouge = true;
                    break;
                case 'O':
                    this.fx.LesFeux[i].Orange = true;
                    break;
                case 'G':
                    this.fx.LesFeux[i].Vert = true;
                    break;
                default:
                    /* Si on en arrive l�, le code de la couleur
                     * n'est pas g�r� par la fonction. Impossible.
                     */
                    this.WriteHistory(this.errorText, this.badColorText);
                    break;
            }
        }

        this.RWNetwork(writeNet);
    }

    /* Change les voies de couleur en respectant la
     * temporisation des couleurs.
     *
     * this.cycles est incr�ment� car un cycle se caract�rise ici
     * par un changement de voie. �tant donn� que le traitement se fait
     * de la m�me mani�re d'une voie � l'autre, pas besoin de faire en sorte
     * qu'un cycle soit le retour du feu vert sur la m�me voie de d�part.
     *
     * Dans le cas o� le programme est pr�vu pour fonctionner � l'infinie,
     * et en supposant qu'on le laisse faire pendant plus de 2 milliards
     * de cycles, l'incr�mentation de this.cycles ne fera pas de d�passement
     * m�moire ou quoi que ce soit. On aura juste un nombre de cycles
     * �ronn�. Mais on s'en tamponne l'oreille avec une babouche.
     */
    private void SwitchWay()
    {
        this.SetWay('O', this.curWay, true);
        this.SleepCrossroads(this.sleepOrange, false);
        this.SetWay('R', this.curWay, true);
        this.SleepCrossroads(this.sleepSwitch, false);
        this.SetWay('G', !this.curWay, true);
        this.curWay = !this.curWay;
        ++this.cycles;
    }

    /* La fonction principale qui, une fois lanc�e, ne s'arr�te que si
     * le nombre de cycles � effectuer est atteint ou ne s'arr�te pas si
     * on a choisi de la lancer � l'infinie.
     *
     * int  doCycles  : nombre de cycles � effectuer, 0 pour infinie,
     */
    public void RunCrossroads(int doCycles)
    {
        this.cycles = 0;
        this.ms = 0;
        bool infinite = false;
        this.SetWay('G', this.curWay, false);
        this.SetWay('R', !this.curWay, false);
        this.ReadConf();
        this.RWNetwork(true);

        if (doCycles == 0) {
            infinite = true;
        }

        while (this.cycles < doCycles || infinite) {
            /* Si on est arriv� � la tempo maximume
             */
            if (this.ms * this.sleepCommon >= this.tMax) {
                /* On met le flag des �v�nements � false car on est arriv� � la
                 * Tempo max sur une voie. On ne surveille donc plus les
                 * m�mes choses.
                 */
                this.memEventFlag = false;
                this.TmaxHit();
            }
            /* Pour aller regarder les �v�nements du carrefour, il faut qu'il n'y ai pas eu
             * d'�v�nement avant.
             */
            else if (!this.memEventFlag && this.ms * this.sleepCommon < this.tMax) {
                this.WayEvents();
            }

            Thread.Sleep(this.sleepCommon);
            ++this.ms;
            this.RWNetwork(false);
        }
    }

    /* On a atteint le temps maximum sur une voie, il est temps d'en
     * changer. Donc changement de la valeur de this.tMax.
     */
    private void TmaxHit()
    {
        this.SwitchWay();

        if (this.IsWay1(this.curWay)) {
            this.tMax = this.times[1];
        } else {
            this.tMax = this.times[3];
        }

        this.ms = 0;
    }

    private void WayEvents()
    {
        short offset;

        if (!this.memEventFlag) {
            if (this.IsWay1(this.curWay)) {
                offset = 0;
            } else {
                offset = 2;
            }

            /* Dans le cas o� on est sur way1 (vert):
             *
             * Si:
             * [On devrait changer le temps mini selon la condition suivante]
             * - BP Feux 1 OU BP Feux 2 OU Detecteur Feux 3 OU Detecteur Feux 4
             *      Mais Si:
             *      - Detecteur Feux 1 OU Detecteur Feux 2 [Pr�sence voiture sur way1]
             *      - PAS (BP Feux 1 OU BP Feux 2) [Les pi�tons restent prioritaires]
             *          Alors:
             *          - this.tMax <= Temps Maxi Voie 1
             *          Sinon:
             *          - this.tMax <= Temps Mini Voie 1
             *
             * Dans le cas o� on est sur way2 (vert):
             * On remplacera les 1 et 2 par 3 et 4 et 3 et 4 par 1 et 2
             * et on reprend le sch�ma pr�c�dent.
             *
             * Sans doute il y avait plus simple pour faire _exactement_ la m�me
             * chose, mais �a marche et c'est compr�hensible.
             */
            if (this.fx.LesFeux[0 + offset].BP
                || this.fx.LesFeux[1 + offset].BP
                || this.fx.LesFeux[2 - offset].Detecteur
                || this.fx.LesFeux[3 - offset].Detecteur) {
                if (
                    (this.fx.LesFeux[0 + offset].Detecteur || this.fx.LesFeux[1 + offset].Detecteur)
                    && !(this.fx.LesFeux[0 + offset].BP || this.fx.LesFeux[1 + offset].BP)) {
                    this.tMax = this.times[1 + offset];
                } else {
                    this.tMax = this.times[0 + offset];
                }

                /* Il y a eu un �v�nement sur le carrefour.
                 */
                this.memEventFlag = true;
                this.WriteHistory(this.GetWayEvents(this.curWay), "");
            }
        }
    }

    /* R�cup�re, sous forme de string pr�te � �tre utilis�e par WriteHistory()
     * les �v�nements de la voie way.
     *
     * bool  way             : la voie dont on veut conna�tre les �v�nements,
     *
     * string  GetWayEvents  : contient le num�ro du feu et l'�v�nement
     *                         s�par�s par this.sepChar. C'est utilisable
     *                         par WriteHistory.
     */
    private string GetWayEvents(bool way)
    {
        short i;
        short offset;
        short opp;

        if (this.IsWay1(way)) {
            offset = 0;
            opp = 2;
        } else {
            offset = 2;
            opp = -2;
        }

        /* Un gentillet petit "calcul" � faire selon si on est sur way1
         * ou way2.
         *
         * � savoir: ce qui nous int�resse quand une voie est au vert, c'est
         * de savoir si un pi�ton a appuy� sur le BP d'un des deux feux au vert,
         * imagions le 1 ou le 2, ou si un v�hicule attend que sa voie passe
         * au vert, donc les feux 3 et 4.
         */
        for (i = offset; i < 4 - opp - offset; ++i) {
            if (this.fx.LesFeux[i].BP) {
                return (1 + i).ToString() + this.sepChar + this.pbText;
            }

            if (this.fx.LesFeux[i + opp].Detecteur) {
                return (1 + i + opp).ToString() + this.sepChar + this.groundText;
            }
        }

        /* Si on arrive ici c'est qu'on ne devait pas
         * appeler la fonction. Au passage �a enl�ve un
         * warning de compilation.
         */
        return this.errorText + this.sepChar + this.errorText;
    }

    /* Ecriture de l'historique
     * L'�criture de la 1� colonne est syst�matique : la date.
     *
     * string  col2  : cha�ne � �crire dans la 2� colonne du fichier historique,
     * string  col3  : m�me chose que pour col2, mais sur la 3� colonne,
     */
    private void WriteHistory(string col2, string col3)
    {
        this.fHistoW.Write(DateTime.Now.ToString());

        if (col2 != "") {
            this.fHistoW.Write(this.sepChar + col2);
        }

        if (col3 != "") {
            this.fHistoW.Write(this.sepChar + col3);
        }

        this.fHistoW.WriteLine("");
    }

    /* Lecture du fichier de configuration.
     */
    private void ReadConf()
    {
        /* this.times[0] == Temps MINI way1;
         * this.times[1] == Temps MAXI way1;
         *
         * this.times[2] == Temps MINI way2;
         * this.times[3] == Temps MAXI way2;
         */
        string[] line;
        this.fConfR.ReadLine();
        /* Lecture d'une ligne � pour rien � car
         * il ne faut pas r�cup�rer les infos inutiles
         */
        line = this.fConfR.ReadLine().Split(' ');
        this.times[0] = Convert.ToInt32(line[0]) * 1000;
        this.times[1] = Convert.ToInt32(line[1]) * 1000;
        line = this.fConfR.ReadLine().Split(' ');
        this.times[2] = Convert.ToInt32(line[0]) * 1000;
        this.times[3] = Convert.ToInt32(line[1]) * 1000;

        /* Charger les bons temps si on demande
         * de relire la configuration
         */
        if (this.curWay) {
            this.tMax = this.times[3];
        } else {
            this.tMax = this.times[1];
        }

        this.fConfR.BaseStream.Seek(0, SeekOrigin.Begin);
    }

    /* Lit ou Lit et Ecrit les donn�es du carrefour.
     * En cas d'impossibilit� de communiquer avec
     * le r�seau (maquette ou simulateur), on arr�te tout.
     *
     * bool  write  : �critue des donn�es sur le r�seau,
     */
    private void RWNetwork(bool write)
    {
        bool internalRun = true;

        if (write && !this.fx.LectureEcritureReseau()) {
            internalRun = false;
        } else if (!this.fx.LectureReseau()) {
            internalRun = false;
        }

        if (!internalRun) {
            this.WriteHistory(this.errorText, this.conText);
            Environment.Exit(0);
        }
    }

    /* Le destructeur pour fermer les fichiers ouverts. */
    ~Crossroads()
    {
        this.fConfR.Close();

        if (!this.fHistoW.AutoFlush) {
            this.fHistoW.Close();
        }
    }
}