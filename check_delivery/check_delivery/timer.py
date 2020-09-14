from time import time


class Timer(object):

    def __init__(self, *args, **kwargs):
        super(Timer, self).__init__(*args, **kwargs)

        self._timers = {'checkpoints': []}
        self._sleep_time = 0
        self._last_checkpoint = 0

    def start(self):

        self._timers['start'] = time()
        self._last_checkpoint = self._timers['start']

    def checkpoint(self, name, active=True):

        old_checkpoint = self._last_checkpoint

        self._last_checkpoint = time()

        elapsed_time = self._last_checkpoint - old_checkpoint

        self._timers['checkpoints'].append([name, elapsed_time])

        if active == False:
            self._sleep_time += elapsed_time

    def add(self, name, value):
        self._timers['checkpoints'].append([name, value])

    @property
    def sleep_time(self):
        return self._sleep_time

    @property
    def checkpoints(self):
        return self._timers['checkpoints']

    def duration(self, active_only=False):
        if active_only == False:
            return self._timers['duration']

        return self._timers['duration'] - self.sleep_time

    def end(self):

        self._timers['end'] = time()

        self._timers['duration'] = self._timers['end'] - self._timers['start']
