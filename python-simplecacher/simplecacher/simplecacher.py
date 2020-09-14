import socketserver
import ssl
import select
import http.server
import http.client
import socket
import traceback

from urllib.parse import urlparse

from simplecacher.sclogger import SCLogger
from simplecacher.cacher import Cacher
from simplecacher.config import Config
from simplecacher.tlsmanager import CertManager


class ProxyStopException(Exception):
    pass


class ProxyHandler(http.server.BaseHTTPRequestHandler):

    peer = False

    # FIXIT: debug new threads
    # def __new__(cls, *args, **kwargs):
    #    print('new')
    #    return super(ProxyHandler, cls).__new__(cls)

    def handle(self, *args, **kwargs):
        # FIXIT: log disconnection errors/prevent them before writing to a
        # closed channel
        self.close_connection = 0
        try:
            self.handle_one_request()
        except ProxyStopException as e:
            SCLogger.app.debug('Connection handle an stop demand.')
        except socket.gaierror as e:
            SCLogger.app.info('Cannot resolve {0}'.format(self.sanitized_host))
        except ssl.SSLError as e:
            self.peer = False
            SCLogger.app.info('Disconnect: {0}'.format(e))
            SCLogger.app.debug(
                'Traceback:\n{0}'.format(traceback.extract_tb(e.__traceback__)))
        except BrokenPipeError as e:
            SCLogger.app.info('Disconnect: {0}'.format(e))
            SCLogger.app.debug(
                'Traceback:\n{0}'.format(traceback.extract_tb(e.__traceback__)))
        except OSError as e:
            SCLogger.app.info('Disconnect: {0}'.format(e))
            SCLogger.app.debug(
                'Traceback:\n{0}'.format(traceback.extract_tb(e.__traceback__)))
        except ssl.SSLEOFError as e:
            SCLogger.app.info('Disconnect: {0}'.format(e))
            SCLogger.app.debug(
                'Traceback:\n{0}'.format(traceback.extract_tb(e.__traceback__)))

    # def handle_one_request(self, *args, **kwargs):
    #    if self.peer:
    #        rs, w, x = select.select([self.rfile], [], [])
    #    super(ProxyHandler, self).handle_one_request(*args, **kwargs)

    def log_message(self, *args, **kwargs):
        SCLogger.proxy.info(
            self.requestline, extra={'sourceip': self.address_string()})

    def sanitize_path(self, force_peer=False):
        """
        set self.sanitized_host, port and path.
        """
        # we are preparing to CONNECT
        if force_peer and not self.peer:
            host_port = self.path.split(':')
            self.sanitized_host = host_port[0]
            self.sanitized_port = int(host_port[1])
            self.sanitized_path = self.path
            SCLogger.app.debug(
                'Pre-sanitized path: {0}:{1}'.format(self.sanitized_host, self.sanitized_port))
        # we are in a CONNECTed state
        elif not force_peer and self.peer:
            self.sanitized_path = self.path
            SCLogger.app.debug(
                'Post-sanitized path: {0}:{1}{2}'.format(self.sanitized_host, self.sanitized_port, self.sanitized_path))
        # CONNECT was not called, this is a pure HTTP connection
        else:
            pu = urlparse(self.path)
            port = 80
            netloc = pu.netloc.split(':')
            host = netloc[0]
            path = pu.path
            if pu.query:
                path += '?' + pu.query
            if len(netloc) > 1:
                port = netloc[1]

            self.sanitized_host = host
            self.sanitized_port = int(port)
            self.sanitized_path = path
            SCLogger.app.debug(
                'Sanitized path: {0}:{1}{2}'.format(self.sanitized_host, self.sanitized_port, self.sanitized_path))
        # check if we can resolve this host, otherwise let the exeption
        # propagate
        socket.gethostbyname(self.sanitized_host)

    def create_connection(self, http_method, message_body=b'', send=True):
        """
        Setup proxy -> remote HTTP(S) connection
        Send data

        :param send: call HTTP(S)Connection.endheaders() and .send() if
            body isn't empty.
        """

        self.sanitize_path()

        if self.peer:
            conn = http.client.HTTPSConnection(
                self.sanitized_host, self.sanitized_port)
        else:
            conn = http.client.HTTPConnection(
                self.sanitized_host, self.sanitized_port)

        conn.connect()
        conn.putrequest(http_method, self.sanitized_path)

        # FIXIT: Host header can be overriden
        # FIXIT: content-length recomputation may not be needed
        for cheader in self.headers.items():
            chk = cheader[0].lower()
            chv = cheader[1]
            if chk in ['host']:
                continue
            elif chk in ['content-length']:
                chv = len(message_body)
            conn.putheader(cheader[0], chv)

        if send:
            conn.endheaders()
            if message_body:
                conn.send(message_body)

        return conn

    def transfer_response(self, conn, from_cache=True, send=True):
        r = conn.getresponse()

        self.send_response(r.status, r.reason)

        rheaders = r.getheaders()

        content_length = 0

        for rheader in rheaders:
            SCLogger.http.debug(
                'Response header: {0}: {1}'.format(rheader[0], rheader[1]))
            if rheader[0].lower() in ['transfer-encoding']:
                continue
            elif rheader[0].lower() in ['content-length']:
                content_length = int(rheader[1])
            self.send_header(rheader[0], rheader[1])

        if send:
            self.end_headers()
            if from_cache:
                hit, cfp, streamer = Proxy.cacher.cache_data(
                    self.sanitized_host, self.sanitized_path, r, filesize=content_length)
            else:
                hit, cfp, streamer = Proxy.cacher.cache_bypass(r)
            for data in streamer:
                self.send_response_to_client(data)
            if cfp:
                Proxy.cacher.complete_cache_data(cfp, content_length)

    def send_response_to_client(self, data):
        try:
            self.wfile.write(data)
        except ssl.SSLEOFError as e:
            SCLogger.app.info('Error writing: {0}'.format(e))

    def do_GET(self, *args, **kwargs):
        conn = self.create_connection('GET')
        self.transfer_response(conn)

    def do_HEAD(self, *args, **kwargs):
        conn = self.create_connection('HEAD')
        self.transfer_response(conn)
        self.close_connection = 1

    def do_POST(self, *args, **kwargs):

        clen = int(self.headers.get('content-length', 0))

        message_body = self.rfile.read(clen)

        # FIXIT: read/write by chunks
        conn = self.create_connection('POST', message_body=message_body)
        self.transfer_response(conn, from_cache=False)

    def do_PUT(self, *args, **kwargs):

        clen = int(self.headers.get('content-length', 0))

        message_body = self.rfile.read(clen)

        conn = self.create_connection('PUT', message_body=message_body)
        self.transfer_response(conn)

    def do_DELETE(self, *args, **kwargs):
        conn = self.create_connection('DELETE')
        self.transfer_response(conn)

    def do_OPTIONS(self, *args, **kwargs):
        conn = self.create_connection('OPTIONS')
        self.transfer_response(conn)

    def send_CONNECT_ack(self):
        self.send_response(200, 'Connection Established')
        self.end_headers()

    def do_CONNECT(self):
        self.sanitize_path(force_peer=True)
        if not int(Config.app.tls_mitm):
            self.do_CONNECT_RAW()
        else:
            self.do_CONNECT_SSLMITM()

    def do_CONNECT_SSLMITM(self):
        """
        1. Send OK to the client before 'forking' the socket's filedescriptor.
        2. Show our custom SSL certificate to the client by wrapping it's socket.
        3. Replace the current request handler (socket) by our SSL socket.
        4. Loop in handle() function to parse the true request.
        """
        ssl_cn = self.sanitized_host
        sh = CertManager()
        ssl_check, fdomain = sh.generate(ssl_cn)
        if not ssl_check:
            SCLogger.app.info(
                'Fail to CONNECT to {0} because of SSL certificate generation error.'.format(ssl_cn))
            return

        if hasattr(ssl, Config.tls.certificate_validation_mode):
            cert_reqs = getattr(ssl, Config.tls.certificate_validation_mode)
        else:
            cert_reqs = ssl.CERT_REQUIRED

        self.send_CONNECT_ack()

        sslprotocols = ssl.PROTOCOL_TLSv1
        sslcontext = ssl.SSLContext(sslprotocols)
        sslcontext.verify_mode = cert_reqs
        sslcontext.load_cert_chain(
            "keys/{0}.crt".format(fdomain),
            keyfile="keys/{0}.key".format(fdomain))

        sslsock = sslcontext.wrap_socket(
            self.request,
            do_handshake_on_connect=True,
            server_side=True)

        self.peer = True
        self.request = sslsock
        self.setup()
        self.handle_one_request()

    def do_CONNECT_RAW(self):
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect((self.sanitized_host, self.sanitized_port))
        self.send_CONNECT_ack()
        recv_buffer = int(Config.streamer.recv_buffer)
        while True:
            rs, w, x = select.select([sock, self.request], [], [])
            for r in rs:
                data = r.recv(recv_buffer)
                if not data:
                    sock.close()
                    self.request.close()
                    return
                if r == sock:
                    self.request.send(data)
                elif r == self.request:
                    sock.send(data)


class ThreadedProxyServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    allow_reuse_address = True


class Proxy(object):

    def run(self):
        SCLogger.init_loggers()
        Proxy.cacher = Cacher()
        server = ThreadedProxyServer(
            (Config.app.bind_address, int(Config.app.bind_port)),
            ProxyHandler)
        SCLogger.app.info(
            'Proxy is on {0}:{1}'.format(Config.app.bind_address, Config.app.bind_port))
        try:
            server.serve_forever()
        except KeyboardInterrupt:
            server.server_close()
            SCLogger.app.info('Quit')
