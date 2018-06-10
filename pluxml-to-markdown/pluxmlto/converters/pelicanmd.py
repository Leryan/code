# -*- coding: utf-8 -*-
# vim: expandtab shiftwidth=4 tabstop=4

import re
import os

import xml.etree.ElementTree as ET

from pluxmlto.converters.convertmd import ConvertMD
from pluxmlto.page import Page
from pluxmlto.article import Article

class PelicanMD(ConvertMD):
    def __init__(self):
        super().__init__()
        self.header['_bottom'] = '\n'
        self.header[Article.item] = {'title': 'Title: {}',
                            'date': 'Date: {}',
                            'tags': 'Tags: {}',
                            'slug': 'Slug: {}',
                            'author': 'Author: {}',
                            'summary': 'Summary: {}'}
        self.header[Page.item] = {'title': 'Title: {}'}
        self.filename_pattern = '{0}/{1}-{2}'

    def convert(self, infos):
        item = infos['item']
        name = infos['name']
        if not infos['published']:
            self.header[item]['published'] = 'Status: hidden'
        head = self.build_header(item, infos)
        content = self.convert_to_md(infos['content'])

        if item == Article.item:
            category = infos['category']
            date = infos['date'][:10]
            self.filename = self.filename_pattern.format(category, date, name) + self.fileext
        elif item == Page.item:
            self.filename = 'pages/' + name + self.fileext

        return head + content
