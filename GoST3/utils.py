import sublime


class Utils:

    @staticmethod
    def get_line_at_point(view, point):
        """
        :rtype str:
        """
        region = view.full_line(point)
        return view.substr(region)

    @staticmethod
    def get_view_text(view):
        """
        :param View view:
        :rtype str:
        """
        return view.substr(sublime.Region(0, view.size()))

    @staticmethod
    def check_file_type(view):
        """
        :rtype bool: file is supported by plugin
        """
        return view.file_name().endswith('.go')

    @staticmethod
    def check_file_type_test(view):
        return view.file_name().endswith('_test.go')
