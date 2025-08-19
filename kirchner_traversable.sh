#!/bin/bash

# Prints the provided text in the given color.
# $1 Sequence code of the chosen color.
# $2 The string to be printed.
print_in_color()
{
    echo -e "$1$2\033[0m"
}

clear
print_in_color "\033[0;32m" "Kirchner Experiments Script!"

static_field=$1
dir_name="kirchner-traversable"
mkdir -p output/$dir_name

./compile.sh
RUN_COMMAND="./build/kirchner.exe"

print_in_color "\033[0;34m" "Kirchner Traversable Obstacles Experiment."
for environment in "silva_laboratory.txt"; do
    $RUN_COMMAND -o$dir_name/kirchner_traversable_$environment.txt -e$environment -m4 -O1 -s1 --density=0.3 --delta=0.3 --alpha=0.3 --kd=0 --ks=1 --static-field=$static_field --ignore-self-trace --skip-new-particles-decay --immediate-exit &
done


wait