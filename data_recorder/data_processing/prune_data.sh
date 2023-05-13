#!/bin/bash
# Remove adjacent datapoints with the same frequency value
for f in data/*.csv; do
    echo "Pruning $f"
    awk -F, '$2 != name{ print }{ name = $2 }' $f > pruned_data/$(basename $f).csv
done
