#!/usr/bin/env python3

from distutils.core import setup

setup(name='PluXmlTo',
      version='1.0',
      description='Convert your PluXml blog articles to a markdown format, simple or with headers for other blogs.',
      author='Florent Peterschmitt',
      author_email='florent@peterschmitt.fr',
      license='WTFPL',
      packages=['pluxmlto', 'pluxmlto.contrib', 'pluxmlto.converters'],
     )
