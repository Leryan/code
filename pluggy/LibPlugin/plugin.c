#include "libplugin/plugin.h"

plugin_t *plugin_create(char *name, char *path) {
    plugin_t *plugin = calloc(1, sizeof(plugin_t));

    plugin->name = strdup(name);
    plugin->path = strdup(path);

    return plugin;
}

void plugin_unload(plugin_t *plugin) {
    if (plugin != NULL) {
        if (plugin->name != NULL) {
            free(plugin->name);
        }
        if (plugin->path != NULL) {
            free(plugin->path);
        }
        if (plugin->load_err_msg != NULL) {
            free(plugin->load_err_msg);
        }
        if (plugin->handle != NULL) {
            dlclose(plugin->handle);
        }
    }
}

void plugin_reg_err(plugin_t * const plugin, const char * const error_msg, int error_code) {
    plugin->load_err = error_code;
    if (plugin->load_err_msg != NULL) {
        free(plugin->load_err_msg);
    }
    plugin->load_err_msg = strdup(error_msg);
}

int plugin_load_many(plugin_t **plugins) {
    unsigned int i = 0;

    if (plugins == NULL) {
        return -1;
    }

    for (i = 0; plugins[i] != NULL; ++i) {
        plugin_load(plugins[i]);
    }

    return 0;
}

int plugin_has_error(const plugin_t * const plugin) {
    if (plugin != NULL) {
        if (plugin->load_err != PLUGIN_NOERR) {
            return 1;
        }
    } else {
        return -1;
    }
    return 0;
}

int plugin_load(plugin_t * const plugin) {
    char *load_name = NULL;
    char *error = NULL;
    PLUGIN_C_ERRMSG;

    if (plugin == NULL) {
        return -1;
    }

    if (plugin->handle == NULL) {
        plugin->handle = dlopen(plugin->path, RTLD_NOW);
        if ((error = dlerror()) != NULL) {
            PLUGIN_FORMAT_ERRMSG("dlerror: %s", error);
            PLUGIN_REG_ERR(plugin, PLUGIN_ERDLOPEN);
            return 1;
        }

        load_name = dlsym(plugin->handle, PLUGIN_NAME);
        if ((error = dlerror()) != NULL) {
            PLUGIN_FORMAT_ERRMSG("dlerror: %s", error);
            PLUGIN_REG_ERR(plugin, PLUGIN_ERSYM_NAME);
            return 1;
        }

        if (strcmp(load_name, plugin->name) != 0) {
            PLUGIN_FORMAT_ERRMSG("Plugin name mismatch: got: '%s' wants: '%s'", load_name, plugin->name);
            PLUGIN_REG_ERR(plugin, PLUGIN_ERNMM);
            return 1;
        }

        plugin->fnrun = dlsym(plugin->handle, PLUGIN_FNSFX);
        if ((error = dlerror()) != NULL) {
            PLUGIN_FORMAT_ERRMSG("dlerror: %s", error);
            PLUGIN_REG_ERR(plugin, PLUGIN_ERSYM_RUN);
            return 1;
        }
    } else {
        return 2;
    }

    return 0;
}
