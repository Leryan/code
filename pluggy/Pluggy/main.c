#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

#include <libplugin/plugin.h>
#include <libplugin/context.h>

#include "config.h"

void check_plugins(plugin_t **plugins) {
    unsigned int i = 0;
    plugin_t *local_plugin;

    for (i = 0; (local_plugin = plugins[i]) && local_plugin->name != NULL; ++i) {
        if (plugin_has_error(local_plugin)) {
            fprintf(stderr, "PluginError: load: %s\n", local_plugin->load_err_msg);
        }
    }
}

void on_rec_event(plugin_t **plugins, context_t *ctx) {
    unsigned int i = 0;
    plugin_t *local_plugin;

    for (i = 0; (local_plugin = plugins[i]) && local_plugin->name != NULL; ++i) {
        if (plugin_has_error(local_plugin)) {
            continue;
        } else {
            local_plugin->fnrun(ctx);
        }
    }
}

int main(int argc, char** argv) {
    // We must dynamically allocate memory since we want to use
    // the context from our plugins.
    context_t *ctx = malloc(sizeof(context_t));
    unsigned int i;
    plugin_t **plugins = NULL;
#ifdef PLUGGY_PLUGINS_STATIC
    plugin_t p0 = {"echo", "PluginEcho/libPluginEcho.so", NULL, NULL, PLUGIN_NOERR, NULL};
    plugin_t p1 = {"write", "PluginWrite/libPluginWrite.so", NULL, NULL, PLUGIN_NOERR, NULL};
    plugin_t p2 = {"delete", "PluginDelete/libPluginDelete.so", NULL, NULL, PLUGIN_NOERR, NULL};
    plugin_t *plugins_static[] = {&p0, &p1, &p2, NULL};

    plugins = plugins_static;
#else
    plugins = calloc(4, sizeof(plugin_t *));

    plugins[0] = plugin_create("echo", "PluginEcho/libPluginEcho.so");
    plugins[1] = plugin_create("write", "PluginWrite/libPluginWrite.so");
    plugins[2] = plugin_create("delete", "PluginDelete/libPluginDelete.so");
    plugins[3] = NULL;
#endif

    ctx->message = strdup("coucou");
    context_init(ctx);
    plugin_load_many(plugins);
    check_plugins(plugins);
    on_rec_event(plugins, ctx);

#ifndef PLUGGY_PLUGINS_STATIC
    for(i = 0; plugins[i] != NULL; ++i) {
        plugin_unload(plugins[i]);
        free(plugins[i]);
    }
    free(plugins);
#endif

    context_free(ctx);
    free(ctx);

    return (EXIT_SUCCESS);
}

