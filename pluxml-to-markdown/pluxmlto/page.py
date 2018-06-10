# -*- coding: utf-8 -*-
# vim: expandtab shiftwidth=4 tabstop=4

import re
import os

import xml.etree.ElementTree as ET

from pluxmlto.item import Item

class Page(Item):
    item = __name__.lower()
    def __init__(self, filename, pconf):
        self.pconf = pconf
        self.filename = filename

    def parse(self):
        """
        Will retreive infos as dict:
            * num: page number
            * name: taken from file name
            * title
            * content
            * published: boolean
        """
        re_nums = re.compile(r'^[_]?([0-9]+)\.(.*)\.php$')
        fname = os.path.basename(self.filename)
        m = re_nums.match(fname)

        if not m:
            return None

        f = open(self.filename, 'r')
        infos = {'item' : self.item}
        infos['num'] = m.group(1)
        infos['name'] = m.group(2)
        infos['title'] = self.pconf.conf['static'][infos['num']]
        infos['content'] = f.read()
        infos['published'] = True
        if fname[0] == '_':
            infos['published'] = False

        return infos
