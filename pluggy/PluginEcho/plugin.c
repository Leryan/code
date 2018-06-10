#include <stdio.h>
#include <libplugin/context.h>
#include "plugin.h"

void _run(context_t *ctx) {
    printf("%s\n", ctx->message);
}