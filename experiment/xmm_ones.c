#include <stdio.h>
#include <sys/mman.h>

#define TRIALS 10000

extern void xmm_write_ones();

int main() {
    while ( 1 ) {
        xmm_write_ones();
    }
    return 0;
}
