#!/usr/bin/env python3

import os
import argparse
import requests
import glob
import uuid

parser = argparse.ArgumentParser()
parser.add_argument("--dry-run", action="store_true")
parser.add_argument("--bearer", required=True, type=str, help="personnal access token")
parser.add_argument(
    "--apiurl", required=True, type=str, help="https://your.mattermost.domain/api/v4"
)
parser.add_argument("--chan", default="", type=str)
parser.add_argument("--mode", default="reboot", type=str)
parser.add_argument("--id", type=str, default="")

args = parser.parse_args()

channels = {
    "maison": "g3gsetkbgtf5bdfqxhyif9r3fc",
    "test": "19dqtjm6qirndrb6gkfbrw5hkw",
    "system": "ii3xto3mz38c8gihxmanc5iq4h",
}

announced_file = "/tmp/mm-announced"


def chan(name: str):
    if args.chan:
        return channels[args.chan]
    return channels[name]


def chan_rev(id_: str):
    for k, v in channels.items():
        if v == id_:
            return k
    raise ValueError("patate + " + id_)


class FakeResponse:
    ok = True
    text = "fake"

    def json(self):
        return '"' + r.text + '"'


def headers():
    return {
        "Authorization": "Bearer " + args.bearer,
    }


class OK(Exception):
    pass


class KO(Exception):
    pass


def main():
    reboot_required = len(glob.glob("/var/run/reboot-required*")) > 0 or args.dry_run
    announced = len(glob.glob(announced_file)) > 0

    if announced:
        if reboot_required:
            raise OK("annonce déjà postée")
        os.unlink(announced_file)

    if not reboot_required:
        raise OK("rien à faire")

    message = "@all **[message auto]** le serveur va redémarrer cette nuit pour appliquer des patchs de sécurité"

    r = post(message, chan("maison"))

    if not r.ok:
        raise KO(r.text)

    with open(announced_file, "w") as f:
        f.write("annonce de reboot postée")

    raise OK("annonce postée")


def ping(message: str):
    message = "**[message auto]** mm-announce.py ping: " + message
    return post(message, chan("system"))


def post(message: str, channel_id: str):
    if args.id:
        message = message + ' [ envoyé par "' + args.id + '" ]'

    return post_raw(message, channel_id)


def post_raw(message: str, channel_id: str):
    if args.dry_run:
        print(">> dry run post")
        print(chan_rev(channel_id) + " (" + channel_id + ")" + " -> " + message)
        return FakeResponse()

    return requests.post(
        args.apiurl + "/posts",
        json={"channel_id": channel_id, "message": message,},
        headers=headers(),
    )


def mode_reboot():
    if args.id == "uuid":
        args.id = str(uuid.uuid4())
        print(args.id)

    try:
        main()
    except OK as e:
        ping("ok: `" + str(e) + "`")
    except KO as e:
        ping("**KO: ** @flop `" + str(e) + "`")
    except Exception as e:
        ping("**UNEXPECTED KO: ** @flop `" + str(e) + "`")


def meteo(ville: str, s):
    res = s.get(f"https://wttr.in/{ville}?format=j1&0").json()

    temperature = int(res["current_condition"][0]["temp_C"])
    weatherCode = int(res["current_condition"][0]["weatherCode"])

    pic = s.get(f"https://wttr.in/{ville}?format=%c+%t").text.strip()
    message = f"À {ville} il fait {pic}"

    if temperature < 15 and weatherCode == "113":
        message = f"{message}. J’trouve qu’il fait beau, mais encore frais. Mais beau ! :perceval:"
    elif temperature < 8:
        message = f"{message}. Ça pince monseigneur !"
    elif temperature < 18:
        message = f"{message}. Fait pas chaud quand même."
    elif temperature > 25:
        message = f"{message}. Mettez vous les couilles à l’air si vous voulez pas être stériles."
    elif temperature > 30:
        message = f"{message}. Putain on crève…"

    post_raw(message, chan("maison"))


def mode_bonjour():
    post_raw(":wave:")
    mode_meteo()


def mode_meteo():
    s = requests.Session()
    meteo("Berlin", s)
    meteo("Lille", s)
    meteo("Nantes", s)


if __name__ == "__main__":
    if args.mode == "reboot":
        mode_reboot()
    elif args.mode == "bonjour":
        mode_bonjour()
    elif args.mode == "meteo":
        mode_meteo()
