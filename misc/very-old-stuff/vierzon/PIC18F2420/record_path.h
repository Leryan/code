#include <p18Cxxx.h>

static char i_path = 0;

void write_path(char cmd, char *path, char reset);
void read_path(char *path);
char get_path(void);
