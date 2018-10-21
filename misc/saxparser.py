#!/usr/bin/env python

import resource
from xml import sax


class Handler(sax.handler.ContentHandler):

    def __init__(self, result_store, *args, **kwargs):
        """
        :param ResultStore result_store:
        """
        #super(Handler, self).__init__(*args, **kwargs)
        self._location = ''
        self._rs = result_store
        self._loc = False
        self._append = 0

    def startElement(self, name, attrs):
        """
        :param str name:
        :param sax.xmlreader.AttributesImpl attrs:
        """
        self._location += '/' + name
        if self._location == '/urlset/url/loc':
            self._loc = True

    def characters(self, content):
        if self._loc:
            u = content.strip()
            if u and self._append:
                self._rs[-1] = self._rs[-1] + u
            elif u:
                self._rs.append(u)
                self._append = 1

    def endElement(self, name):
        if self._location == '/urlset/url/loc':
            self._loc = False
            self._append = 0

        s = '/' + name
        if self._location.endswith(s):
            self._location = ''.join(self._location[:-len(s)])

if __name__ == '__main__':
    print('pure python SAX parsing')

    res = list()
    handler = Handler(res)
    sax.parse("sitemap.xml", handler)

    print('{} MiB, {} results'.format(int(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss/1024), len(res)))
