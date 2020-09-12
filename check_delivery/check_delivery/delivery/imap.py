import imaplib

from urllib.parse import unquote as urldecode

from check_delivery.delivery import Method
from check_delivery.exceptions import OkException, UnknownException, CriticalException


class IMAPRecvMethod(Method):

    """imap://user:password@host:port/Mailbox

    Mailbox defaults to 'INBOX'"""

    def __init__(self, *args, **kwargs):
        super(IMAPRecvMethod, self).__init__(*args, **kwargs)
        self._mailbox_to_clean = None

    def connect(self):
        self.connection = imaplib.IMAP4(self.host, self.port)

    def login(self):
        if self.password is not None:
            return self.connection.login(self.user, self.password)

    def recv(self, message):
        if self.path == '':
            path = 'INBOX'
        else:
            path = self.path[1:]

        res = self.connection.select(mailbox=path)

        if res[0] != 'OK':
            raise UnknownException(
                'Failed to change mailbox: {}'.format(res[1][0]))

        search = '(FROM {0} TEXT {1})'.format(
            urldecode(self.remoteurl.username), message)
        res = self.connection.search(None, search)

        if res[0] != 'OK':
            raise UnknownException('Failed to search messages.')

        msgnums = res[1][0].split()

        if len(msgnums) > 1:
            raise UnknownException(
                'Token found in multiple messages: {0}'.format(msgnums))

        if len(msgnums) == 0:
            raise CriticalException('Token not found.')

        self._mailbox_to_clean = msgnums[0]

        raise OkException('Token found in message {0}'.format(msgnums[0]))

    def close(self):
        self.connection.close()

    def clean(self):
        if self._mailbox_to_clean is not None:
            self.connection.store(self._mailbox_to_clean, '+FLAGS', '\\Deleted')
            self.connection.expunge()


class IMAPStartTLSRecvMethod(IMAPRecvMethod):

    """imapstarttls://user:password@host:port/Mailbox"""

    def connect(self):
        self.connection = imaplib.IMAP4(self.host, self.port)
        self.connection.starttls()
        self.login()


class IMAPSRecvMethod(IMAPRecvMethod):

    """imaps://user:password@host:port/Mailbox"""

    def connect(self):
        self.connection = imaplib.IMAP4_SSL(
            self.host, self.port, ssl_context=self.get_ssl_context())
        self.login()
