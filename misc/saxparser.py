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
        self._rs.job(self._location, content)

    def endElement(self, name):
        s = '/' + name
        if self._location.endswith(s):
            self._location = ''.join(self._location[:-len(s)])

class ResultStore:

    def __init__(self):
        self.rules = {}
        self.products = {}
        self._last_product = None

    def add_rule(self, matches, func):
        self.rules[matches] = func

    def job(self, location, content):
        f = self.rules.get(location)
        if f:
            f(self, content)

    def store_url(self, content):
        self.products[content] = {}
        self._last_product = content

    def store_image_url(self, content):
        c = content.strip()
        if c:
            self.products[self._last_product]['image_url'] = c

if __name__ == '__main__':
    print('pure python SAX parsing')

    result_store = ResultStore()
    result_store.add_rule('/urlset/url/loc', ResultStore.store_url)
    result_store.add_rule('/urlset/url/image:image/image:loc', ResultStore.store_image_url)

    handler = Handler(result_store)
    sax.parse("sitemap.xml", handler)

    print(f'{int(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss/1024)} MiB, {len(result_store.products)} results')
