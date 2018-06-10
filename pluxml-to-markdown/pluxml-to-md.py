#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim: expandtab shiftwidth=4 tabstop=4

import argparse
import importlib

from pluxmlto import pluxml
from pluxmlto import converters

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--pluxml-datas', dest='pdatas',
            help='pluxml raw datas directory',
            required=True)
    parser.add_argument('--md-datas', dest='mdatas',
            help='where you want new md files to go',
            required=True)
    parser.add_argument('--converter', dest='converter',
            help='choose the converter. SimpleMD or PelicanMD',
            default='SimpleMD')
    args = parser.parse_args()

    convmod = importlib.import_module('pluxmlto.converters.{}'.format(args.converter.lower()))
    converter = getattr(convmod, args.converter)
    p = pluxml.PluXml(args.pdatas, args.mdatas, converter)
    p.fire()

if __name__ == '__main__':
    main()
