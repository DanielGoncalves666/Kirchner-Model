#!/bin/bash

# Prints the provided text in the given color.
# $1 Sequence code of the chosen color.
# $2 The string to be printed.
print_in_color()
{
    echo -e "$1$2\033[0m"
}

clear
print_in_color "\033[0;32m" "TCC Inverted Fields Experiment!"

static_field=$1
dir_name="tcc-inverted-variation-experiments"
varas_dir_name="$dir_name/inverted_varas"
alizadeh_dir_name="$dir_name/inverted_alizadeh"
mkdir -p output/$dir_name
mkdir -p output/$varas_dir_name
mkdir -p output/$alizadeh_dir_name

# Comparar as salas vazias fig2a e fig2b entre os modelos
# Comparar o restaurante do Alizadeh


./compile.sh
RUN_COMMAND="./build/kirchner.exe"

NUM_SIMU=100
OUTPUT_TYPE=2
DENSIDADE=0.3

# # fig2a experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2a - Experiment"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_variation.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a - Experiment"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_variation.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE  --delta=0.3 --alpha=0.3 --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# # fig2a_obstacles experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2a_obstacles - Experiment"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_obstacles_variation.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &


# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a_obstacles - Experiment"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_obstacles_variation.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE  --delta=0.3 --alpha=0.3 --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &


# # fig2b experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2b - Experiment"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2b_variation.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2b - Experiment"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2b_variation.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# # alizadeh_crowd experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_crowd - Experiment"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_crowd_variation.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_crowd - Experiment"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_crowd_variation.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# #daniel_classroom experiments
# print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom - Experiment"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_variation.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom - Experiment"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_variation.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# #daniel_classroom_dense experiments
# print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom_dense - Experiment"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_dense_variation.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom - Experiment"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_dense_variation.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# #alizadeh_restaurant_1 experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_1 - Experiment"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_1_variation.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_1 - Experiment"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_1_variation.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# #alizadeh_restaurant_2 experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_2 - Experiment"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_2_variation.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_2 - Experiment"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_2_variation.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

#alizadeh_restaurant_uniform experiments

print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_uniform - Experiment"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_uniform_variation.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_uniform - Experiment"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_uniform_variation.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# #silva_classroom experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - silva_classroom - Experiment"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_classroom_variation.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_classroom - Experiment"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_classroom_variation.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# #silva_laboratory experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - silva_laboratory - Experiment"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_laboratory_variation.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_laboratory - Experiment"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_laboratory_variation.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --min=0 --max=10 --step=0.1 &


wait