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

print_in_color "\033[0;34m" "Kirchner figure 5a Experiment."
for kd_value in 0.0 10.0; do
    # Variação do ks
    ./kirchner.sh -o$dir_name/kirchner_fig_5a_kd$kd_value.txt -akirchner_section_3.txt -m5 -l63 -c63 -O2 -s5 --density=0.3 --delta=0.3 --alpha=0.1 --kd=$kd_value --min=0 --max=4 --step=0.01
done

print_in_color "\033[0;34m" "Kirchner figure 5b Experiment"
for ks_value in 0.4 1.0 10.0; do
    # Variação do kd
    ./kirchner.sh -o$dir_name/kirchner_fig_5b_ks$ks_value.txt -akirchner_section_3.txt -m5 -l63 -c63 -O2 -s5 --density=0.3 --delta=0.3 --alpha=0.3 --ks=$ks_value --min=0 --max=10 --step=0.1
done

print_in_color "\033[0;34m" "Kirchner figure 7a Experiment"
for alpha in 0.3 0.1 0.0; do
    # Variação de kd
    ./kirchner.sh -o$dir_name/kirchner_fig_7a_alpha$alpha.txt -akirchner_section_3.txt -m5 -l63 -c63 -O2 -s5 --density=0.3 --delta=0.3 --alpha=$alpha --ks=0.4 --min=0 --max=10 --step=0.1
done

print_in_color "\033[0;34m" "Kirchner figure 7b Experiment"
for delta in 0.2 0.3 0.4; do
    # Variação de kd
    ./kirchner.sh -o$dir_name/kirchner_fig_7b_delta$delta.txt -akirchner_section_3.txt -m5 -l63 -c63 -O2 -s5 --density=0.3 --delta=$delta --alpha=0.0 --ks=0.4 --min=0 --max=10 --step=0.1
done

print_in_color "\033[0;34m" "Kirchner figure 8a Experiment"
for delta in 0.2 0.4; do
    # Variação de alpha
    ./kirchner.sh -o$dir_name/kirchner_fig_8a_delta$delta.txt -akirchner_section_3.txt -m5 -l63 -c63 -O2 -s5 --density=0.3 --delta=$delta --ks=0.4 --kd=0.4 --min=0 --max=1 --step=0.01
done

print_in_color "\033[0;34m" "Kirchner figure 8b Experiment"
for delta in 0.2 0.4; do
    # Variação de alpha
    ./kirchner.sh -o$dir_name/kirchner_fig_8b_delta$delta.txt -akirchner_section_3.txt -m5 -l63 -c63 -O2 -s5 --density=0.003 --delta=$delta ---ks=0.4 --kd=0.4 --min=0 --max=1 --step=0.01
done

