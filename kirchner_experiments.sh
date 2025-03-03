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

dir_name="kirchner"
mkdir -p output/$dir_name

# print_in_color "\033[0;34m" "Kirchner figure 5a Experiment."
# for kd_value in 0.0 10.0; do
#     # Variação do ks
#     ./kirchner.sh -o$dir_name/kirchner_fig_5a_kd$kd_value.txt -akirchner_section_3.txt -m5 -l63 -c63 -O2 -s5 --density=0.3 --delta=0.3 --alpha=0.1 --kd=$kd_value --min=0 --max=4 --step=0.01
# done

print_in_color "\033[0;34m" "Kirchner figure 5b Experiment"
for ks_value in 0.4 1.0 10.0; do
    # Variação do kd
    ./kirchner.sh -o$dir_name/kirchner_fig_5b_ks$ks_value.txt -akirchner_section_3.txt -m5 -l63 -c63 -O2 -s5 --density=0.3 --delta=0.3 --alpha=0.3 --ks=$ks_value --min=0 --max=10 --step=0.1
done

# print_in_color "\033[0;34m" "Alizadeh figure 9b Experiment."
# ./alizadeh.sh -ealizadeh_restaurant_1.txt -o$dir_name/alizadeh_fig_9b_onlyValid.txt -aalizadeh_doorPosition_onlyValid_simulationSet.txt -m3 -O2 --alpha=1 -s10 --allow-x-movement --single-exit-flag

# print_in_color "\033[0;34m" "Alizadeh figure 10a Experiment."
# ./alizadeh.sh -ealizadeh_restaurant_1.txt -o$dir_name/alizadeh_fig_10a_onlyValid.txt -aalizadeh_doorPosition_onlyValid_simulationSet.txt -m3 -O4 --alpha=0 -s1 --allow-x-movement --single-exit-flag

# print_in_color "\033[0;34m" "Alizadeh figure 10b Experiment."
# ./alizadeh.sh -ealizadeh_restaurant_1.txt -o$dir_name/alizadeh_fig_10b_onlyValid.txt -aalizadeh_doorPosition_onlyValid_simulationSet.txt -m3 -O4 --alpha=1 -s1 --allow-x-movement --single-exit-flag

# print_in_color "\033[0;34m" "Alizadeh figure 12a Experiment."
# ./alizadeh.sh -ealizadeh_restaurant_2.txt -o$dir_name/alizadeh_fig_12a_onlyValid.txt -aalizadeh_doorPosition_onlyValid_simulationSet.txt -m3 -O2 --alpha=0 -s10 --allow-x-movement --single-exit-flag

# print_in_color "\033[0;34m" "Alizadeh figure 12b Experiment."
# ./alizadeh.sh -ealizadeh_restaurant_2.txt -o$dir_name/alizadeh_fig_12b_onlyValid.txt -aalizadeh_doorPosition_onlyValid_simulationSet.txt -m3 -O2 --alpha=1 -s10 --allow-x-movement --single-exit-flag

# print_in_color "\033[0;34m" "Alizadeh figure 13a Experiment."
# ./alizadeh.sh -ealizadeh_restaurant_1.txt -o$dir_name/alizadeh_fig_13a.txt -aalizadeh_doorWidth_simulationSet.txt -m3 -O2 --alpha=0 -s10 --allow-x-movement

# print_in_color "\033[0;34m" "Alizadeh figure 13b Experiment."
# ./alizadeh.sh -ealizadeh_restaurant_1.txt -o$dir_name/alizadeh_fig_13b.txt -aalizadeh_doorWidth_simulationSet.txt -m3 -O2 --alpha=1 -s10 --allow-x-movement

# dir_name="alizadeh/alizadeh_fig_15"
# mkdir -p output/$dir_name
# print_in_color "\033[0;34m" "Alizadeh figure 15 Experiment."

# for num_ped in 0.0 0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0; do
#     ./alizadeh.sh -ealizadeh_classroom.txt -o$dir_name/alizadeh_fig_15_alpha$num_ped.txt -m4 -O2 --alpha=$num_ped -s10 --allow-x-movement
# done