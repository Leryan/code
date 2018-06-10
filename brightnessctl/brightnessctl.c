/* Florent Peterschmitt - MIT License - 2016 */
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/Xresource.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BRIGHTNESS_FPATH "/sys/class/backlight/intel_backlight/brightness"
#define BRIGHTNESS_INCINT 100

#define KEYCODE_BUP 233
#define KEYCODE_BDOWN 232

unsigned int change_brightness(int inc) {
    unsigned int cur = 0;
    FILE *f = fopen(BRIGHTNESS_FPATH, "r");
    fscanf(f, "%u", &cur);
    fclose(f);
    f = fopen(BRIGHTNESS_FPATH, "w");
    printf("curb: %d | ", cur);
    if (((int) cur) + inc < 0) {
        cur = 0;
    } else {
        cur = cur + inc;
    }
    printf("cura: %u\n", cur);
    fprintf(f, "%u\n", cur);
    fflush(f);
    fclose(f);
    return cur;
}

int main(int argc, char ** argv){
    XEvent ev;
    Display *dpy;
    Window      root;

    dpy = XOpenDisplay(NULL);
    if (!dpy) {fprintf(stderr, "unable to connect to displayn");return 7;}
    root = DefaultRootWindow(dpy);

    XGrabKey(dpy, KEYCODE_BUP, AnyModifier, root, None, GrabModeAsync, GrabModeAsync);
    XGrabKey(dpy, KEYCODE_BDOWN, AnyModifier, root, None, GrabModeAsync, GrabModeAsync);

    while(1){
        XNextEvent(dpy, &ev);
        switch(ev.type){
            case KeyPress:
                if(ev.xkey.keycode == KEYCODE_BUP) {
                    change_brightness(BRIGHTNESS_INCINT);
                } else if (ev.xkey.keycode == KEYCODE_BDOWN) {
                    change_brightness(-BRIGHTNESS_INCINT);
                }
                break;
        }
    }
}
