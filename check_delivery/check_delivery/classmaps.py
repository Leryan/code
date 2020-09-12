def merge_classmaps(classmap_list):
    merged_classmap = empty_classmap()

    for classmap in classmap_list:
        for classmap_cat in classmap.keys():
            for k in classmap.get(classmap_cat, {}).keys():
                merged_classmap[classmap_cat][k] = classmap[classmap_cat][k]

    return merged_classmap

def empty_classmap():
    return {'__expects': {}, '__outputs': {}, '__methods': {}}

def default_classmap():

    from check_delivery.delivery.imap import IMAPRecvMethod, IMAPSRecvMethod, IMAPStartTLSRecvMethod
    from check_delivery.delivery.smtp import SMTPSendMethod, SMTPSSendMethod, SMTPStartTLSSendMethod
    from check_delivery.delivery.file import FileSend, FileRecv
    from check_delivery.delivery.ftp import FTPMethod, FTPSMethod

    from check_delivery.output.nagios import Nagios
    from check_delivery.output.json import Json

    from check_delivery.expects import ExpectsChecks

    classmap = {
        "__expects": {
            "expects": ExpectsChecks
        },
        "__outputs": {
            "nagios": Nagios,
            "json": Json
        },
        "__methods": {
            "imap": {
                "recv": IMAPRecvMethod,
                "send": None
            },
            "imaps": {
                "recv": IMAPSRecvMethod,
                "send": None
            },
            "imapstarttls": {
                "recv": IMAPStartTLSRecvMethod,
                "send": None
            },
            "smtp": {
                "send": SMTPSendMethod,
                "recv": None
            },
            "smtps": {
                "send": SMTPSSendMethod,
                "recv": None
            },
            "ftp": {
                "send": FTPMethod,
                "recv": FTPMethod
            },
            "ftps": {
                "send": FTPSMethod,
                "recv": FTPSMethod
            },
            "smtpstarttls": {
                "send": SMTPStartTLSSendMethod,
                "recv": None
            },
            "file": {
                "send": FileSend,
                "recv": FileRecv
            }
        }
    }

    return classmap


def irc_classmap():
    from check_delivery.delivery.irc import IRCSend, IRCRecv, IRCTLSSend, IRCTLSRecv

    classmap = empty_classmap()

    classmap['__methods']['irc'] = {'send': IRCSend, 'recv': IRCRecv}
    classmap['__methods']['irctls'] = {'send': IRCTLSSend, 'recv': IRCTLSRecv}

    return classmap