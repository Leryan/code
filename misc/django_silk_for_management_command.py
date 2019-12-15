from io import StringIO

from django.core.handlers.wsgi import WSGIRequest
from django.http import HttpResponse
from silk.middleware import SilkyMiddleware
from silk.profiling.profiler import silk_profile


class silk_middleware:
    """
    Simple query collection:

    with silk_middleware(name='collect'):
        do_stuff()

    Query collection + profiler:

    with silk_middleware(name='collect + profile') as sm:
        with sm.profiler():
            do_stuff()

    Or even:

    with silk_middleware(name='collect + profile') as sm:
        with sm.profiler(name='prof1'):
            do_stuff_1()
        with sm.profiler(name='prof2'):
            do_stuff_2()
    """
    def __init__(self, name):
        """
        :param str name:
        """
        self._name = name
        self._sm = SilkyMiddleware(lambda _: HttpResponse(""))
        self._request = WSGIRequest(
            {
                'REQUEST_METHOD': 'NONE',
                'PATH_INFO': name,
                'wsgi.input': StringIO(),
            }
        )

    def start_analyze(self):
        self._sm.process_request(self._request)

    def profiler(self, name=None):
        name = name or self._name
        return silk_profile(name=name)

    def end_analyze(self):
        response = self._sm.get_response(self._request)
        self._sm.process_response(self._request, response)

    def __enter__(self):
        self.start_analyze()
        return self

    def __exit__(self, *args, **kwargs):
        self.end_analyze()
