class HTTPMessage(object):
    __slots__ = [
        'headers',
        'body',
        'cmd',
        'method',
        'cmd_path',
        'cmd_option',
        'raw']

    def __init__(self, *args, **kwargs):
        self.headers = []
        self.body = ''
        self.cmd = ''
        self.method = ''
        self.cmd_path = ''
        self.cmd_option = ''
        self.raw = ''
        super(HTTPMessage, self).__init__(*args, **kwargs)


class HTTPParser(object):

    @staticmethod
    def parse(content):
        http_msg = HTTPMessage()
        http_msg.raw = content

        spcontent = content.split('\r\n\r\n', 1)
        http_header = spcontent[0]
        if len(spcontent) > 1:
            http_msg.body = spcontent[1]
        else:
            http_msg.body = ''

        spheader = http_header.split('\r\n')

        cmd, headers = spheader[0].split(' '), spheader[1:]

        headers = [x.split(': ') for x in headers]

        http_msg.headers = dict(headers)
        http_msg.cmd = cmd
        http_msg.method = cmd[0]
        try:
            http_msg.cmd_path = cmd[1]
        except IndexError:
            http_msg.cmd_path = ''
        try:
            http_msg.cmd_option = cmd[2]
        except IndexError:
            http_msg.cmd_option = ''

        return http_msg

class HTTPHeader(object):
    @staticmethod
    def dict2header(headers):
        txt = '\r\n'.join([': '.join((k, v))
             for k, v in headers.items()])
        return txt

    @staticmethod
    def join_to_body(headers, body):
        return '\r\n\r\n'.join((headers, body))