#include <stdio.h>
#include <sys/mman.h>

extern void write_zeros();

int main() {
    while ( 1 ) {
        write_zeros();
    }
    return 0;
}
