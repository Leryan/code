# -*- coding: utf-8 -*-
# vim: expandtab shiftwidth=4 tabstop=4

import re
import os

import xml.etree.ElementTree as ET

from pluxmlto.page import Page
from pluxmlto.article import Article
from pluxmlto.converters.pelicanmd import PelicanMD

class PelicanncMD(PelicanMD):
    def __init__(self):
        super().__init__()
        self.header[Article.item]['category'] = 'Category: {}'
        self.filename_pattern = '{1}-{0}-{2}'
