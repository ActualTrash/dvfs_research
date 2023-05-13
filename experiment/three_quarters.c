#include <stdio.h>
#include <sys/mman.h>

extern void write_value();

int main() {
    long value[] = {0, -1, -1, -1};
    while ( 1 ) {
        write_value(value);
    }
    return 0;
}
