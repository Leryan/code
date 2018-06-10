#ifndef PLUGIN_H
#define PLUGIN_H

/*
 * A plugin is a library with one entry function and a name:
 * 
 *      char _name[] = "echo";
 * 
 *      void _run(void) {
 *          ...
 *      }
 */

#ifdef __cplusplus
extern "C" {
#endif

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <string.h>
#include <stdint.h>

#include <libplugin/context.h>

    // Build with C99 only.
    extern char *strdup(const char *s);

#define PLUGIN_FNSFX "_run"
#define PLUGIN_NAME "_name"

#define PLUGIN_NOERR 0
#define PLUGIN_ERDLOPEN 1
#define PLUGIN_ERSYM_NAME 2
#define PLUGIN_ERNMM 3
#define PLUGIN_ERSYM_RUN 4

#define PLUGIN_S_ERRMSG 1024
#define PLUGIN_VN_ERRMSG plugin_error_msg

#define PLUGIN_C_ERRMSG char *PLUGIN_VN_ERRMSG = calloc(PLUGIN_S_ERRMSG, sizeof(char *))
#define PLUGIN_FORMAT_ERRMSG(format, ...) snprintf(PLUGIN_VN_ERRMSG, PLUGIN_S_ERRMSG, format, __VA_ARGS__)
#define PLUGIN_REG_ERR(plugin, error_code) plugin_reg_err(plugin, PLUGIN_VN_ERRMSG, error_code); free(PLUGIN_VN_ERRMSG)

    typedef struct plugins {
        char *name;
        char *path;
        void *handle;
        void (*fnrun)(context_t *ctx);
        int load_err;
        char *load_err_msg;
    } plugin_t;

    void plugin_reg_err(plugin_t * const plugin, const char * const error_msg, int error_code);
    int plugin_has_error(const plugin_t * const plugin);
    int plugin_load_many(plugin_t ** plugins);
    int plugin_load(plugin_t * const plugin);
    plugin_t *plugin_create(char *name, char *path);
    void plugin_unload(plugin_t *plugin);


#ifdef __cplusplus
}
#endif

#endif /* PLUGIN_H */

