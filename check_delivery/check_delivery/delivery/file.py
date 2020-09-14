import os

from check_delivery.delivery import Method
from check_delivery.exceptions import CriticalException, OkException
from check_delivery import utils


class FileBase(Method):

    def _connect(self, mode):
        try:
            self.connection = open(self.path, mode)

        except FileNotFoundError:
            raise CriticalException('File not found: {}'.format(self.path))

        except PermissionError:
            raise CriticalException(
                'File has bad permissions: {}'.format(self.path))

    def recv(self, message):
        res = self.connection.readlines()[0]

        if res != message:
            raise CriticalException(
                'Token not found in file {}'.format(self.path))

        raise OkException('Token found in file {}'.format(self.path))

    def send(self, message):
        self.connection.write(message)

    def close(self):
        self.connection.close()


class FileSend(FileBase):

    """file:///path/to/file"""


    def connect(self):
        super(FileSend, self)._connect('w')


class FileRecv(FileBase):

    """file:///path/to/file"""


    def connect(self):
        super(FileRecv, self)._connect('r')

    def clean(self):
        os.remove(self.path)
