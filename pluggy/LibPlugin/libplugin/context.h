#ifndef CONTEXT_H
#define CONTEXT_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h>

    typedef struct context {
        char *message;
    } context_t;

    void context_init(context_t * ctx);
    void context_free(context_t *ctx);

#ifdef __cplusplus
}
#endif

#endif /* CONTEXT_H */

