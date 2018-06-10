# -*- coding: utf-8 -*-
# vim: expandtab shiftwidth=4 tabstop=4

from pluxmlto.converters.convertmd import ConvertMD
from pluxmlto.article import Article
from pluxmlto.page import Page

class OctopressMD(ConvertMD):
    def __init__(self):
        super().__init__()
        self.filename_pattern = '{0}-{1}'
        self.header['_top'] = '---\n'
        self.header['_bottom'] = '---\n'
        self.header[Article.item] = {'layout': 'layout: post',
                'title': 'title: "{}"',
                'date': 'date: {}',
                'comments': 'comments: true',
                'tags': 'categories: [{}]',
                'author': 'author: {}'}
        self.header[Page.item] = {'title': "{}"}

    def convert(self, infos):
        published = str(infos['published']).lower()
        item = infos['item']
        name = infos['name']
        self.header[item]['published'] = 'published: ' + published
        head = self.build_header(item, infos)
        content = self.convert_to_md(infos['content'])

        if item == Article.item:
            date = infos['date'][:10]
            self.filename = self.filename_pattern.format(date, name) + self.fileext
        elif item == Page.item:
            self.filename = 'pages/' + name + self.fileext

        return head + content
