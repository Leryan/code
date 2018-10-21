#!/usr/bin/env python

import io
import resource

from lxml import etree

if __name__ == '__main__':
    res = list()

    print('LXML SAX parsing')

    with open('sitemap.xml', 'rb') as fh:
        fh.seek(0)
        ctx = etree.iterparse(fh, tag='{http://www.sitemaps.org/schemas/sitemap/0.9}loc')

        lastp = None
        for event, elem in ctx:
            if elem.tag.endswith('0.9}loc'):
                t = elem.text.strip()
                if t:
                    res.append(t)
            elem.clear()

    print(f'{int(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss/1024)} MiB, {len(res)} results')
