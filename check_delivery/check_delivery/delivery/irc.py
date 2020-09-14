import functools
import ssl

from urllib.parse import unquote as urldecode

import irc.client
import irc.connection

from check_delivery import __location__
from check_delivery.delivery import Method
from check_delivery.exceptions import CriticalException, OkException


class IRCBase(Method):

    def __init__(self, *args, **kwargs):
        super(IRCBase, self).__init__(*args, **kwargs)

        self.target = urldecode(self.path[1:])
        if self.target == '':
            self.target = self.remoteurl.username

        self._state_joined = False
        self._connected = False
        self._ircreactor = irc.client.Reactor()
        self._ircserver = self._ircreactor.server()

    def _irc_on_welcome(self, connection, event):
        if self.target[0] == '#':
            connection.join(self.target)

        self._state_joined = True

    def _irc_on_privmsg(self, connection, event):
        if len(event.arguments) > 0:
            self.messages.append(event.arguments[0])

    def connect(self, tls=False):
        if self._connected:
            return

        self._ircreactor.add_global_handler("welcome", self._irc_on_welcome)
        self._ircreactor.add_global_handler("privmsg", self._irc_on_privmsg)
        self._ircreactor.add_global_handler("pubmsg", self._irc_on_privmsg)

        if tls:
            wrapper = functools.partial(ssl.wrap_socket)

        else:
            def empty_wrapper(sock, *args, **kwargs):
                return sock
            wrapper = functools.partial(empty_wrapper)

        irc_conn_factory = irc.connection.Factory(wrapper=wrapper)

        self._ircserver.connect(
            self.host, self.port, self.user, password=self.password, connect_factory=irc_conn_factory)

        self._connected = True

    def close(self):
        self._ircserver.quit('Check Delivery: {}'.format(__location__))
        self._ircserver.close()


class IRCSend(IRCBase):

    """irc://host:port/[sendfrom: #channel|user]"""

    def send(self, message):
        while not self._state_joined:
            self._ircreactor.process_once(timeout=1)
        self._ircserver.privmsg(self.target, message)


class IRCTLSSend(IRCSend):

    """irctls://host:port/[sendfrom: #channel|user]"""

    def connect(self, *args, **kwargs):
        return super(IRCTLSSend, self).connect(*args, tls=True, **kwargs)


class IRCRecv(IRCBase):

    """irc://host:port/[recvon: #channel|user]"""

    def __init__(self, *args, **kwargs):
        super(IRCRecv, self).__init__(*args, **kwargs)
        self.messages = []
        self._state_joined = False
        self._state_token = False

    def _irc_on_privmsg(self, connection, event):
        self.messages.append(event.arguments[0])

    def connect_early(self, *args, **kwargs):
        self.connect(*args, **kwargs)

        while not self._state_joined:
            self._ircreactor.process_once(timeout=1)

    def recv(self, message):

        tries = 0

        while not self._state_token and tries < 10:
            self._ircreactor.process_once(timeout=1)

            if message in self.messages:
                self._state_token = True

            tries += 1

        if tries > 9:
            raise CriticalException('Token not found on IRC')

        raise OkException('Token found on IRC')


class IRCTLSRecv(IRCRecv):

    """irctls://host:port/[recvon: #channel|user]"""

    def connect(self, *args, **kwargs):
        return super(IRCTLSRecv, self).connect(*args, tls=True, **kwargs)
