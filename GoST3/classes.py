import re
import json
import os
import subprocess

from .utils import Utils

class GoST3Complete:

    @staticmethod
    def fmt_raw(candidates):
        fmt = []
        for c in candidates:
            #display = '{}\t{}'.format(c['name'], c['type'])
            display = c['name']
            edit = c['name']
            cr = [display, edit]
            fmt.append(cr)

        return fmt

    @staticmethod
    def fmt_html(candidates):
        html = '<html><body id="gost3"><style>'
        html += 'span.func { color: pink; }'
        html += 'span.type { color: blue; }'
        html += 'span.interface { color: green; }'
        html += 'span.builtin { color: red; }'
        html += 'span.none { color: white; }'
        html += '</style>'
        for c in candidates:
            html += '<div><span class="{}">{}</span>: {}</div>'.format(
                c['class'], c['name'], c['type'].replace('-', '')
            )

        return html + '</body></html>'

    @staticmethod
    def get_completion_results(gocode_json):
        results = json.loads(gocode_json)
        candidates = []

        if not results:
            return candidates

        candidates = results[1]

        if not len(candidates):
            return candidates

        return candidates


class GoCode(object):

    def complete(self, text, filepath, offset):
        """
        :param str text: full file text
        :param str filepath: absolute path to file
        :param int offset: where to begin completion, starting to 1
        """
        cmd = subprocess.Popen(
            [
                "gocode",
                "-f=json",
                "autocomplete",
                filepath,
                str(offset)
            ],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT
        )

        output = cmd.communicate(text.encode('utf-8'))[0].decode()

        return GoST3Complete.get_completion_results(output)


class GoTest(object):

    RE_TEST_FUNC = re.compile(
        '^func (Test|Benchmark)([^ ]+)[\s]?\(.*testing\.[TB].*'
    )

    def test(self, name, filepath):
        cwd = os.path.dirname(filepath)

        args = [
            "go",
            "test",
            "-v",
            "-test.run",
            "^{}$".format(name)
        ]

        cmd = subprocess.Popen(
            args,
            cwd=cwd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT
        )

        return 'running test: {}\n{}'.format(
            name,
            cmd.communicate()[0].decode()
        ), cmd.returncode

    def test_package(self, filepath):
        cwd = os.path.dirname(filepath)
        args = [
            "go",
            "test",
            "."
        ]

        cmd = subprocess.Popen(
            args,
            cwd=cwd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT
        )

        return 'running tests:\n{}'.format(
            cmd.communicate()[0].decode()
        ), cmd.returncode


class GoBuild(object):

    def build(self, filepath):
        cwd = os.path.dirname(filepath)
        cmd = subprocess.Popen(
            [
                "go",
                "build",
                "-o",
                "/dev/null",
                "-v",
                "."
            ],
            cwd=cwd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT
        )

        result = cmd.communicate()
        output = result[0].decode()

        return output, cmd.returncode
