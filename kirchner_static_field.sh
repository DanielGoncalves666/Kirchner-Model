#!/bin/bash

#Used to generate the static floor field for each calculation approach.

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

for static_field in 1 2  4 5; do
    print_in_color "\033[0;34m" "Kirchner static-field "$static_field
    ./kirchner.sh -o$dir_name/kirchner-$static_field.txt -a$auxiliary -m5 -l63 -c63 -O2 -s1 --density=0.3 --delta=0.3 --alpha=0.1 --kd=0 --ks=1 --static-field=$static_field --debug >> output/$dir_name/debug$static_field-$auxiliary.txt
done
