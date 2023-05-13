#!/bin/bash
# This script uses https://github.com/mcastorina/graph-cli to generate graphs
mkdir -pv graphs
for csv in cleaned_data/*.csv; do
    name=$(basename $csv | cut -d. -f1)
    echo "Generating graph for '$name' (source $csv)"
    ~/.local/bin/graph $csv -o graphs/$name.png
done
