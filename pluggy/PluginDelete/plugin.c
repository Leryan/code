#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libplugin/context.h>
#include "plugin.h"

void _run(context_t *ctx) {
    if(ctx != NULL) {
        if(ctx->message != NULL) {
            memset(ctx->message, '\0', strlen(ctx->message));
            printf("Message has been deleted: %s\n", ctx->message);
        } else {
            printf("Message already empty.\n");
        }
    } else {
        printf("Received empty context.\n");
    }
}