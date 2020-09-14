#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse

try:
    import urllib.parse as urlparse
    from urllib.parse import urlencode
except ImportError:
    import urlparse
    from urllib import urlencode

from os.path import join as pathjoin
from os.path import dirname, isdir, isfile
from os import makedirs

import requests


class Cacoo(object):

    """
    https://developer.nulab-inc.com/docs/cacoo/api/1
    """

    CACOO = 'https://cacoo.com/api/v1'

    def __init__(self, apikey):
        """
        :param apikey: string, cacoo API Key
        """
        self.apikey = apikey
        self._s = requests.Session()

    def get_raw(self, urlpath, urlparams={}):
        """
        :param urlpath: string, example: https://cacoo.com/path/
        :param urlparams: dict, example: {'search': 'title'}
        """
        url_parts = list(urlparse.urlparse(urlpath))
        query = dict(urlparse.parse_qsl(url_parts[4]))
        query.update(urlparams)
        query['apiKey'] = self.apikey
        url_parts[4] = urlencode(query)

        r = self._s.get(urlparse.urlunparse(url_parts))
        return r

    def get(self, *args, **kwargs):
        """
        Returns content as JSON. No check made.
        """
        return self.get_raw(*args, **kwargs).json()


class CacooBase(object):

    def __init__(self, cacooinst):
        """
        :param cacooinst: Cacoo instance.
        """
        self._cacooinst = cacooinst

    def get(self):
        raise NotImplementedError()


class CacooDiagrams(CacooBase):

    API_URL = '{}/diagrams.json'.format(Cacoo.CACOO)

    def get(self, search=None):
        """
        Get all diagrams.
        :param search: string, keyword(s): keyword1_keyword2
        """
        params = {}
        if search is not None:
            params['keyword'] = search
        return self._cacooinst.get(self.API_URL, params)


class CacooDiagram(CacooBase):

    API_URL = '{}/diagrams/'.format(Cacoo.CACOO)

    def get(self, diagramId):
        """
        Get informations about a diagram.
        """
        return self._cacooinst.get(self.API_URL + diagramId + '.json')


class CacooSheets(CacooBase):

    def get(self, diagramId):
        """
        Get the list of sheets from a given diagram.
        """
        cd = CacooDiagram(self._cacooinst).get(diagramId)
        return cd['sheets']


class CacooImage(CacooBase):

    API_URL = '{}/diagrams'.format(Cacoo.CACOO)

    def get(self, diagramId, sheetId, exformat):
        """
        Get image content.
        """
        return self._cacooinst.get_raw('{}/{}-{}.{}'.format(
            self.API_URL, diagramId, sheetId, exformat)).content

    def store(self, fpath, content):
        """
        Store image locally.
        """
        with open(fpath, 'wb') as a:
            a.write(content)

from threading import Thread

def chunk(l, n):
    """Yield successive n-sized chunks from l."""
    n = int(n)
    for i in range(0, len(l), n):
        yield l[i:i + n]

class CacooThread(Thread):
    def __init__(self, sheets, diagramId, diagram, myargs, cacoo):
        super(CacooThread, self).__init__()
        self._sheets = sheets
        self._c = cacoo
        self._di = diagramId
        self._d = diagram
        self._a = myargs

    def run(self):
        for sheet in self._sheets:
            ci = CacooImage(self._c)

            img = ci.get(self._di, sheet['uid'], self._a.format)
            img_path = pathjoin(
                self._a.store_to,
                self._d['title'],
                '{}.{}'.format(sheet['name'], self._a.format))

            img_storedir = dirname(img_path)

            if not isdir(img_storedir) and not isfile(img_storedir):
                makedirs(img_storedir)
            elif isfile(img_storedir):
                raise OSError(
                    'Cannot ensure directory {}'.format(img_storedir))

            ci.store(img_path, img)

            print('stored: {}'.format(img_path))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-k', '--apikey', type=str,
                        required=True,
                        help='go to https://cacoo.com/profile/api')
    parser.add_argument('-d', '--diagram-keyword', type=str, default=None)
    parser.add_argument(
        '-D', '--diagrams', action='store_true', help='get all diagrams')
    parser.add_argument(
        '-s', '--store-to', type=str,
        default='diagrams', help='storage directory')
    parser.add_argument(
        '-f', '--format', type=str, default='png', help='sheet export format')
    parser.add_argument(
        '-T', '--threads', type=int, default=2, help='launch N threads')

    args = parser.parse_args()

    c = Cacoo(args.apikey)

    if args.diagram_keyword or args.diagrams:
        search_diagram = args.diagram_keyword
        res_diagrams = CacooDiagrams(c).get(search=args.diagram_keyword)

        print('result: {} diagram(s) found.'.format(res_diagrams['count']))

        for res_diagram in res_diagrams['result']:
            diagramId = res_diagram['diagramId']
            diagram = CacooDiagram(c).get(diagramId)

            print('diagram: {}'.format(diagram['title']))
            sheets = CacooSheets(c).get(diagramId)

            sheet_threads = []
            for sheet_pool in chunk(sheets, len(sheets) / args.threads):
                ct = CacooThread(sheet_pool, diagramId, diagram, args, c)
                sheet_threads.append(ct)

            for ct in sheet_threads:
                ct.start()

            for ct in sheet_threads:
                ct.join()

if __name__ == '__main__':
    main()
