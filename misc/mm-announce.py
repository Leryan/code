#!/usr/bin/env python3

import argparse
import datetime
import glob
import os
import time
import traceback
import uuid

import requests

#### VENDORING
######### https://github.com/chubin/wttr.in/blob/master/lib/constants.py
# vim: fileencoding=utf-8

WWO_CODE = {
    "113": "Sunny",
    "116": "PartlyCloudy",
    "119": "Cloudy",
    "122": "VeryCloudy",
    "143": "Fog",
    "176": "LightShowers",
    "179": "LightSleetShowers",
    "182": "LightSleet",
    "185": "LightSleet",
    "200": "ThunderyShowers",
    "227": "LightSnow",
    "230": "HeavySnow",
    "248": "Fog",
    "260": "Fog",
    "263": "LightShowers",
    "266": "LightRain",
    "281": "LightSleet",
    "284": "LightSleet",
    "293": "LightRain",
    "296": "LightRain",
    "299": "HeavyShowers",
    "302": "HeavyRain",
    "305": "HeavyShowers",
    "308": "HeavyRain",
    "311": "LightSleet",
    "314": "LightSleet",
    "317": "LightSleet",
    "320": "LightSnow",
    "323": "LightSnowShowers",
    "326": "LightSnowShowers",
    "329": "HeavySnow",
    "332": "HeavySnow",
    "335": "HeavySnowShowers",
    "338": "HeavySnow",
    "350": "LightSleet",
    "353": "LightShowers",
    "356": "HeavyShowers",
    "359": "HeavyRain",
    "362": "LightSleetShowers",
    "365": "LightSleetShowers",
    "368": "LightSnowShowers",
    "371": "HeavySnowShowers",
    "374": "LightSleetShowers",
    "377": "LightSleet",
    "386": "ThunderyShowers",
    "389": "ThunderyHeavyRain",
    "392": "ThunderySnowShowers",
    "395": "HeavySnowShowers",
}

WEATHER_SYMBOL = {
    "Unknown": "✨",
    "Cloudy": "☁️",
    "Fog": "🌫",
    "HeavyRain": "🌧",
    "HeavyShowers": "🌧",
    "HeavySnow": "❄️",
    "HeavySnowShowers": "❄️",
    "LightRain": "🌦",
    "LightShowers": "🌦",
    "LightSleet": "🌧",
    "LightSleetShowers": "🌧",
    "LightSnow": "🌨",
    "LightSnowShowers": "🌨",
    "PartlyCloudy": "⛅️",
    "Sunny": "☀️",
    "ThunderyHeavyRain": "🌩",
    "ThunderyShowers": "⛈",
    "ThunderySnowShowers": "⛈",
    "VeryCloudy": "☁️",
}

WEATHER_SYMBOL_WIDTH_VTE = {
    "✨": 2,
    "☁️": 1,
    "🌫": 1,
    "🌧": 2,
    "🌧": 2,
    "❄️": 1,
    "❄️": 1,
    "🌦": 1,
    "🌦": 1,
    "🌧": 1,
    "🌧": 1,
    "🌨": 2,
    "🌨": 2,
    "⛅️": 2,
    "☀️": 1,
    "🌩": 2,
    "⛈": 1,
    "⛈": 1,
    "☁️": 1,
}

WIND_DIRECTION = [
    "↓",
    "↙",
    "←",
    "↖",
    "↑",
    "↗",
    "→",
    "↘",
]

MOON_PHASES = ("🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘")

WEATHER_SYMBOL_WEGO = {
    "Unknown": [
        "    .-.      ",
        "     __)     ",
        "    (        ",
        "     `-’     ",
        "      •      ",
    ],
    "Sunny": [
        "\033[38;5;226m    \\   /    \033[0m",
        "\033[38;5;226m     .-.     \033[0m",
        "\033[38;5;226m  ― (   ) ―  \033[0m",
        "\033[38;5;226m     `-’     \033[0m",
        "\033[38;5;226m    /   \\    \033[0m",
    ],
    "PartlyCloudy": [
        "\033[38;5;226m   \\  /\033[0m      ",
        '\033[38;5;226m _ /""\033[38;5;250m.-.    \033[0m',
        "\033[38;5;226m   \\_\033[38;5;250m(   ).  \033[0m",
        "\033[38;5;226m   /\033[38;5;250m(___(__) \033[0m",
        "             ",
    ],
    "Cloudy": [
        "             ",
        "\033[38;5;250m     .--.    \033[0m",
        "\033[38;5;250m  .-(    ).  \033[0m",
        "\033[38;5;250m (___.__)__) \033[0m",
        "             ",
    ],
    "VeryCloudy": [
        "             ",
        "\033[38;5;240;1m     .--.    \033[0m",
        "\033[38;5;240;1m  .-(    ).  \033[0m",
        "\033[38;5;240;1m (___.__)__) \033[0m",
        "             ",
    ],
    "LightShowers": [
        '\033[38;5;226m _`/""\033[38;5;250m.-.    \033[0m',
        "\033[38;5;226m  ,\\_\033[38;5;250m(   ).  \033[0m",
        "\033[38;5;226m   /\033[38;5;250m(___(__) \033[0m",
        "\033[38;5;111m     ‘ ‘ ‘ ‘ \033[0m",
        "\033[38;5;111m    ‘ ‘ ‘ ‘  \033[0m",
    ],
    "HeavyShowers": [
        '\033[38;5;226m _`/""\033[38;5;240;1m.-.    \033[0m',
        "\033[38;5;226m  ,\\_\033[38;5;240;1m(   ).  \033[0m",
        "\033[38;5;226m   /\033[38;5;240;1m(___(__) \033[0m",
        "\033[38;5;21;1m   ‚‘‚‘‚‘‚‘  \033[0m",
        "\033[38;5;21;1m   ‚’‚’‚’‚’  \033[0m",
    ],
    "LightSnowShowers": [
        '\033[38;5;226m _`/""\033[38;5;250m.-.    \033[0m',
        "\033[38;5;226m  ,\\_\033[38;5;250m(   ).  \033[0m",
        "\033[38;5;226m   /\033[38;5;250m(___(__) \033[0m",
        "\033[38;5;255m     *  *  * \033[0m",
        "\033[38;5;255m    *  *  *  \033[0m",
    ],
    "HeavySnowShowers": [
        '\033[38;5;226m _`/""\033[38;5;240;1m.-.    \033[0m',
        "\033[38;5;226m  ,\\_\033[38;5;240;1m(   ).  \033[0m",
        "\033[38;5;226m   /\033[38;5;240;1m(___(__) \033[0m",
        "\033[38;5;255;1m    * * * *  \033[0m",
        "\033[38;5;255;1m   * * * *   \033[0m",
    ],
    "LightSleetShowers": [
        '\033[38;5;226m _`/""\033[38;5;250m.-.    \033[0m',
        "\033[38;5;226m  ,\\_\033[38;5;250m(   ).  \033[0m",
        "\033[38;5;226m   /\033[38;5;250m(___(__) \033[0m",
        "\033[38;5;111m     ‘ \033[38;5;255m*\033[38;5;111m ‘ \033[38;5;255m* \033[0m",
        "\033[38;5;255m    *\033[38;5;111m ‘ \033[38;5;255m*\033[38;5;111m ‘  \033[0m",
    ],
    "ThunderyShowers": [
        '\033[38;5;226m _`/""\033[38;5;250m.-.    \033[0m',
        "\033[38;5;226m  ,\\_\033[38;5;250m(   ).  \033[0m",
        "\033[38;5;226m   /\033[38;5;250m(___(__) \033[0m",
        "\033[38;5;228;5m    ⚡\033[38;5;111;25m‘‘\033[38;5;228;5m⚡\033[38;5;111;25m‘‘ \033[0m",
        "\033[38;5;111m    ‘ ‘ ‘ ‘  \033[0m",
    ],
    "ThunderyHeavyRain": [
        "\033[38;5;240;1m     .-.     \033[0m",
        "\033[38;5;240;1m    (   ).   \033[0m",
        "\033[38;5;240;1m   (___(__)  \033[0m",
        "\033[38;5;21;1m  ‚‘\033[38;5;228;5m⚡\033[38;5;21;25m‘‚\033[38;5;228;5m⚡\033[38;5;21;25m‚‘ \033[0m",
        "\033[38;5;21;1m  ‚’‚’\033[38;5;228;5m⚡\033[38;5;21;25m’‚’  \033[0m",
    ],
    "ThunderySnowShowers": [
        '\033[38;5;226m _`/""\033[38;5;250m.-.    \033[0m',
        "\033[38;5;226m  ,\\_\033[38;5;250m(   ).  \033[0m",
        "\033[38;5;226m   /\033[38;5;250m(___(__) \033[0m",
        "\033[38;5;255m     *\033[38;5;228;5m⚡\033[38;5;255;25m*\033[38;5;228;5m⚡\033[38;5;255;25m* \033[0m",
        "\033[38;5;255m    *  *  *  \033[0m",
    ],
    "LightRain": [
        "\033[38;5;250m     .-.     \033[0m",
        "\033[38;5;250m    (   ).   \033[0m",
        "\033[38;5;250m   (___(__)  \033[0m",
        "\033[38;5;111m    ‘ ‘ ‘ ‘  \033[0m",
        "\033[38;5;111m   ‘ ‘ ‘ ‘   \033[0m",
    ],
    "HeavyRain": [
        "\033[38;5;240;1m     .-.     \033[0m",
        "\033[38;5;240;1m    (   ).   \033[0m",
        "\033[38;5;240;1m   (___(__)  \033[0m",
        "\033[38;5;21;1m  ‚‘‚‘‚‘‚‘   \033[0m",
        "\033[38;5;21;1m  ‚’‚’‚’‚’   \033[0m",
    ],
    "LightSnow": [
        "\033[38;5;250m     .-.     \033[0m",
        "\033[38;5;250m    (   ).   \033[0m",
        "\033[38;5;250m   (___(__)  \033[0m",
        "\033[38;5;255m    *  *  *  \033[0m",
        "\033[38;5;255m   *  *  *   \033[0m",
    ],
    "HeavySnow": [
        "\033[38;5;240;1m     .-.     \033[0m",
        "\033[38;5;240;1m    (   ).   \033[0m",
        "\033[38;5;240;1m   (___(__)  \033[0m",
        "\033[38;5;255;1m   * * * *   \033[0m",
        "\033[38;5;255;1m  * * * *    \033[0m",
    ],
    "LightSleet": [
        "\033[38;5;250m     .-.     \033[0m",
        "\033[38;5;250m    (   ).   \033[0m",
        "\033[38;5;250m   (___(__)  \033[0m",
        "\033[38;5;111m    ‘ \033[38;5;255m*\033[38;5;111m ‘ \033[38;5;255m*  \033[0m",
        "\033[38;5;255m   *\033[38;5;111m ‘ \033[38;5;255m*\033[38;5;111m ‘   \033[0m",
    ],
    "Fog": [
        "             ",
        "\033[38;5;251m _ - _ - _ - \033[0m",
        "\033[38;5;251m  _ - _ - _  \033[0m",
        "\033[38;5;251m _ - _ - _ - \033[0m",
        "             ",
    ],
}

LOCALE = {
    "af": "af_ZA",
    "ar": "ar_TN",
    "az": "az_AZ",
    "be": "be_BY",
    "bg": "bg_BG",
    "bs": "bs_BA",
    "ca": "ca_ES",
    "cs": "cs_CZ",
    "cy": "cy_GB",
    "da": "da_DK",
    "de": "de_DE",
    "el": "el_GR",
    "eo": "eo",
    "es": "es_ES",
    "et": "et_EE",
    "fa": "fa_IR",
    "fi": "fi_FI",
    "fr": "fr_FR",
    "fy": "fy_NL",
    "ga": "ga_IE",
    "he": "he_IL",
    "hr": "hr_HR",
    "hu": "hu_HU",
    "hy": "hy_AM",
    "id": "id_ID",
    "is": "is_IS",
    "it": "it_IT",
    "ja": "ja_JP",
    "jv": "en_US",
    "ka": "ka_GE",
    "ko": "ko_KR",
    "kk": "kk_KZ",
    "ky": "ky_KG",
    "lt": "lt_LT",
    "lv": "lv_LV",
    "mk": "mk_MK",
    "ml": "ml_IN",
    "nb": "nb_NO",
    "nl": "nl_NL",
    "nn": "nn_NO",
    "pt": "pt_PT",
    "pt-br": "pt_BR",
    "pl": "pl_PL",
    "ro": "ro_RO",
    "ru": "ru_RU",
    "sv": "sv_SE",
    "sk": "sk_SK",
    "sl": "sl_SI",
    "sr": "sr_RS",
    "sr-lat": "sr_RS@latin",
    "sw": "sw_KE",
    "th": "th_TH",
    "tr": "tr_TR",
    "uk": "uk_UA",
    "uz": "uz_UZ",
    "vi": "vi_VN",
    "zh": "zh_TW",
    "zu": "zu_ZA",
}

#### END OF VENDORING

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
    weatherCode = res["current_condition"][0]["weatherCode"]

    message = f" * {ville} : {temperature}° {WEATHER_SYMBOL[WWO_CODE[weatherCode]]}"

    if temperature < 15 and weatherCode == "113":
        message = f"{message}. J’trouve qu’il fait beau, mais encore frais. Mais beau ! :perceval:"
    elif temperature < 5:
        message = f"{message}. Ça pince monseigneur !"
    elif temperature < 11:
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
