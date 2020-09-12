import shutil
import os

from os.path import abspath
from os.path import join as pathjoin

from simplecacher.sclogger import SCLogger
from simplecacher.config import Config
from simplecacher.utils import Utils


class CertManager(object):

    OPENSSL_NEWKEY_FORMAT = '{4} req -new -config {0} -keyform PEM -keyout {1} -outform PEM -out {2} -nodes -newkey rsa:2048 -subj {3}'
    OPENSSL_CASIGN_FORMAT = '{6} x509 -CA {0} -CAkey {1} -CAserial {2} -req -in {3} -outform PEM -out {4} -days {5}'
    OPENSSL_SUBJECT_FORMAT = '\'/C={0}/ST={1}/L={2}/O={3}/OU={4}/CN={5}/emailAddress={6}/subjectAltName=DNS.1={5}\''

    def __init__(self, *args, **kwargs):
        self.key_dir = self.normpath(Config.tls.store_path)
        self.ca_key = self.normpath(Config.tls.ca_key_file)
        self.ca_crt = self.normpath(Config.tls.ca_crt_file)
        self.ca_ser = self.normpath(Config.tls.ca_serial_file)
        self.ca_cnf = self.normpath(Config.tls.ca_openssl_config)
        self.obin = self.normpath(Config.tls.openssl_bin)
        self.validity_days = int(Config.tls.validity_days)

        self.prepare()
        super(CertManager, self).__init__()

    def normpath(self, path):
        path = os.path.normpath(path)
        path = path.replace('~', os.path.expanduser('~'))
        path = abspath(path)
        return path

    def prepare(self):
        if not os.path.isdir(self.key_dir):
            os.makedirs(self.key_dir)

    def sanitize_domain(self, domain):
        if len(domain) > 64:
            sdomain = domain.split('.')
            domain = '*.' + '.'.join(sdomain[1:])
        return domain, domain.replace('*', 'wildcard')

    def generate(self, domain, force=False):
        domain, fdomain = self.sanitize_domain(domain)

        if self.check_cert(domain) and not force:
            SCLogger.tls.debug('Certificate for {0} is ok'.format(domain))
            return True, fdomain

        ssl_key = pathjoin(self.key_dir, fdomain + '.key')
        ssl_cert = pathjoin(self.key_dir, fdomain + '.crt')
        ssl_csr = pathjoin(self.key_dir, fdomain + '.csr')

        if not self.check_cert(domain):
            self.cleanup(domain)

        SCLogger.tls.debug(
            'Generate new certificate for {0}'.format(domain))
        ssl_subj = self.OPENSSL_SUBJECT_FORMAT.format(
            Config.tls.subj_country,
            Config.tls.subj_state,
            Config.tls.subj_locality,
            Config.tls.subj_organization,
            Config.tls.subj_ounit,
            domain,
            Config.tls.subj_email,
        )
        cmd_key = self.OPENSSL_NEWKEY_FORMAT.format(
            self.ca_cnf,
            ssl_key,
            ssl_csr,
            ssl_subj,
            self.obin,
        )
        if Config.tls.debug_openssl_cmd:
            SCLogger.tls.debug('OpenSSL cmd key: {0}'.format(cmd_key))
        ssl_log_key = Utils.popen_process(cmd_key)
        cmd_cert = self.OPENSSL_CASIGN_FORMAT.format(
            self.ca_crt,
            self.ca_key,
            self.ca_ser,
            ssl_csr,
            ssl_cert,
            self.validity_days,
            self.obin,
        )
        if Config.tls.debug_openssl_cmd:
            SCLogger.tls.debug('OpenSSL cmd cert: {0}'.format(cmd_cert))
        ssl_log_cert = Utils.popen_process(cmd_cert)

        cert_check = self.check_cert(domain)

        if cert_check:
            SCLogger.tls.info('Certificate for {0} generated'.format(domain))
        else:
            ssl_log_key_full = Utils.popen_fulloutput(ssl_log_key)
            ssl_log_cert_full = Utils.popen_fulloutput(ssl_log_cert)
            SCLogger.tls.critical('Certificate for {0} has NOT been generated'.format(domain))
            SCLogger.tls.critical('OpenSSL output for {0}.key:\n{1}'.format(domain, ssl_log_key_full))
            SCLogger.tls.critical('OpenSSL output for {0}.crt:\n{1}'.format(domain, ssl_log_cert_full))

        return cert_check, fdomain

    def check_cert(self, domain):
        # FIXIT: check certificate real validity
        domain, fdomain = self.sanitize_domain(domain)
        return all(
            map(os.path.isfile,
                (
                    pathjoin(self.key_dir, fdomain + '.key'),
                    pathjoin(self.key_dir, fdomain + '.crt'),)))

    def cleanup(self, domain=None):
        try:
            if not domain:
                shutil.rmtree(self.key_dir)
            else:
                domain, fdomain = self.sanitize_domain(domain)
                for ctype in ('crt', 'key', 'csr'):
                    if os.path.exists(fdomain + '.' + ctype):
                        os.remove(pathjoin(self.key_dir, fdomain + '.' + ctype))
        except FileNotFoundError:
            pass
        finally:
            self.prepare()
