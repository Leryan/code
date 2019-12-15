#!/usr/bin/env python

if __name__ == '__main__':
    with open('sitemap.xml', 'w') as fh:
        fh.write('<?xml version="1.0" encoding="UTF-8"?>')
        fh.write('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"')
        fh.write('        xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">')

        for i in range(0, 1200000):
            fh.write("""
<url>
    <loc>


    https://localhost/a-somewhat-long-url-because-i-wanna-long-things-blablaunietnaruiste ruasite nrsaitu enrstaiu nerstauinerst uarinset u{0}

    </loc>
    <lastmod>2018-10-21</lastmod>
    <changefreq>daily</changefreq>
    <priority>0.5</priority>
    <image:image>
        <image:loc>

https://localhost/medias/BLABLABLABLLTNATENRSUTIENRSTUINERSTUINRESTUNRISTENRUSITE{0}.jpg
        </image:loc>
        <image:title>BLNASIRTENRUSTIENRSTUINRESTUIE{0}</image:title>
    </image:image>
</url>""".format(i))

        fh.write('</urlset>')
