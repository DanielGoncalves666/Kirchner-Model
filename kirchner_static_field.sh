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
print_in_color "\033[0;32m" "Kirchner Static Field Print!"

auxiliary=$1
dir_name="static_field-"$auxiliary
mkdir -p output/$dir_name

for static_field in 1 2 3; do
    print_in_color "\033[0;34m" "Kirchner static-field "$static_field
    ./kirchner.sh -oerase.txt -a$auxiliary -m5 -l$2 -c$3 -O2 -s1 --static-field=$static_field --print-sff >> output/$dir_name/${auxiliary}_static_field_$static_field.txt
    rm -r output/erase.txt # The simulation data doesn't matter
done
