import smtplib
import ssl

from urllib.parse import unquote as urldecode
from email.mime.text import MIMEText

from check_delivery.delivery import Method
from check_delivery.exceptions import UnknownException
from check_delivery import __location__


class SMTPSendMethod(Method):

    """smtp://user:password@host:port"""

    def connect(self):
        self.connection = smtplib.SMTP(self.host, self.port)

    def login(self):
        if self.password is not None:
            return self.connection.login(self.user, self.password)

    def send(self, message):
        msg = MIMEText(str(message))
        msg['Subject'] = 'Check Delivery: {}'.format(__location__)
        msg['From'] = self.user
        msg['To'] = self.user
        try:
            res = self.connection.send_message(
                msg, self.user, urldecode(self.remoteurl.username))
        except smtplib.SMTPRecipientsRefused as ex:
            raise UnknownException(
                'Cannot send to the defined address.', source_exception=ex)

        return res

    def close(self):
        self.connection.close()


class SMTPSSendMethod(SMTPSendMethod):

    """smtps://user:password@host:port"""

    def connect(self):
        self.connection = smtplib.SMTP_SSL(
            self.host, self.port, context=self.get_ssl_context())
        self.connection.connect()
        self.login()


class SMTPStartTLSSendMethod(SMTPSendMethod):

    """smtpstarttls://user:password@host:port"""

    def connect(self):
        sslctx = ssl.create_default_context()
        sslctx.verify_mode = ssl.CERT_REQUIRED

        self.connection = smtplib.SMTP(self.host, self.port)
        self.connection.starttls(context=sslctx)
        self.login()
