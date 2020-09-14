CC 		?= clang
RM		= rm -f
CFLAGS 	+= -W -Wall -Wextra -O2 -s -std=c99 -I/usr/local/include -L/usr/local/lib -I/${HOME}/.local/include -L/${HOME}/.local/lib

EXEC	= animation \
		  passgen \
		  fibofail \
		  iloveyou \
		  kandr \
		  rotate3 \
		  zidentify \
		  bin_rot \
		  syracuse

all: $(EXEC)

curses: curses.c
	$(CC) $(CFLAGS) $^ -o $@ -lncursesw
sdl: sdl.c
	$(CC) $(CFLAGS) $^ -o $@ -lpthread -lSDL
animation: animation.c
	$(CC) $(CFLAGS) -I./ -I./libpfbazar -L./libpfbazar $^ -o $@ -lpfbazar; exit 0

%.o : %.c
	$(CC) $(CFLAGS) $^ -o $@

clean:
	$(RM) *.o
	$(RM) *~
	$(RM) $(EXEC)
