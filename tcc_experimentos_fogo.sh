#!/bin/bash

# Prints the provided text in the given color.
# $1 Sequence code of the chosen color.
# $2 The string to be printed.
print_in_color()
{
    echo -e "$1$2\033[0m"
}

clear
print_in_color "\033[0;32m" "TCC Fire Experiments!"

./compile.sh
RUN_COMMAND="./build/kirchner.exe"

dir_name="tcc-fire-experiments"
mkdir -p output/$dir_name

for ambient in "daniel_anfiteatro_fogo_centro" "daniel_anfiteatro_fogo_superior" "daniel_anfiteatro_fogo_porta_esquerda" "daniel_anfiteatro_fogo_duas_portas"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_name/fire_experiment_$ambient.txt -m4 -e$ambient.txt -O1 -s1 --static-field=5 --kf=10 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.7 --print-sff > teste_$ambient.txt
done


