#!/usr/bin/env python3
# pip install git+https://github.com/Pipoline/rocket-python

import argparse
import re
import sys
import json
from urllib.parse import urlsplit

from collections import defaultdict

from rocketchat.api import RocketChatAPI
from pprint import pprint


def main(args):
    domain = urlsplit(args.url).netloc

    api = RocketChatAPI(
        settings={
            'username': args.username,
            'password': args.password,
            'domain': args.url,
        }
    )

    rooms = api.get_public_rooms()
    messages = defaultdict(list)

    for room in rooms:
        history = api.get_room_history(room['id'], count=0)
        print(f"room {room['name']} has {len(history['messages'])} messages")
        for message in history['messages']:
            matches = re.findall('(https?://[^\s]+)', message['msg'])
            for url in matches:
                if not re.match(f'^https?://{domain}', url):
                    messages[room['name']].append(url)

    with open('urls.json', 'w') as fh:
        json.dump(messages, fh)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--url', '-U', required=True, type=str)
    parser.add_argument('--username', '-u', required=True, type=str)
    parser.add_argument('--password', '-p', required=True, type=str)
    main(parser.parse_args())
