#include <string.h>

#include "libplugin/context.h"

void context_init(context_t *ctx) {
}

void context_free(context_t *ctx) {
    if (ctx == NULL) {
        return;
    }
    if (ctx->message != NULL) {
        free(ctx->message);
    }
}