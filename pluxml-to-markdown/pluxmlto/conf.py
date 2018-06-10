#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim: expandtab shiftwidth=4 tabstop=4

import xml.etree.ElementTree as ET

class Conf:
    def __init__(self, pdatas):
        self.pdatas = pdatas
        self.conf = {}
        self.conf['categories'] = self.cache_xml(
                'categories',
                'categorie',
                'number',
                'name')
        self.conf['authors'] = self.cache_xml(
                'users',
                'user',
                'number',
                'name')
        self.conf['static'] = self.cache_xml(
                'statiques',
                'statique',
                'number',
                'name')

    def cache_xml(self, filename, findall, match_attrib, get_field):
        final = {}
        catsxml = ET.parse(self.pdatas + '/configuration/' + filename +'.xml')
        cats = catsxml.findall(findall)
        for cat in cats:
            if cat.attrib[match_attrib] not in final:
                final[cat.attrib[match_attrib]] = cat.find(get_field).text
        return final
