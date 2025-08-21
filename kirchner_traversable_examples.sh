#!/bin/bash

# Prints the provided text in the given color.
# $1 Sequence code of the chosen color.
# $2 The string to be printed.
print_in_color()
{
    echo -e "$1$2\033[0m"
}

clear
print_in_color "\033[0;32m" "Kirchner Traversable Examples Script!"

static_field=$1
dir_name="kirchner-traversable-examples"
mkdir -p output/$dir_name

./compile.sh
RUN_COMMAND="./build/kirchner.exe"

rm output/$dir_name/debug_impassable.txt
print_in_color "\033[0;34m" "Kirchner Traversable Example - Impassable"
$RUN_COMMAND -o$dir_name/kirchner_traversable_example_impassable.txt -esmall_room.txt -m4 -O1 -s1 --ks=4 --seed=-1 --static-field=4 --traversable-off --diagonal=1.5 --allow-diagonal-movements --debug >> output/$dir_name/debug_impassable.txt

for cooldown in 0 5; do
    rm output/$dir_name/debug_cooldown$cooldown.txt
    print_in_color "\033[0;34m" "Kirchner Traversable Example - Cooldown $cooldown"
    $RUN_COMMAND -o$dir_name/kirchner_traversable_example_cooldown$cooldown.txt -esmall_room.txt -m4 -O1 -s1 --ks=4 --seed=-1 --cooldown=$cooldown --static-field=4 --diagonal=1.5 --allow-diagonal-movements --debug >> output/$dir_name/debug_cooldown$cooldown.txt
done
