# DVFS Research

This repository contains useful scripts and programs used to gather data for our project for UVA's CS 6501/4501: Hardware Security taught by Ashish Venkat (Spring 2023). Our group is comprised of Edward Lue, Ratik Mathur, and myself.

## What is in this repo

The program we used to record data is in `data_recorder/`. The experiment code is in `experiments`. There are several scripts in `data_recorder/data_processing` that we used to convert data and produce graphs.

## Commands we found useful while doing this research

#### Run a program on a particular core:
`taskset -c <comma deliminated list of cores> <program>`

Example: `taskset -c 22,23 ./a.out`

#### Get possible core frequency boundaries
Get lowest possible freq for core 23: `cat /sys/devices/system/cpu/cpu23/cpufreq/cpuinfo_min_freq`

Get highest possible freq for core 23: `cat /sys/devices/system/cpu/cpu23/cpufreq/cpuinfo_max_freq`

#### Get current core frequency scaling boundaries
min for core 23: `cat /sys/devices/system/cpu/cpu23/cpufreq/cpuinfo_min_freq`

max for core 23: `cat /sys/devices/system/cpu/cpu23/cpufreq/cpuinfo_max_freq`

#### Change core frequency scaling boundary
`echo <freq> > /sys/devices/system/cpu/cpu<core id>/cpufreq/scaling_(min|max)_freq`

Example: `echo 1200000 > /sys/devices/system/cpu/cpu23/cpufreq/scaling_max_freq`

#### Measure core freq
Measure the freq of core 23: `cat /sys/devices/system/cpu/cpu23/cpufreq/scaling_cur_freq`
Measure freq of core 23 (alternate method): `cpufreq-aperf -c 23 -o` (Note: we found this to be unreliable)
