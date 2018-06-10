#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim: expandtab shiftwidth=4 tabstop=4

import re
import os

import xml.etree.ElementTree as ET

from pluxmlto.item import Item

class Article(Item):
    item = __name__.lower()
    def __init__(self, filename, pconf):
        self.pconf = pconf
        self.filename = filename

    def parse(self):
        """
        Does not support multiple category articles.
        
        Will retreive infos as dict:
            * num: article numbre
            * date
            * category
            * author
            * name: taken from file name
            * slug: custom url
            * summary: provided by meta_description
            * title
            * content: chapo + content
            * published: boolean
        """
        re_nums = re.compile(r'^[_]?([0-9\.]+)\.(.*)\.xml$')
        fname = os.path.basename(self.filename)
        m = re_nums.match(fname)

        if not m:
            return None

        datas = m.group(1).split('.')
        rinfos = {}
        rinfos['num'] = datas[0]
        rinfos['category'] = datas[1]
        rinfos['author'] = datas[2]
        rinfos['date'] = datas[3]
        rinfos['name'] = m.group(2)
        self.ifile = open(self.filename, 'r')
        root = ET.fromstring(self.ifile.read())

        # Get infos from pluxml and sanitize them.
        infos = {'item' : self.item}
        d = rinfos['date']
        # Ugly.
        infos['date'] = d[:4] + '-' + d[4:6] + '-' + d[6:8] + ' ' + d[8:10] + ':' + d[10:]
        infos['author'] = self.pconf.conf['authors'][rinfos['author']]
        infos['category'] = self.pconf.conf['categories'][rinfos['category']]
        infos['tags'] = root.find('tags').text
        infos['slug'] = rinfos['name']
        infos['name'] = rinfos['name']
        infos['published'] = True
        if fname[0] == '_':
            infos['published'] = False
        infos['num'] = rinfos['num']
        summary = root.find('meta_description').text
        if summary:
            infos['summary'] = root.find('meta_description').text

        infos['title'] = root.find('title').text
        chapo = root.find('chapo').text
        if not chapo:
            chapo = ''
        else:
            chapo += '\n\n'
        content = root.find('content').text
        infos['content'] = chapo + content

        return infos
