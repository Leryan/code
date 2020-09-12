#!/usr/bin/env python
import webpandoc
import unittest
import requests
import json
import argparse
import base64
import time
import os

from multiprocessing import Process


class TestAPIDocToPandoc(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        args, parser = webpandoc.argparser()
        cls.p = Process(
            target=webpandoc.app.run, kwargs={'host': args.bind, 'port': args.port})
        cls.p.start()
        time.sleep(1)

    @classmethod
    def tearDownClass(cls):
        cls.p.terminate()

    def setUp(self):
        self.file_samples = [
            {
                'file': 'sample.md',
                        'format': 'markdown'
            },
            {
                'file': 'sample.html',
                        'format': 'html'
            },
        ]
        self.archive_samples = [
            {
                'file': 'sample_defidx.zip',
                'format': 'markdown',
                'idx': None
            },
            {
                'file': 'sample_idx.zip',
                'format': 'markdown',
                'idx': 'ArIdx.md'
            }
        ]
        self.s = requests.Session()
        args, parser = webpandoc.argparser()
        self.webpandoc_port = args.port

    def do_loop_sample_convert(self, format_to):
        for file_sample in self.file_samples:
            jr = self.do_test_convert(file_sample, format_to)
            self.assertEqual(jr['convert_status'], 1)

    def do_loop_archive_convert(self, format_to):
        for ar_sample in self.archive_samples:
            jr = self.do_test_archive(ar_sample, format_to)
            self.assertEqual(jr['convert_status'], 1)

    def do_request(self, files, payload):
        r = self.s.post(
                'http://localhost:{0}/api'.format(self.webpandoc_port),
                files=files,
                data=payload)
        return r.json()

    def do_test_archive(self, ar_sample, format_to):
        with open('samples/{0}'.format(ar_sample['file']), 'rb') as fa:
            files = {
                'sourceArchive': (ar_sample, fa),
            }

            payload = {
                'format_from': ar_sample['format'],
                'format_to': format_to
            }

            if ar_sample['idx'] != None:
                payload['archiveIndex'] = ar_sample['idx']

            return self.do_request(files, payload)

    def do_test_convert(self, file_sample, format_to):
        with open('samples/{0}'.format(file_sample['file']), 'rb') as fs:
            files = {
                'sourceFile': (file_sample, fs),
            }

            payload = {
                'format_from': file_sample['format'],
                'format_to': format_to
            }

            return self.do_request(files, payload)

    def test_0001_odt(self):
        self.do_loop_sample_convert('odt')

    def test_0002_html(self):
        self.do_loop_sample_convert('html')

    def test_0003_archive_defindex(self):
        self.do_loop_archive_convert('odt')


if __name__ == '__main__':
    unittest.main()
