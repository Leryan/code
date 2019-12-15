#!/usr/bin/python
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

import sys

def change(digits, word, i):
    if word[-(1 + i)] == digits[-1]:
        word[-(1 + i)] = digits[0]
        i += 1
        if i != len(word):
            change(digits, word, i)
    else:
        word[-(1 + i)] = digits[digits.index(word[-(1 + i)]) + 1]

if __name__ == "__main__":
    digits = []
    word = []
    string = ""
    a = 1
    hit = 0

    chars = raw_input("Liste des caractères à tester : ")
    length = int(raw_input("Longueur du mot de passe : "))
    start = raw_input("Commencer par : ")

    word.extend(start)
    digits.extend(chars)
    word.extend(digits[0] * (length - len(start)))

    while hit < len(digits) ** length:
        string = ""
        for x in word:
            string += x
        print string

        if a == len(digits):
            a = 0
            change(digits, word, 0)
        else:
            word[-1] = digits[a]
        a += 1
        hit += 1
