#!/usr/bin/env python

from setuptools import setup, find_packages

from check_delivery import __version__ as cd_version
from check_delivery import __location__ as cd_location

setup(
    name='check_delivery',
    version=cd_version,
    description='Check your delivery system.',
    url=cd_location,
    author='Florent Peterschmitt',
    author_email='florent@peterschmitt.fr',
    license='MIT',
    classifiers=[
        'Programming Language :: Python :: 3'
    ],
    keywords=['delivery', 'check'],
    packages=['check_delivery'],
    entry_points={
        'console_scripts':[
            'check_delivery=check_delivery:check_delivery'
        ]
    },
    install_requires = [],
    extras_require = {
        'irc': ['irc']
    }
)
