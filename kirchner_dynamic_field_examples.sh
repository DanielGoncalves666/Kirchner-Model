#!/bin/bash

# This script expects three arguments: the auxiliary file, the number of lines and the number of columns in the environment.

# Prints the provided text in the given color.
# $1 Sequence code of the chosen color.
# $2 The string to be printed.
print_in_color()
{
    echo -e "$1$2\033[0m"
}

clear
print_in_color "\033[0;32m" "Kirchner Dynamic Field Print!"

auxiliary=$1
dir_name="dynamic_field-"$auxiliary
mkdir -p output/$dir_name

for static_field in 1 2; do
    print_in_color "\033[0;34m" "Kirchner static-field "$static_field
    ./kirchner.sh -oerase.txt -a$auxiliary -m5 -l$2 -c$3 -O2 -s1 --ks=2 --kd=1 --density=0.3 --alpha=0.3 --delta=0.2 --ignore-self-trace --skip-new-particles-decay --static-field=$static_field --print-dff="output/$dir_name/dynamic_output_$static_field.txt"
    rm -r output/erase.txt # The simulation data doesn't matter
done

for static_field in 4; do
    print_in_color "\033[0;34m" "Kirchner static-field "$static_field
    ./kirchner.sh -oerase.txt -a$auxiliary -m5 -l$2 -c$3 -O2 -s1 --ks=2 --kd=1 --density=0.3 --alpha=0.3 --delta=0.2 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --static-field=$static_field --print-dff="output/$dir_name/dynamic_output_$static_field.txt"
    rm -r output/erase.txt # The simulation data doesn't matter
done