#!/usr/bin/env python3

import argparse
import datetime
import glob
import os
import time
import traceback
import uuid

import requests

parser = argparse.ArgumentParser()
parser.add_argument("--dry-run", action="store_true")
parser.add_argument("--bearer", required=True, type=str, help="personnal access token")
parser.add_argument(
    "--apiurl", required=True, type=str, help="https://your.mattermost.domain/api/v4"
)
parser.add_argument("--retry", default=10, type=int)
parser.add_argument("--chan", default="", type=str)
parser.add_argument("--mode", default="reboot", type=str)
parser.add_argument("--id", type=str, default="")
parser.add_argument(
    "--annivs", type=str, default="mm-announce-annivs", help="fichier des annivs"
)

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
        return '"' + self.text + '"'


def headers():
    return {
        "Authorization": "Bearer " + args.bearer,
    }


class OK(Exception):
    pass


class KO(Exception):
    pass


def check_reboot():
    reboot_required = len(glob.glob("/var/run/reboot-required*")) > 0 or args.dry_run
    announced = len(glob.glob(announced_file)) > 0

    if announced:
        if reboot_required:
            return "annonce déjà postée"
        os.unlink(announced_file)

    if not reboot_required:
        return "rien à faire"

    message = (
        "@all Le serveur va redémarrer cette nuit pour appliquer des patchs de sécurité"
    )

    r = post(message, chan("maison"))

    if not r.ok:
        raise KO(r.text)

    with open(announced_file, "w") as f:
        f.write("annonce de reboot postée")

    return "annonce postée"


def ping(message: str):
    message = "ping: " + message
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

    print(check_reboot())


def meteo(ville: str, s):
    res = s.get(f"https://wttr.in/{ville}?format=j1&0").json()

    temperature = int(res["current_condition"][0]["temp_C"])
    weatherCode = int(res["current_condition"][0]["weatherCode"])

    pic = s.get(f"https://wttr.in/{ville}?format=%c+%t").text.strip()
    message = f" * {ville} : {pic}"

    if temperature < 15 and weatherCode == 113:
        message = f"{message}. J’trouve qu’il fait beau, mais encore frais. Mais beau ! :perceval:"
    elif temperature < 8:
        message = f"{message}. Ça pince monseigneur !"
    elif temperature < 18:
        message = f"{message}. Fait pas chaud quand même."
    elif temperature > 25:
        message = f"{message}. Mettez vous les couilles à l’air si vous voulez pas être stériles."
    elif temperature > 30:
        message = f"{message}. Putain on crève…"

    return message


def mode_anniv():
    annivs = []
    auj = datetime.datetime.now()
    with open(args.annivs, "r") as f:
        lines = f.readlines()
        for line in lines:
            name, anniv = line.split(" ", 1)
            jour, mois, annee = list(map(int, anniv.split("/", 2)))

            print(name, jour, mois, annee)

            if auj.month == mois and auj.day == jour:
                annivs.append([name, auj.year - annee])

    if len(annivs) == 0:
        return

    if len(annivs) == 1:
        message = f"Aujourd’hui {annivs[0][0]} a {annivs[0][1]} ans ! Bon anniversaaaaaaiiiiiiireuuuuu !"

    else:
        message = "C'est l'anniversaire dans tous les recoins, c'est presque tous les ans qu'on a l'anniversaire. Grâce à cet anni... c'est la joie c'est pratique, c'est au moins un principe à retenir pour faire la frite... c'est huuuum lalalalala. Cette année c'est bien, l'anniversaire tombe à pic !\n"

        for anni in annivs:
            message += f"{anni[0]} a {anni[1]} ans !\n"

        message += "\nBon anniversaiiiiiiireuuuuu !"

    post_raw(message, chan("maison"))


def mode_bonjour():
    post_raw(":wave:", chan("maison"))
    mode_meteo()


def mode_fail():
    raise Exception("failing here")


def mode_meteo():
    s = requests.Session()
    m = ["Mééééétééoooooooooooo :"]
    m.append(meteo("Berlin", s))
    m.append(meteo("Lille", s))
    m.append(meteo("Nantes", s))

    post_raw("\n".join(m), chan("maison"))


def main_commands():
    if args.mode == "reboot":
        mode_reboot()
    elif args.mode == "bonjour":
        mode_bonjour()
    elif args.mode == "meteo":
        mode_meteo()
    elif args.mode == "anniv":
        mode_anniv()
    elif args.mode == "fail":
        mode_fail()
    else:
        raise Exception("je connais pas ce mode là… " + args.mode)


def ret(cur, max_, wait):
    if cur >= max_:
        return "@flop"
    return f"{cur}/{max_} (wait {wait}s)"


def main():
    retries = 3
    for retry in range(retries):
        wait = args.retry * (retry + 1)
        retval = ret(retry + 1, retries, wait)
        try:
            main_commands()
        except KO as e:
            ping(f"{retval} **KO: ** {args.mode} -> `{e}`")
            ping(f"traceback:\n```\n{traceback.format_exc()}```\n")
        except Exception as e:
            ping(f"{retval} **UNEXPECTED KO: ** {args.mode} -> `{e}`")
            ping(f"traceback:\n```\n{traceback.format_exc()}```\n")
        else:
            ping(f"**ok: ** {args.mode}")
            return

        time.sleep(wait)


if __name__ == "__main__":
    main()
