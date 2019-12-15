#!/usr/bin/env python
# -*- coding: utf-8 -*-
# vim: expandtab shiftwidth=4 tabstop=4

from flask import Flask
from werkzeug.contrib.fixers import ProxyFix

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello World!"

app.wsgi_app = ProxyFix(app.wsgi_app)

if __name__ == '__main__':
    app.run()
