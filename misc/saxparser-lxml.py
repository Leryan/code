#!/usr/bin/env python

import io
import resource

from lxml import etree

if __name__ == '__main__':
    res = {}

    print('LXML SAX parsing')

    with open('sitemap.xml', 'rb') as fh:
        fh.seek(0)
        ctx = etree.iterparse(fh, tag=['{http://www.sitemaps.org/schemas/sitemap/0.9}loc', '{http://www.google.com/schemas/sitemap-image/1.1}loc'])

        lastp = None
        for event, elem in ctx:
            if elem.tag.endswith('0.9}loc'):
                t = elem.text.strip()
                if t:
                    res[t] = {}
                    lastp = t
            else:
                t = elem.text.strip()
                res[lastp]['image_url'] = t
            elem.clear()

    print(f'{int(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss/1024)} MiB, {len(res)} results')
