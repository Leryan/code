# Adapt

You will want to change `BRIGHTNESS_FPATH` and `BRIGHTNESS_INCINT`.

`KEYCODE_BUP` and `KEYCODE_BDOWN` are keycodes for brightness up/down.

# Build and Install

```
make
sudo make install
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
