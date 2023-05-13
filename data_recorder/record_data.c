#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <sys/types.h>
#include <signal.h>
#include <unistd.h>
#include <sys/wait.h>
#include <limits.h>

typedef struct datapoint {
    long time;
    long freq;
} datapoint_t;

#define millis(t) (t.tv_sec * 1000 + t.tv_usec / 1000)
#define micros(t) (t.tv_sec * 1000000 + t.tv_usec)

const long thresholds[] = {1000000, 1200000, 2000000, 2500000, 3000000, 3050000, 3100000, 4000000};
#define N_THRESHOLDS 7 // Should be the length of the above array minus one

long counters[N_THRESHOLDS];


void sleep_millis(int n) {
    struct timespec ts;
    int seconds = n % 1000;
    n /= 1000;
    ts.tv_sec = n;
    ts.tv_nsec = n * 1000 * 1000;
    nanosleep(&ts, NULL);
}

int main(int argc, char** argv) {
    // Parse arguments
    long samples;
    if ( argc == 3 ) {
        samples = 100000; // Default samples to 100k
    } else if ( argc == 4 ) {
        if ( !(samples = atoi(argv[3])) ) {
            printf("Invalid argument. Expected an integer, got '%s'\n", argv[3]);
            return 1;
        }
    } else {
        printf("[-] Usage: %s <experiment binary> <outfile.csv> [samples]\n", argv[0]);
        return 1;
    }

    // Allocate space for the data
    datapoint_t* data = (datapoint_t*) malloc(samples * sizeof(datapoint_t));

    // Warm up the cache
    {
        FILE* f = fopen("/sys/devices/system/cpu/cpu23/cpufreq/scaling_cur_freq", "r");
        char buff[10];
        fgets((char *) &buff, 10, f);
        fclose(f);
    }

    // Zero out the thresholds
    for ( int i = 0; i < N_THRESHOLDS; i++ ) {
        counters[i] = 0;
    }

    // Start the experiment 
    int pid = fork();
    if ( pid == 0 ) {
        execl("/usr/bin/taskset", "taskset", "-c", "23", argv[1], (const char*) NULL);
        printf("error running experiment:\n");
        perror("execl");
        int ppid = getppid();
        kill(ppid, SIGTERM);
        exit(EXIT_FAILURE);
    } else if ( pid < 0 ) {
        perror("fork");
        exit(EXIT_FAILURE);
    }

    int millis = 5000;
    printf("[*] Started experiment. Waiting %d ms for DVFS to kick in.\n", millis);
    sleep_millis(millis);
    printf("[*] Starting monitoring on CPU 23 with %ld samples\n", samples);

    struct timeval start_time;
    gettimeofday(&start_time, NULL);

    for ( int i = 0; i < samples; i++ ) {
        // 1. Get time
        struct timeval t;
        gettimeofday(&t, NULL);
        long time_micros = micros(t) - micros(start_time);

        // 2. Read frequency data
        FILE* f = fopen("/sys/devices/system/cpu/cpu23/cpufreq/scaling_cur_freq", "r");
        char buff[12];
        fgets((char *) &buff, 12, f);
        long freq = atoi(buff);
        data[i] = (datapoint_t) {
            .time = time_micros,
            .freq = freq
        };
        fclose(f);

        // Statistics
        for ( int i = 0; i < N_THRESHOLDS; i++ ) {
            if ( thresholds[i] <= freq && freq < thresholds[i + 1] ) {
                counters[i]++;
                break;
            }
        }
    }


    // Kill the child
    kill(pid, SIGTERM);
    if ( waitpid(pid, NULL, 0) == -1 ) {
        perror("waitpid");
        exit(EXIT_FAILURE);
    }


    {
        struct timeval end_time;
        gettimeofday(&end_time, NULL);
        long time_millis = millis(end_time) - millis(start_time);
        printf("[*] Done recording (%ld ms). Writing data to %s\n", time_millis, argv[2]);
    }

    // Write data to CSV
    FILE* f = fopen(argv[2], "w");
    fprintf(f, "time(us),frequency(Hz)\n");
    for (int i = 0; i < samples; i++) {
        datapoint_t d = data[i];
        fprintf(f, "%ld,%ld\n", d.time, d.freq);
    }
    fclose(f);


    printf("\nStatistics\n");
    printf("==========\n");
    printf("Total number of samples:\t%ld\n", samples);
    printf("Frequency histogram\n");
    printf("  Range\t\t\tCount\tPercent\n");
    for ( int i = N_THRESHOLDS - 1; i + 1; i-- ) {
        double percent = 100.0 * (double) counters[i] / (double) samples;
        printf("  [%ld, %ld)\t%ld\t(%.2f%%)\n", thresholds[i], thresholds[i + 1], counters[i], percent);
    }
    printf("\n");


    free(data);
    return 0;
}
