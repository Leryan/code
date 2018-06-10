import sublime
import sublime_plugin

from .utils import Utils

from .classes import *


class GoST3ViewEventListener(sublime_plugin.ViewEventListener):

    def __init__(self, *args, **kwargs):
        super(GoST3ViewEventListener, self).__init__(*args, **kwargs)

        self._gocode = GoCode()
        self._gotest = GoTest()
        self._gobuild = GoBuild()

    def _build(self):
        if not Utils.check_file_type(self.view):
            return

        fpath = self.view.file_name()

        if Utils.check_file_type_test(self.view):
            output, rc = self._gotest.test_package(fpath)
            if rc == 0:
                print('tests ok')
            else:
                print('tests failure:')
                print(output)
        else:
            output, rc = self._gobuild.build(fpath)
            if rc == 0:
                print('build ok')
            else:
                print('build failure:')
                print(output)

    def on_load_async(self):
        self._build()

    def on_post_save_async(self):
        self._build()

    def _hover_type(self, view, point):
        line = Utils.get_line_at_point(self.view, point)
        match = self._gotest.RE_TEST_FUNC.match(line)
        if match is not None:
            return 'test', '{}{}'.format(match.group(1), match.group(2))

        return None, None

    def on_hover(self, point, hover_zone):
        if hover_zone != sublime.HOVER_TEXT:
            return

        if not Utils.check_file_type_test(self.view):
            return None

        hover_type, result = self._hover_type(self.view, point)

        if hover_type == 'test':
            output, rc = self._gotest.test(result, self.view.file_name())
            if rc == 0:
                print('tests ok:')
            else:
                print('tests failure:')

            print(output)

    def on_done(self):
        pass

    def on_navigate(self, content):
        pass

    def on_text_command(self, cmd, args):
        if cmd == 'commit_completion':
            self.view.hide_popup()

    def on_query_completions(self, prefix, locations):
        """
        :rtype list[list[str, str]]
        """

        if not Utils.check_file_type(self.view):
            return None

        result = self._gocode.complete(
            Utils.get_view_text(self.view),
            self.view.file_name(),
            locations[0]
        )

        self.view.show_popup(
            GoST3Complete.fmt_html(result),
            sublime.COOPERATE_WITH_AUTO_COMPLETE,
            -1,
            1024, 300,
            self.on_navigate,
            self.on_done
        )

        return GoST3Complete.fmt_raw(result)


class InsertCompletion(sublime_plugin.TextCommand):

    def run(self, edit, args):
        self.view.insert(edit, self.view.sel()[0].begin(), args['text'])
