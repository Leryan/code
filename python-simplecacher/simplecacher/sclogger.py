import logging

import simplecacher


class SCLogger(object):

    """
    Setup loggers for the application.
    """
    FORMAT_proxy = '%(levelname)-8s | %(asctime)-15s | Proxy: %(sourceip)s %(message)s'
    FORMAT_app = '%(levelname)-8s | %(asctime)-15s | App  : %(message)s'
    FORMAT_tls = '%(levelname)-8s | %(asctime)-15s | TLS  : %(message)s'
    FORMAT_cache = '%(levelname)-8s | %(asctime)-15s | Cache: %(message)s'
    FORMAT_http = '%(levelname)-8s | %(asctime)-15s | HTTP : %(message)s'

    LOGGERS = ['proxy', 'app', 'tls', 'cache', 'http']

    @classmethod
    def init_loggers(cls):
        """
        Explicitly call init_loggers before any use of them.
        """

        for logger in cls.LOGGERS:
            llogger = logging.getLogger(logger)
            lsh = logging.StreamHandler()
            lsh.setFormatter(
                logging.Formatter(getattr(cls, 'FORMAT_{0}'.format(logger))))
            llogger.addHandler(lsh)
            conf_loglevel = getattr(simplecacher.config.Config, logger).loglevel
            python_loglevel = getattr(logging, conf_loglevel.upper())
            llogger.setLevel(python_loglevel)
            setattr(cls, logger, llogger)
