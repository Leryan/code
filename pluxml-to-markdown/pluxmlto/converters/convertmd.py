# -*- coding: utf-8 -*-
# vim: expandtab shiftwidth=4 tabstop=4

from io import StringIO

from pluxmlto.contrib import html2text

class ConvertMD:
    def __init__(self):
        self.header = {'_top': '', '_bottom': ''}
        self.fileext = '.markdown'
        self.filename_pattern = '{}'

    def convert(self):
        raise NotImplementedError("Should have implemented this")

    def convert_to_md(self, text):
        strio = StringIO()
        html2text.html2text_file(text, strio.write)
        strio.seek(0)
        return strio.read()

    def build_header(self, item, infos):
        head = self.header['_top']
        for k, v in self.header[item].items():
            try:
                head += v.format(infos[k]) + '\n'
            except KeyError:
                head += v.format('') + '\n'
        head += self.header['_bottom']
        return head

