#!/usr/bin/env python

import argparse
import os
from urllib.parse import urlparse

import parsel
import requests


def p_fancy(html):
    return """
<!DOCTYPE html><html><body>
<head>
    <style>
html {
    background-color: rgb(250, 250, 250);
    background-color: #FFFFF0;
    max-width: 40em;
    margin: auto;
}
body {
    font-family: sans-serif;
    font-size: 20px;
    color: rgb(51, 51, 51);
}
a {
    color: rgb(0, 150, 150);
    text-decoration: none;
}
a:hover {
    text-decoration: underline;
}
    </style>
    <meta charset="utf-8">
</head>
<body>""" + html + '</body></html>'

def p_forbes(url):
    return parsel.Selector(
        text=requests.get(url).text
    ).xpath(
        '//*[@id="article-container-0"]/div/div[2]/div[1]/article-body-container/div/div'
    ).extract()[0]

def p_eurogamer(url):
    return parsel.Selector(
        text=requests.get(url).text
    ).xpath(
        '//*[@id="page-wrapper"]/div[2]/div[1]/div[1]/article'
    ).extract()[0]

def p_generic(url):
    raise NotImplementedError()

def p_parse(url):
    host = urlparse(url).hostname
    p = p_generic
    if host.endswith('forbes.com'):
        p = p_forbes
    elif host.endswith('eurogamer.net'):
        p = p_eurogamer

    return p(url)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('url')
    parser.add_argument('-p', '--parser', default='generic')

    args = parser.parse_args()

    html = p_fancy(p_parse(args.url))
    with open('article.html', 'w') as fh:
        fh.write(html)

    os.system('chromium article.html')

if __name__ == '__main__':
    main()
