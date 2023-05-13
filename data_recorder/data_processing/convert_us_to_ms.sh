#!/bin/bash
# Convert the data from microseconds to milliseconds
# --> Divide the first column of every row (except the first) by 1000, then concatenate it with the new header
mkdir -pv cleaned_data
for f in pruned_data/*.csv; do
    tail +2 $f | awk -F, '{print int($1/1000) "," $2}' | cat data_processing/ms_header - > cleaned_data/$(basename $f)
done
