#include <dlfcn.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define RCFS_ENVVAR "RCFS_NFILE"
#define RCFS_PROTECT_DEFAULT "/etc/resolv.conf"
#define RCFS_NFILE_DEFAULT "/etc/resolv.conf.rcfs-override"

static int (*real_open)(char *filename, int access, int permission) = NULL;

static FILE *(*real_fopen)(const char *filename, const char *mode) = NULL;

FILE *fopen(const char *filename, const char *mode) {
    char *new_filename = getenv(RCFS_ENVVAR);

    if (new_filename == NULL) {
        new_filename = RCFS_NFILE_DEFAULT;
    }

    real_fopen = dlsym(RTLD_NEXT, "fopen");

    if (strcmp(filename, RCFS_PROTECT_DEFAULT) == 0) {
        return real_fopen(new_filename, mode);
    }
    return real_fopen(filename, mode);
}

int open(char *filename, int access, int permission) {
    char *new_filename = getenv(RCFS_ENVVAR);

    if (new_filename == NULL) {
        new_filename = RCFS_NFILE_DEFAULT;
    }

    real_open = dlsym(RTLD_NEXT, "open");

    if (strcmp(filename, RCFS_PROTECT_DEFAULT) == 0) {
        return real_open(new_filename, access, permission);
    }
    return real_open(filename, access, permission);
}
