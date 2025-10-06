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
print_in_color "\033[0;32m" "Fire Tests"

dir_name="fire_tests"
mkdir -p output/$dir_name

print_in_color "\033[0;34m" "Test 1"
./kirchner.sh -o$dir_name/fire_example_2.txt -m4 -efire_example_2.txt -O1 -s1 --static-field=5 --kf=600 --ks=2

