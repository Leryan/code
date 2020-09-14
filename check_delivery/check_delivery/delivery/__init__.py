__all__ = ['file', 'ftp', 'imap', 'irc', 'smtp']

import ssl

from urllib.parse import urlparse
from urllib.parse import parse_qs as urlqueryparse
from urllib.parse import unquote as urldecode


class Method(object):

    """
    self.url: parsed url for this method
    selfremoteurl: parsed url for the other method
    self.path: url's decoded path
    self.query: url's query string
    self.query_params: url's query string, parsed
    self.connection: the connection as defined by the method
    self.host: url's host name
    self.port: url's port number
    self.user: url's decoded user name, if any, else None
    self.password: url's decoded password, if any, else None
    self.ssl_verify_mode: ssl.CERT_NONE|OPTIONAL|REQUIRED, from ssl_verify query parameter
    """

    def __init__(self, url, remoteurl, *args, **kwargs):
        super(Method, self).__init__(*args, **kwargs)
        self.url = urlparse(url)
        self.remoteurl = urlparse(remoteurl)
        self.path = self.url.path
        self.query = self.url.query
        self.query_params = urlqueryparse(self.query)
        self.connection = None

        self._split_host_port()
        self._split_user_password()
        self._ssl_verify()
        self._doc = None

    def _ssl_verify(self):
        ssl_verify_txt = self.query_params.get('ssl_verify', ['REQUIRED'])[0]
        self.ssl_verify_mode = getattr(
            ssl, 'CERT_{}'.format(ssl_verify_txt), ssl.CERT_REQUIRED)

    def _split_host_port(self):
        self.host = self.url.hostname
        self.port = self.url.port

    def _split_user_password(self):

        try:
            self.user = urldecode(self.url.username)
        except TypeError:
            self.user = None

        try:
            self.password = urldecode(self.url.password)
        except TypeError:
            self.password = None

    def get_ssl_context(self):
        """
        Get a new SSLContext based on the URL's ssl_verify parameter.

        Default context will check for a valid certificate (CERT_REQUIRED).
        """
        sslctx = ssl.create_default_context()

        if self.ssl_verify_mode == ssl.CERT_NONE:
            sslctx.check_hostname = False

        sslctx.verify_mode = self.ssl_verify_mode

        return sslctx

    def connect_early(self):
        """
        This method should be implemented for Receivers that must
        be connected before Senders.
        """
        pass

    @property
    def doc(self):
        return self._doc

    def connect(self):
        raise NotImplementedError()

    def send(self, message):
        """
        Send the token over the current method.
        """
        raise NotImplementedError()

    def recv(self, message):
        """
        Receive the token over the current method.

        Must raise a CheckDeliveryException (OkException, CriticalException...).
        """
        raise NotImplementedError()

    def clean(self):
        """
        Post send/recv task to clean things...
        """
        pass

    def close(self):
        """
        Oposit of connect()
        """
        raise NotImplementedError()

    def close_late(self):
        """
        If you cannot close the sender before using the receiver,
        use this method.
        """
        pass
