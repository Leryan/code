#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse

from simplecacher.simplecacher import Proxy
from simplecacher.config import Config

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', '--config', type=str,
                        help='Configuration file (simplecacher.ini)', default='')
    args = parser.parse_args()

    Config(args.config)
    p = Proxy()
    p.run()
