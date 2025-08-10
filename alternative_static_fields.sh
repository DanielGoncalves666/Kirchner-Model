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
print_in_color "\033[0;32m" "Alternative Static Fields Print!"

auxiliary=$1
dir_name="alternative-static-field-"$auxiliary
mkdir -p output/$dir_name

# for static_field in 4 5; do
#     print_in_color "\033[0;34m" "Alternative static-field "$static_field
#     ./kirchner.sh -oerase.txt -a$auxiliary -m5 -l$2 -c$3 -O2 -s1 --static-field=$static_field --print-sff >> output/$dir_name/${auxiliary}_alternative_static_field_$static_field.txt
#     rm -r output/erase.txt # The simulation data doesn't matter
# done

for environment in kirchner_35by35.txt kirchner_35by35_obst.txt; do
    print_in_color "\033[0;34m" "Kirchner "$environment
    ./kirchner.sh -oerase.txt -e$environment -m4 -O1 -s1 --static-field=1 --print-sff >> output/$dir_name/$environment
    rm -r output/erase.txt # The simulation data doesn't matter
done
