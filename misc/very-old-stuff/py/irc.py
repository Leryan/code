#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import socket
import string
import sys

PORT = 6667
SERVER = socket.getaddrinfo('irc.epiknet.org', PORT)[0][4][0]
NICKNAME = 'test_py'
CHANNEL = '#lpp'

IRC = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

def connect_irc():
    IRC.connect((SERVER, PORT))

def send_irc(command):
    IRC.send("{} \n".format(command))

def join_irc(channel):
    send_irc("JOIN {}".format(channel))

def login_irc(nickname, username='user', password = None, realname='Pythonist', hostname='Helena', servername='Server'):
    send_irc("USER {} {} {} {}".format(username, hostname, servername, realname))
    send_irc("NICK {}".format(nickname))

def read_irc():
    buff = IRC.recv(1024)
    return buff, str(buff)

def print_irc():
    msg, strmsg = read_irc()
    sys.stdout.write(strmsg)
    return msg, strmsg

def main():
    a = False
    connect_irc()
    login_irc("test_py")
    while(1):
        msg = print_irc()[0].split()
        if msg[0] == "PING":
            send_irc("PONG {}".format(msg[1]))
            print(msg[1])
        if not a:
            None
            #login_irc(NICKNAME)
            #join_irc(CHANNEL)
        else:
            a = True

if __name__ == '__main__':
    main()
