# -*- coding: utf-8 -*-
# vim: expandtab shiftwidth=4 tabstop=4

from pluxmlto.converters.convertmd import ConvertMD

class SimpleMD(ConvertMD):
    def convert(self, infos):
        name = infos['name']
        content = self.convert_to_md(infos['content'])
        self.filename = self.filename_pattern.format(name) + self.fileext
        return content
