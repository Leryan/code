build:
	gcc -O2 -Wall -lX11 -std=c99 -o brightnessctl brightnessctl.c

install:
	cp brightnessctl /usr/local/bin/
	chown root:root /usr/local/bin/brightnessctl
	chmod u+s,o+x /usr/local/bin/brightnessctl
