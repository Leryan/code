import ftplib
import io

from check_delivery.delivery import Method
from check_delivery.exceptions import CriticalException, OkException


class FTPBase(Method):

    """
    Handle the basic FTP connection.

    FTPBase.connect() handles the FTP login, real connection
    must be done in subclasses.
    """

    def __init__(self, *args, **kwargs):
        super(FTPBase, self).__init__(*args, **kwargs)

        self._sio = io.BytesIO()

    def login(self):
        if self.password is not None:
            self.connection.login(user=self.user, passwd=self.password)
        else:
            self.connection.login()

    def close(self):
        self.connection.quit()

    def connect(self):
        try:
            self.login()

        except ftplib.error_perm as ex:
            raise CriticalException(
                'Cannot login into FTP: {}'.format(ex), source_exception=ex)

    def send(self, message):
        self._sio.write(bytes(message, encoding='utf-8'))
        self._sio.seek(0)

        try:
            self.connection.storbinary('STOR {}'.format(self.path), self._sio)
        except ftplib.error_perm as ex:
            raise CriticalException(
                'Cannot store file on FTP: {}'.format(ex), source_exception=ex)

    def _recv(self, blocks):
        self._sio.write(blocks)

    def recv(self, message):
        self._sio.seek(0)

        try:
            self.connection.retrbinary('RETR {}'.format(self.path), self._recv)
        except ftplib.error_perm as ex:
            raise CriticalException(
                'Cannot open file on FTP: {}'.format(ex), source_exception=ex)

        self._sio.seek(0)

        if bytes(message, encoding='utf-8') == self._sio.read():
            raise OkException('Token found in FTP file')

        raise CriticalException('Token not found')


class FTPMethod(FTPBase):

    """ftp://user:password@host:port/path/to/file"""

    def connect(self):
        self.connection = ftplib.FTP(self.host)

        super(FTPMethod, self).connect()


class FTPSMethod(FTPBase):

    """ftps://user:password@host:port/path/to/file"""

    def connect(self):
        self.connection = ftplib.FTP_TLS(
            self.host, context=self.get_ssl_context())

        super(FTPSMethod, self).connect()

        try:
            self.connection.prot_p()
        except ftplib.error_perm as ex:
            raise CriticalException(
                'Cannot login into FTP: {}'.format(ex), source_exception=ex)
