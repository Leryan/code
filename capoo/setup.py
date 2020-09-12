#!/usr/bin/env python
# -*- coding: utf-8 -*-

from setuptools import setup, find_packages

setup(
        name='capoo',
        version='0.0.1',
        description='Export data from cacoo.',
        url='https://github.com/Leryan/capoo',
        author='Florent Peterschmitt',
        author_email='florent@peterschmitt.fr',
        license='MIT',
        classifiers=[
            'Programming Language :: Python :: 2.7',
            'Programming Language :: Python :: 3.6',
            ],
        keywords=['cacoo'],
        packages=['capoo'],
        install_requires=['requests'],
        entry_points={
            'console_scripts':[
                'capoo=capoo:main',
            ],
        },
)