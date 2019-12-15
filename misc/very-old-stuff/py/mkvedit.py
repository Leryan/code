#!/usr/bin/env python3
# vim: expandtab tabstop=4 shiftwidth=4

"""
export LANG=en_US.UTF-8
export LC_ALL=$LANG
python3 mkvedit.py /path/to/videos
"""

import os
import sys
import re
import locale

import subprocess
from io import StringIO

path = ''
try:
    path = sys.argv[1]
except IndexError:
    sys.exit(1)

re_tracknum = re.compile('^([0-9]*)[ ]*(.*).mkv$', re.I)
re_book = re.compile('^(Livre [IV]+)$')
re_infotracknum = re.compile('^\|  \+ Track number: [0-9]+ \(track ID for mkvmerge & mkvextract: ([0-9])\)')

def get_tracknum(typetrack, fullfilename):
    p = subprocess.Popen(['mkvinfo', fullfilename], stdout=subprocess.PIPE, universal_newlines=True)
    lines = p.stdout.readlines()
    for i, line in enumerate(lines):
        if line == '| + A track\n':
            if lines[i + 3] == '|  + Track type: ' + typetrack + '\n':
                m = re_infotracknum.match(lines[i + 1][:-1])
                return m.group(1)

os.chdir(path)

kaamelott = {}
for dirpath, dirnames, filenames in os.walk('.'):
    bookpath = os.path.basename(dirpath)
    if re_book.match(bookpath) and len(filenames):
        kaamelott[bookpath] = filenames

workfiles = {}
for book, files in kaamelott.items():
    for kfile in files:
        m = re_tracknum.match(kfile.replace('[nirvanaj]', ''))
        nkfile = m.group(1) + ' ' + m.group(2) + '.mkv'

        try:
            workfiles[book].append(nkfile)
        except KeyError:
            workfiles[book] = [nkfile]

        if kfile != nkfile:
            print(kfile + ' : ' + nkfile)
            os.rename(book + '/' + kfile, book + '/' + nkfile)
        else:
            print(kfile + ' OK')

failed = []
for book, files in workfiles.items():
    for wfile in files:
        mwfile = re_tracknum.match(wfile)
        wfilepath = book + '/' + wfile
        cmd = ['mkvpropedit']

        tracknum = mwfile.group(1).zfill(3)
        episode = mwfile.group(2)
        title = book + ', épisode ' + tracknum + ' : ' + episode

        try:
            videotrack = str(int(get_tracknum('video', wfilepath)) + 1)
            subtrack = str(int(get_tracknum('subtitles', wfilepath)) + 1)

            cmd.append('"' + wfilepath+ '"')
            cmd.append('--edit info --set title="' + title + '"')
            cmd.append('--edit track:' + videotrack + ' --set name="' + title + '"')
            cmd.append('--edit track:' + subtrack + ' --set flag-enabled=0')
            cmd = ' '.join(cmd)
            print(cmd)
            os.system(cmd)
        except:
            failed.append(wfilepath)

if len(failed):
    print(failed)
