#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

"""
/* Copyright (c) 2010-2011, Florent PETERSCHMITT
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of Florent PETERSCHMITT nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
"""

__author__ = 'fpeterscom@yahoo.fr (Florent Peterschmitt)'

import hashlib
import os
import sys
import optparse
import lji_ftp
import lji_yesno
import netrc
import ConfigParser

def file_MD5sum(t_file):
    if os.path.isdir(t_file):
        return ''
    else:
        try:
            f = open(t_file, 'rb')
        except IOError:
            return ''
        md5sum = hashlib.md5()
        for chunk in iter(lambda: f.read(128 * md5sum.block_size), ''):
            md5sum.update(chunk)
        f.close()
        return md5sum.hexdigest()

def list_files_pattern(folder, pattern):
    if os.path.isdir(folder):
        listdir = os.listdir(folder)
        f_list = []
        for t_file in listdir:
            if t_file[-len(pattern[1:]):] == pattern[1:]:
                f_list.append(folder + t_file)
        return f_list
    else:
        return []

def write_md5sum(pt_file, version):
    md5sum = file_MD5sum(pt_file)
    if md5sum != '':
        version.write(pt_file + '=' + md5sum + '\n')
    else:
        sys.stderr.write('\"' + pt_file + '\' does not exist.\n')

def write_version_lst(n_f_list, n_f_version):
    try:
        file_list = open(n_f_list, 'r')
        version = open(n_f_version, 'w')
    except IOError:
        sys.stderr.write('Problem with ' + n_f_list + ' and ' + n_f_version + ' files.\n')
        quit()

    path = ''
    verbatim = False;

    for line in file_list:
        line = line.replace('\r', '')
        if line[0] == '$':
            path = line[1:-1]

        else:
            if line[0] == '*':
                for x in list_files_pattern(path, line[1:-1]):
                    write_md5sum(x, version)

            elif verbatim == True and line[0] != '}':
                version.write(line)

            elif verbatim == False and line[0] == '{':
                verbatim = True

            elif line[0] == '}':
                verbatim = False

            elif line[0] != '\n' and line[0] != '#':
                line = line[0:-1]
                write_md5sum(path + line, version)
    version.close()

def send_ftp(host, user, password, lst):
    datas = []
    will_send = []
    i = 0

    t_file = open(lst, 'r')
    config = ConfigParser.ConfigParser()
    config.read(t_file.name)

    ftp = lji_ftp.ftp_connect(host, user, password)

    if ftp == 'Error':
        t_file.close()
        quit()

    for section in config.sections():
        if section == 'KEEP':
            for val in config.options(section):
                if lji_yesno.prompt('Send ' + val + ' ?'):
                    confirm = True
                else:
                    confirm = False
                datas.append([val, config.get(section, val), confirm])

    datas.append([t_file.name, file_MD5sum(t_file.name), lji_yesno.prompt('Send ' + t_file.name + ' ?')])
    t_file.close()

    ftp.cwd('web/update')

    i = 0
    for x in datas:
        if x[2]:
            print('x[0] : ' + x[0])
            t_file = open(x[0], 'rb')
            try:
                sys.stdout.write('Sending ' + x[0] + '... ')
                sys.stdout.flush()
                ftp.storbinary('STOR ' + x[0], t_file)
                sys.stdout.write('done.')
                sys.stdout.flush()
            except:
                sys.stderr.write('Error.\n')
                sys.stderr.flush()
        i += 1
    print('')

    ftp.quit()


def main_version():
    parser = optparse.OptionParser(usage='{0} -f in_file -o output_file'.format(sys.argv[0]))
    parser.add_option('-f', '--file-list', dest='n_f_list', help='File containing patterns to generate version.lst')
    parser.add_option('-o', '--output-file', dest='n_f_version', help='Output file')
    parser.add_option('-u', '--upload', dest='upload', help='Upload files on FTP')
    parser.add_option('--ftp-host', dest='ftp_host', help='FTP Host used to send files')
    parser.add_option('--ftp-user', dest='ftp_user', help='FTP user')
    parser.add_option('--ftp-pass', dest='ftp_pass', help='FTP password')

    i = 0
    options, args = parser.parse_args()
    hosts = []

    if options.n_f_list and options.n_f_version:
        n_f_list = options.n_f_list
        n_f_version = options.n_f_version
    else:
        n_f_list = 'file_list'
        n_f_version = 'version.lst'

    if not (options.ftp_host or options.ftp_user or options.ftp_pass):
        con_info = netrc.netrc('netrc')
        for host in con_info.hosts:
            hosts.append(host)
            sys.stdout.write('\n' + str(i) + ' : ' + host)
            sys.stdout.flush()
            i += 1

        host = hosts[int(raw_input('\nHost to use : '))]
        auth = con_info.authenticators(host)
    else:
        host = options.ftp_host
        auth = (options.ftp_user, '', options.ftp_pass)

    write_version_lst(n_f_list, n_f_version)
    if lji_yesno.prompt('Send files to FTP ?'):
        send_ftp(host, auth[0], auth[2], n_f_version)

if __name__ == '__main__':
    main_version()
