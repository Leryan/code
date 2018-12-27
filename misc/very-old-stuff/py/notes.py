#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
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
*     * Neither the name of Florent PETERSCHMITT nor the
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
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
"""

import os

def ListeD(D, U, txt1, txt2):
    i = 0
    for u in U:
        print(txt1.format(u[2]))
        a = 0
        while True:
            string = raw_input(txt2.format(a + 1))
            if string:
                tmp = [i, u[0]]
                n = string.split(',')
                FormatChaine(n)
                tmp.extend(n)
                D.append(tmp)
                i += 1
                a += 1
            else:
                break;

def FormatChaine(lst):
    i = 0
    for x in lst:
        lst[i] = x.strip()
        i += 1

def CalculMoyE(E, N, iCoeff, iNote):
    """
    On passe un ensemble dont il faut calculer la moyenne -> E
    Dans lequel on a des notes ou moyennes d'un autre ensemble -> N

    iCoeff et iNote sont là pour dire où trouver les Notes et Coeff dans N
    """
    Me = []
    i = 0
    for e in E:
        a = 0.0
        b = 0.0
        for n in N:
            if n[1] == e[0]:
                a += (n[iNote] * n[iCoeff])
                b += (n[iCoeff])
        if b > 0.0:
            Me.append(a / b)
    for me in Me:
        E[i].append(me)
        i += 1

def LireNotes(nFile, D):
    for line in nFile:
        n = line[:-1].split('$')
        for d in D:
            if n[0] == d[0]:
                d[1].append(n[1:])

def ConvData(D):
    t0, t1, t2, t3 = [], [], [], []
    for x in D[0]:
        t0.append([int(x[0]), int(x[1]), x[2].strip()])
    for x in D[1]:
        t1.append([int(x[0]), int(x[1]), x[2].strip(), float(x[3])])
    for x in D[2]:
        t2.append([int(x[0]), int(x[1]), x[2].strip(), float(x[3])])
    for x in D[3]:
        t3.append([int(x[0]), int(x[1]), x[2].strip(), float(x[3]), float(x[4])])
    return [t0, t1, t2, t3]

def WriteFile(nFile, cID, D):
    for d in D:
        nFile.write(cID)
        for x in d:
            nFile.write('$' + str(x))
        nFile.write('\n')

def EcrireNotes(nFile, D):
    for d in D:
        WriteFile(nFile, d[0], d[1])

if __name__ == "__main__":
    D = []
    D = [[[0, 0, 'Année 2010-2011']], [], [], []] #A U E N
    if not os.path.isfile("notes.nts"):
        print("Création du fichier notes.nts")
        ListeD(D[1], D[0], "Dans l'année {} : ", "* Nom UE{}, Coeff : ")
        ListeD(D[2], D[1], "** Dans UE {} : ", "\tNom Enseignement {}, Coeff : ")
        ListeD(D[3], D[2], "*** Dans Enseignement {} : ","\tNom note {}, Coeff, Valeur : ")
        fnote = open("notes.nts", 'w')
        D = ConvData(D)
        EcrireNotes(fnote, [['A', D[0]], ['U', D[1]], ['E', D[2]], ['N', D[2]]])
        fnote.close()
    fnote = open("notes.nts", 'r')
    D = [[], [], [], []]
    LireNotes(fnote, [['A', D[0]], ['U', D[1]], ['E', D[2]], ['N', D[3]]])
    D = ConvData(D)
    """
    Le calcul des moyennes ne doit se faire qu'à la fin et après
    avoir écrit les données sur le fichier, sinon on récupère aussi
    les moyennes dedans.

    CalculMoyE(E, N, iCoeff, iNote)

    Liste des Années        :   [[iA, ix, Nom, ...MoyA...]]
    Liste des UE            :   [[iU, iA, Nom, Coeff, ...MoyUE...]]
    Liste des Enseignements :   [[iE, iU, Nom, Coeff, ...MoyE...]]
    Liste des Notes         :   [[iN, iE, Nom, Coeff, Valeur]]

    Structure du fichier de notes :
        U$iU$iA$Nom$Coeff
        E$iE$iU$Nom$Coeff
        N$iN$iE$Nom$Coeff$Valeur
    """
    CalculMoyE(D[2], D[3], 3, 4)
    CalculMoyE(D[1], D[2], 3, 4)
    CalculMoyE(D[0], D[1], 3, 4)
    print("************* Synthèse *************")
    for u in D[1]:
        print("Moyenne UE {} coeff {} : {}".format(u[2], u[3], u[4]))
        for e in D[2]:
            if e[1] == u[0]:
                print("\tMoyenne Enseignement {} coeff {} : {}".format(e[2], e[3], e[4]))
                for n in D[3]:
                    if n[1] == e[0]:
                        print("\t\t{} coeff {} :\t{}".format(n[2], n[3], n[4]))
    print("Moyenne à l'année {} : {}".format(D[0][0][2], D[0][0][3]))
