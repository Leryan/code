#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim: expandtab shiftwidth=4 tabstop=4

import os

from io import StringIO

from pluxmlto.converters.simplemd import SimpleMD
from pluxmlto.conf import *
from pluxmlto.article import Article
from pluxmlto.page import Page

class PluXml:
    def __init__(self, pdatas='.', mdatas='.', converter=SimpleMD):
        self.pdatas = pdatas
        self.mdatas = mdatas
        self.converter = converter
        self.inst_converter = self.converter()
        self.conf = Conf(self.pdatas)

    def rstrip_text(self, text):
        old_s = StringIO(text)
        new_s = ''
        for line in old_s.readlines():
            new_s += line.rstrip() + '\n'
        return new_s

    def write_file(self, infos):
        text = self.rstrip_text(self.inst_converter.convert(infos))
        fileout = self.mdatas + '/' + self.inst_converter.filename
        if not os.path.exists(os.path.dirname(fileout)):
            os.makedirs(os.path.dirname(fileout))
        self.ofile = open(fileout, 'w')
        self.ofile.write(text)

    def dothejob(self, path, objclass):
        objs = os.listdir(self.pdatas + path)
        for obj in objs:
            filein = self.pdatas + path + obj
            obj = objclass(filein, self.conf)
            infos = obj.parse()
            if infos:
                self.write_file(infos)

    def fire(self):
        self.dothejob('/articles/', Article)
        self.dothejob('/statiques/', Page)
