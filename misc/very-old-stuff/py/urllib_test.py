#!/usr/bin/env python
# vim: expandtab
# -*- coding: utf-8 -*-

import urllib2
from HTMLParser import HTMLParser
from sys import stdout

class ParseTDir(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.__link = False

    def handle_starttag(self, tag, attrs):
        if tag.lower() == 'a':
            self.__link = True

    def handle_data(self, data):
        if self.__link:
            stdout.write("* " + data)

    def handle_endtag(self, tag):
        self.__link = False
        stdout.write("\n")
        stdout.flush()

auth_handl = urllib2.HTTPBasicAuthHandler()
auth_handl.add_password(realm='Restricted Area',
        uri='https://host/',
        user='global',
        passwd='pass')

opener = urllib2.build_opener(auth_handl)
urllib2.install_opener(opener)
res = urllib2.urlopen('https://url/').read()
parser = ParseTDir()
parser.feed(res.strip())
