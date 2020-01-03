#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <time.h>

double get_time() {
    /*
    struct timeval t;
    gettimeofday(&t, NULL);
    return t.tv_sec + t.tv_usec*1e-6;
    */
    return clock();
}

typedef struct Vec3D {
    int64_t x;
    int64_t y;
    int64_t z;
} Vec3D;

typedef struct SOA {
    uint64_t s;
    int64_t *x;
    int64_t *y;
    int64_t *z;
} SOA;

void soa_translate(SOA soa, Vec3D vec) {
#define INC 4
#define INCM INC-1
#define SOA(field, offset) soa.field[i+offset] += vec.field;
    uint64_t max = soa.s + INCM;

    for (uint64_t i = 0; i < max; i += INC) {
        SOA(x, 0)
        SOA(x, 1)
        SOA(x, 2)
        SOA(x, 3)
    }
    for (uint64_t i = 0; i < max; i += INC) {
        SOA(y, 0)
        SOA(y, 1)
        SOA(y, 2)
        SOA(y, 3)
    }
    for (uint64_t i = 0; i < max; i += INC) {
        SOA(z, 0)
        SOA(z, 1)
        SOA(z, 2)
        SOA(z, 3)
    }
}

#define ELEMS 100000
#define LOOPS 15000

int main(void) {
    int64_t *soa_x = calloc(ELEMS, sizeof(int64_t));
    int64_t *soa_y = calloc(ELEMS, sizeof(int64_t));
    int64_t *soa_z = calloc(ELEMS, sizeof(int64_t));
    SOA soa = {ELEMS, soa_x, soa_y, soa_z};
    Vec3D translate = {-1, 2, 8};

    double times = 0.0;
    int counted = 0;

    for (int runs = 0; runs < 10; runs++) {
        for (int i = 0; i < LOOPS; i++) {
            double ts = get_time();
            soa_translate(soa, translate);
            times += (double)(get_time() - ts) / CLOCKS_PER_SEC;
        }
        if (runs < 5) {
           times = 0.0;
        } else {
            counted++;
        }
        printf("loop %d: %ld %ld %ld\n", runs, soa_x[10], soa_y[10], soa_z[10]);
    }
    printf("%f\n", times / (double)(LOOPS * counted));
}
