#include <stdio.h>
#include <sys/mman.h>

extern void write_ones();

int main() {
    while ( 1 ) {
        write_ones();
    }
    return 0;
}
