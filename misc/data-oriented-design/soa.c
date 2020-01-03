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

void soa_translate_fetchone(SOA soa, Vec3D vec) {
#define SOA_o(field) soa.field[i] += vec.field;
    uint64_t max = soa.s;

    for (uint64_t i = 0; i < max; ++i) {
        SOA_o(x)
    }
    for (uint64_t i = 0; i < max; ++i) {
        SOA_o(y)
    }
    for (uint64_t i = 0; i < max; ++i) {
        SOA_o(z)
    }
}

void soa_translate(SOA soa, Vec3D vec) {
#define INC 4
#define INCM INC-1
#define SOA_m(field, offset) soa.field[i+offset] += vec.field;
    uint64_t max = soa.s + INCM; // 100% guaranteed *with* buffer overflow.

    for (uint64_t i = 0; i < max; i += INC) {
        SOA_m(x, 0)
        SOA_m(x, 1)
        SOA_m(x, 2)
        SOA_m(x, 3)
    }
    for (uint64_t i = 0; i < max; i += INC) {
        SOA_m(y, 0)
        SOA_m(y, 1)
        SOA_m(y, 2)
        SOA_m(y, 3)
    }
    for (uint64_t i = 0; i < max; i += INC) {
        SOA_m(z, 0)
        SOA_m(z, 1)
        SOA_m(z, 2)
        SOA_m(z, 3)
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

    double times_m = 0.0;
    double times_s = 0.0;
    int runs = 0;

    for (runs = 0; runs < 5; runs++) {
        for (int i = 0; i < LOOPS; i++) {
            double ts = get_time();
            soa_translate_fetchone(soa, translate);
            times_s += (double)(get_time() - ts) / CLOCKS_PER_SEC;
            //
            ts = get_time();
            soa_translate(soa, translate);
            times_m += (double)(get_time() - ts) / CLOCKS_PER_SEC;
        }
        printf("loop %d: %ld %ld %ld\n", runs, soa_x[10], soa_y[10], soa_z[10]);
    }
    printf("fetch one  : %f\n", times_s / (double)(LOOPS * runs));
    printf("fetch multi: %f\n", times_m / (double)(LOOPS * runs));
}
