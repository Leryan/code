from io import StringIO

from pprint import pprint

import feedparser

class Feed:

    urls = (
        'https://news.ycombinator.com/rss',
        'https://linuxfr.org/news.atom',
        'https://linuxfr.org/journaux.atom',
        'https://feeds.feedburner.com/Phoronix',
    )

    def __init__(self):
        self.out = StringIO()

    def header(self):
        self.out.write('<!DOCTYPE html>\n<html><head><meta charset="utf-8"></head><body>')

    def content(self):
        self.out.write('<ul>')
        for url in self.urls:
            feed = feedparser.parse(url)

            if 'bozo' in feed and feed['bozo'] != 0:
                pprint(feed)

            elif 'entries' in feed:
                for entry in feed['entries']:
                    self.out.write(
                        '<li>{}: <a target="_blank" href="{}">{}</a></li>'.format(
                            feed['feed']['title'], entry['link'], entry['title']
                        )
                    )
        self.out.write('</ul>')

    def footer(self):
        self.out.write('</body></html>')

    def write(self):
        with open('links.html', 'w') as fh:
            self.out.seek(0)
            fh.write(self.out.read())

    def run(self):
        self.header()
        self.content()
        self.footer()
        self.write()

Feed().run()
