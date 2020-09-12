__all__ = ['nagios', 'json']

from check_delivery.timer import Timer


class Output(object):

    def __init__(self, *args, **kwargs):
        super(Output, self).__init__(*args, **kwargs)

        self._status = None
        self._message = None
        self._details = None
        self._step = None
        self._expect_res = None
        self._timers = Timer()

    def __str__(self):
        raise NotImplementedError()

    @property
    def status(self):
        """
        An integer, minimum 0.
        """
        return self._status

    @status.setter
    def status(self, value):
        self._status = value

    @property
    def message(self):
        """
        A short message explaining the status.
        """
        return self._message

    @message.setter
    def message(self, value):
        self._message = value

    @property
    def details(self):
        """
        More details explaining the status. Optional, None by default.
        """
        return self._details

    @details.setter
    def details(self, value):
        self._details = value

    @property
    def timers(self):
        return self._timers

    @timers.setter
    def timers(self, value):
        self._timers = value

    @property
    def step(self):
        return self._step

    @step.setter
    def step(self, value):
        self._step = value

    @property
    def expect_res(self):
        return self._expect_res

    @expect_res.setter
    def expect_res(self, value):
        self._expect_res = value