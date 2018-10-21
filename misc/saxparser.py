#!/usr/bin/env python

import resource
from xml import sax


class Handler(sax.handler.ContentHandler):

    def __init__(self, result_store, *args, **kwargs):
        """
        :param ResultStore result_store:
        """
        super().__init__(*args, **kwargs)
        self._location = ''
        self._rs = result_store

    def startElement(self, name, attrs):
        """
        :param str name:
        :param sax.xmlreader.AttributesImpl attrs:
        """
        self._location += '/' + name

    def characters(self, content):
        if self._location == '/urlset/url/loc':
            u = content.strip()
            if u:
                self._rs.append(u)

    def endElement(self, name):
        s = '/' + name
        if self._location.endswith(s):
            self._location = ''.join(self._location[:-len(s)])

if __name__ == '__main__':
    print('pure python SAX parsing')

    res = list()
    handler = Handler(res)
    sax.parse("sitemap.xml", handler)

    print(f'{int(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss/1024)} MiB, {len(res)} results')
