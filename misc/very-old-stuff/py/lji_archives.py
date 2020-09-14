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

import os
import getpass
import tarfile
import sys
import googlecode_upload
import platform
import lji_yesno
import httplib
import optparse

def reset_tarinfo(tarinfo):
    tarinfo.uid = tarinfo.gid = 0
    tarinfo.uname = tarinfo.gname = 'root'
    return tarinfo

def get_archive_name(name, version, ext):
    return name + '_' + version + '.' + ext

def build_archives(list_tar, version, ext):
    for s_list in list_tar:
        tar = tarfile.open(get_archive_name(s_list[0], version, ext), 'w:gz')

        if os.path.exists(s_list[1]):
            sys.stdout.write('Building {0}... '.format(get_archive_name(s_list[0], version, ext)))
            sys.stdout.flush()
            tar.add(s_list[1])
            for tarinfo in tar:
                reset_tarinfo(tarinfo)
            tar.close()
            print(" done.")
        else:
            sys.stderr.write('{0} does not exist.\n'.format(s_list[1]))
            tar.close()
            os.remove(get_archive_name(s_list[0], version, ext))


def get_file_list(version, ext):
    file_list = []
    files = os.listdir('.')

    for t_file in files:
        if t_file[ - (len(version) + 5):] == '_' + version + '.' + ext:
            file_list.append(t_file)

    return file_list

def upload_gc(user, password, project, file_list, list_tar):
    up = []
    i = 0

    for x in file_list:
        up.append(lji_yesno.prompt('Send {0} with label(s) {1} ?'.format(x, list_tar[i][3])))
        i += 1

    i = 0
    print('\nSending with user {0} to project {1}\n'.format(user, project))

    for t_file in file_list:
        if up[i]:
            sys.stdout.write('Sending {0}...'.format(t_file))
            sys.stdout.flush()
            label = None
            summary = "Waiting for..."
            status, reason, url = googlecode_upload.upload(t_file, project, user, password, summary, label)
            if status in {httplib.FORBIDDEN, httplib.UNAUTHORIZED}:
                sys.stderr.write('\nError when uploading, reason: {0}\n'.format(reason))
                quit()
            else:
                sys.stdout.write('\t\t\t[OK]\n')
        i += 1

def main_archive():
    parser = optparse.OptionParser(usage='{0} --ver tgzver --upload upload --build build_tgz --gc-user gc_user --gc-pass gc_password --gc-project gc_project'.format(sys.argv[0]))
    parser.add_option('--ver', dest='version', help='Version of TGZ files')
    parser.add_option('--upload', dest='upload', help='Y/N : upload files')
    parser.add_option('--build', dest='build', help='Y/N : rebuild TGZ')
    parser.add_option('--gc-user', dest='gc_user', help='GoogleCode username')
    parser.add_option('--gc-pass', dest='gc_pass', help='GoogleCode password')
    parser.add_option('--gc-project', dest='gc_project', help='GoogleCode project name')

    options, args = parser.parse_args()

    #Ask for version.
    if not options.version:
        version = raw_input('Version number : ')
    else:
        version = options.version
    #Ask for uploading (yes/NO)
    if not options.upload:
        up = lji_yesno.prompt('Upload ?')
    else:
        up = lji_yesno.convert_to_bool(options.upload)
    #Ask for rebuilding archives (yes/NO)
    if not options.build:
        build = lji_yesno.prompt('Build archives ?')
    else:
        build = lji_yesno.convert_to_bool(options.build)
    #Ask for user, password and project.
    if up:
        if not options.gc_user:
            gc_user = raw_input('Specify your GoogleCode user : ')
        else:
            gc_user = options.gc_user
        if not options.gc_pass:
            gc_pass = getpass.getpass('Specify your GoogleCode pass (will not echo) : ')
        else:
            gc_pass = options.gc_pass
        if not options.gc_project:
            gc_project = raw_input('Specify the GoogleCode project name : ')
        else:
            gc_project = options.gc_project

    list_tar =  [#name, folder/file, summary, labels
            ['Global', 'Global', 'Ressources : sons, niveaux, etc...', 'Featured'],
            ['Les-Jeux-Indemodables_src','src','Les sources du jeu.', 'Featured'],
            ['Windows.exe','exe-win', 'Exécutable Windows', 'Featured'],
            ['Linux-bin', 'exe-linux', 'Exécutables Linux i386 et x86_64', 'Featured']
            ]
    if build:
        build_archives(list_tar, version, 'tgz')

    if up:
        f_list = get_file_list(version, 'tgz')
        f_list.sort()
        print("Going to upload : ")
        for x in f_list:
            print("--> " + x)
        upload_gc(gc_user, gc_pass, gc_project, f_list, list_tar)

if __name__ == '__main__':
    main_archive()
