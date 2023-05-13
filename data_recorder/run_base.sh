#!/bin/bash
./record_data ../experiment/exp_zeros data/no_dvfs_zeros.csv 10000000 | tee data/no_dvfs_zeros.stats
./record_data ../experiment/exp_ones data/no_dvfs_ones.csv 10000000 | tee data/no_dvfs_ones.stats
