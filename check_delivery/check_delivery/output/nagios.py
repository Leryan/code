from check_delivery.output import Output


class Nagios(Output):

    STATUS_TEXT = {
        0: 'OK',
        1: 'WARNING',
        2: 'CRITICAL',
        3: 'UNKNOWN'
    }

    def _timers_to_perfdata(self):
        perfdata = []

        for timer in self.timers.checkpoints:
            perfdata.append('{0}={1:.2f}s'.format(timer[0], timer[1]))

        return '; '.join(perfdata)

    def __str__(self):
        perfdata = self._timers_to_perfdata()

        status = self.STATUS_TEXT.get(self.status, 'UNKNOWN')

        if self.status != 0:
            status = '{} - {}'.format(status, self.step)

        fline = '{} - {} | {}'.format(status, self.message, perfdata)

        if self.details is not None:
            olines = '{}'.format(self.details)
            return "\n".join([fline, olines])

        return fline
