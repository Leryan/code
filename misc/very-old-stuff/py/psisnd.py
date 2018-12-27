#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import dbus
import sys
import time
import gobject
from dbus.mainloop.glib import DBusGMainLoop
import argparse
import signal

global args
global dbus_psi
global loop

def hdl_sigint(signal, frame):
	global loop
	print('\rBye bye!')
	loop.quit()

def hdl_amarok_sig(sender=None):
	global args
	global dbus_psi

	try:
		title  = sender.get('title')
		album  = sender.get('album')
		artist = sender.get('artist')
		play_msg = '♪ {} ({}) by {} ♪'.format(title, album, artist)
		print(play_msg)
		if not args.debug:
			dbus_psi.setStatus('online', play_msg)
	except AttributeError:
		sys.stderr.write('something went wrong when watching for value\n')
		sys.stderr.flush()

def main():
	global args
	global dbus_psi
	global loop

	dbus_loop    = DBusGMainLoop(set_as_default=True)
	dbus_session = dbus.SessionBus()

	try:
		dbus_amarok  = dbus_session.get_object(args.client, '/Player')
		if not args.debug:
			dbus_psi     = dbus_session.get_object('org.psi-im.Psi', '/Main')
	except dbus.exceptions.DBusException:
		sys.stderr.write('Psi or ' + args.client + ' not launched/reachable.\n')
		sys.stderr.flush()
		sys.exit(1)

	dbus_amarok.connect_to_signal('TrackChange', hdl_amarok_sig, dbus_interface='org.freedesktop.MediaPlayer')

	loop = gobject.MainLoop()
	loop.run()

if __name__ == '__main__':
	global args

	parser = argparse.ArgumentParser(
			description='Notify what you\'re listening to Psi XMPP client, using D-Bus.')
	parser.add_argument('--client', '-c',
			default='org.kde.amarok',
			help='dbus object to connect to. example: org.kde.amarok, org.mpris.clementine')
	parser.add_argument('--debug', '-d',
			action='store_true',
			help='don\'t send notification to Psi, only print to stdout.')

	args = parser.parse_args()

	signal.signal(signal.SIGINT, hdl_sigint)
	signal.signal(signal.SIGTERM, hdl_sigint)
	main()
