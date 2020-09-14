import argparse
import time
import sys
import hashlib
import traceback
import configparser

from time import time, sleep
from urllib.parse import urlparse

from check_delivery.exceptions import *
from check_delivery.delivery import Method
from check_delivery.timer import Timer
from check_delivery.expects import Expects
import check_delivery.classmaps as classmaps


__version__ = '0.1.0'
__location__ = 'https://github.com/Leryan/check_delivery'


class DeliveryStatus(object):

    def __init__(self, sendurl=None, recvurl=None, classmap=None,
                 conf=None, play=None, *args, **kwargs):
        super(DeliveryStatus, self).__init__(*args, **kwargs)

        self.classmap = classmap
        self.step = 'config'
        self.sendurl = sendurl
        self.recvurl = recvurl

        if conf is not None and play is not None:
            self.sendurl = self.get_final_url(conf, '{}.send'.format(play))
            self.recvurl = self.get_final_url(conf, '{}.recv'.format(play))

        self.timer = Timer()

        self.sender = DeliveryStatus.get_class_from_url(
            self.sendurl, 'send', Method, classmap=classmap)(self.sendurl, self.recvurl)

        self.receiver = DeliveryStatus.get_class_from_url(
            self.recvurl, 'recv', Method, classmap=classmap)(self.recvurl, self.sendurl)

    def get_final_url(self, file_path, key):
        url = None

        with open(file_path, 'r') as conf_file:
            config = configparser.ConfigParser(
                interpolation=configparser.ExtendedInterpolation())
            config.read_file(conf_file)

            try:
                url = config['scenarios'].get(key, None)
            except configparser.InterpolationMissingOptionError as ex:
                raise BadConfigurationException(str(ex))

        if url is None:
            raise BadConfigurationException(
                'Cannot find scenario {}'.format(key))

        return url

    def token_generate(self):
        basetoken = "{0}{1}{2}".format(
            time(), self.sendurl, self.recvurl)
        self.token = hashlib.sha512(bytes(basetoken, "utf-8")).hexdigest()

    @staticmethod
    def get_class_from_url(url, classtype, default_class, classmap={}):
        method_name = urlparse(url).scheme

        method_class = classmap.get(method_name, {classtype: None})[classtype]

        if method_class is None:
            raise BadMethodException(
                '{} is not supported for {} method'.format(classtype, method_name))

        return method_class

    @staticmethod
    def get_classmap(custom_classmap=None):
        classmap = classmaps.default_classmap()

        try:
            classmap = classmaps.merge_classmaps(
                [classmap, classmaps.irc_classmap()])
        except ImportError as ex:
            pass

        if custom_classmap is not None:
            classmap = classmaps.merge_classmaps(
                [classmap, custom_classmap])

        return classmap

    def step_checkpt(self, step_name, func, *args, active=True, **kwargs):
        self.step = step_name
        func(*args, **kwargs)
        self.timer.checkpoint(self.step, active)

    def launch(self, wait):
        self.timer.start()

        self.step_checkpt('token', self.token_generate)
        self.step_checkpt('recv_conn_early', self.receiver.connect_early)
        self.step_checkpt('send_conn', self.sender.connect)
        self.step_checkpt('send_send', self.sender.send, self.token)
        self.step_checkpt('send_clean', self.sender.clean)
        self.step_checkpt('send_close', self.sender.close)
        self.step_checkpt('waited', sleep, wait, active=False)
        self.step_checkpt('recv_conn', self.receiver.connect)

        recv_ex = None

        try:
            self.step = 'recv_recv'
            self.receiver.recv(self.token)
        except StatusException as ex:
            recv_ex = ex

        self.timer.checkpoint(self.step)

        self.step_checkpt('recv_clean', self.receiver.clean)
        self.step_checkpt('recv_close', self.receiver.close)
        self.step_checkpt('recv_close_late', self.sender.close_late)

        self.timer.end()
        self.timer.add(
            'active_duration', self.timer.duration(active_only=True))
        self.step = 'finished'

        return recv_ex


def get_classmap_doc(classmap):
    docs = []

    for mname in sorted(classmap['__methods'].keys()):
        d = classmap['__methods'][mname]
        for mtype, mclass in d.items():
            if mclass is not None:
                docs.append(
                    '{}.{}: \n    {}\n\n'.format(mname, mtype, mclass.__doc__))

    return docs


def check_delivery_status(output, conf_file, play, expects_class):
    expects = Expects(conf_file, expects_class)

    return expects.check(output, play)


def check_delivery_parsed(args, classmap, output_type='json'):
    """
    :param args: something similar as the result from ArgumentParser.parse_args()
    :param custom_classmap: dict of recv/send classes.
            {
                "__outputs": {
                    "type": class
                },
                "__methods": {
                    "type": {
                        "recv": class,
                        "send": class
                    }
                }
            }
    :param output_type: output name, as string.
    """

    rcode = 3
    timer = Timer()
    output = classmap['__outputs'][output_type]()
    expects_class = classmap['__expects']['expects']

    try:
        cd = DeliveryStatus(sendurl=args.sendurl, recvurl=args.recvurl, classmap=classmap[
                            '__methods'], conf=args.conf, play=args.play)

        ex = cd.launch(args.wait)
        timer = cd.timer

        raise ex

    except StatusException as ex:
        if args.reraise:
            raise ex
        else:
            output.status = ex.rcode
            output.message = str(ex)
            output.timers = timer
            output.step = cd.step
            rcode = ex.rcode

    except (CheckDeliveryException, Exception) as ex:
        if args.reraise:
            raise ex
        else:
            exc_type, exc_value, exc_traceback = sys.exc_info()
            output.status = 3
            output.message = str(ex)
            output.details = ''.join(
                traceback.format_exception(exc_type, exc_value, exc_traceback))

            if isinstance(ex, CheckDeliveryException):
                output.step = 'init'
            else:
                output.step = cd.step

    if args.conf:
        expect_res = check_delivery_status(output, args.conf, args.play, expects_class)
        output.expect_res = expect_res

        # Override rcode after checking the expects.
        # If returned None, do nothing.
        # output.status is reassigned to rcode and it's ok.
        if expect_res == True:
            rcode = 0

        elif expect_res == False:
            rcode = 2

        output.status = rcode

    return rcode, output


def check_delivery(custom_classmap=None):
    parser = argparse.ArgumentParser()

    parser.add_argument(
        '--send', '-s', dest='sendurl', type=str)

    parser.add_argument('--wait', '-w', dest='wait', type=int, default=0)

    parser.add_argument(
        '--recv', '-r', dest='recvurl', type=str)
    parser.add_argument('--raise', '-R', dest='reraise', action='store_true')

    parser.add_argument('--output', '-o', dest='output',
                        default='nagios', help='output format: nagios, json')

    parser.add_argument('--doc', '-l', dest='listmeths', action='store_true',
                        help='list available methods and how to use them')

    parser.add_argument('--conf', '-c', dest='conf',
                        help='configuration file (INI) containing senders, receivers, scenarios...')

    parser.add_argument('--play', '-p', dest='play',
                        help='play a given check defined in the special conf section [scenarios]')

    parsed_args = parser.parse_args()

    classmap = DeliveryStatus.get_classmap(custom_classmap)

    if parsed_args.listmeths:
        docs = get_classmap_doc(classmap)
        for doc in docs:
            sys.stdout.write(doc)
        sys.stdout.flush()
        return 0

    rcode, output = check_delivery_parsed(
        parsed_args, classmap, output_type=parsed_args.output)

    print(output)
    return rcode

if __name__ == '__main__':
    sys.exit(check_delivery())
