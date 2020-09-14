class CheckDeliveryException(Exception):
    pass

class BadConfigurationException(CheckDeliveryException):
    pass

class BadMethodException(CheckDeliveryException):
    pass

class StatusException(CheckDeliveryException):

    """
    The delivery state exception. Even if your state is OK, you must raise an exception.

    You have the ability to pass the original exception, if any,
    so custom applications can still know what really happended.

    self.rcode: this is only useful for Nagios-like softwares.
    self.source_exception: None by default, contains an exception if the Method has set one.
    """

    rcode = 4
    source_exception = None

    def __init__(self, *args, rcode=None, source_exception=None, **kwargs):
        super(StatusException, self).__init__(*args, **kwargs)

        if rcode != None:
            self.rcode = rcode

        self.source_exception = source_exception

class CriticalException(StatusException):

    def __init__(self, *args, **kwargs):
        super(CriticalException, self).__init__(*args, rcode=2, **kwargs)


class WarningException(StatusException):

    def __init__(self, *args, **kwargs):
        super(WarningException, self).__init__(*args, rcode=1, **kwargs)


class UnknownException(StatusException):

    def __init__(self, *args, **kwargs):
        super(UnknownException, self).__init__(*args, rcode=3, **kwargs)


class OkException(StatusException):

    def __init__(self, *args, **kwargs):
        super(OkException, self).__init__(*args, rcode=0, **kwargs)
