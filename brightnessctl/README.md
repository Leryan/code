# Adapt

You will want to change `BRIGHTNESS_FPATH` and `BRIGHTNESS_INCINT`.

`KEYCODE_BUP` and `KEYCODE_BDOWN` are keycodes for brightness up/down.

# Build

```
gcc -O2 -Wall -lX11 -std=c99 -o brightnessctl brightnessctl.c
```

# Install

```
mv brightnessctl /usr/local/bin/
chown root:root /usr/local/bin/brightnessctl
chmod u+s /usr/local/bin/brightnessctl
```

# Use

In you `.xinitrc` or some startup script:

```
/usr/local/bin/brightnessctl &
```

# TODO

 * Detect `XF86BrightnessUp/Down` keys.
 * Detect backlight brightness control file or use another control interface.
 * Daemonize.
