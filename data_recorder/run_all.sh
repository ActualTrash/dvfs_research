#!/bin/bash
for path in ../experiment/exp_*; do
    name=$(basename $path | cut -d_ -f2-)
    echo "Running $path"
    ./record_data $path data/$name.csv 10000000 | tee data/$name.stats
done
