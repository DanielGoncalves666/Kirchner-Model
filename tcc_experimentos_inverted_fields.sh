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
dir_name="tcc-inverted-experiments"
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

KD_OFF=0
KD_ON=1

# # fig2a experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2a - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_kd$KD_ON.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2a - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_kd$KD_OFF.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE  --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_kd$KD_ON.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE  --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_kd$KD_OFF.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# # fig2a_obstacles experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2a_obstacles - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_obstacles_kd$KD_ON.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2a_obstacles - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_obstacles_kd$KD_OFF.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE  --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a_obstacles - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_obstacles_kd$KD_ON.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE  --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a_obstacles - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_obstacles_kd$KD_OFF.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# # fig2b experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2b - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2b_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2b - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2b_kd$KD_OFF.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2b - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2b_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2b - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2b_kd$KD_OFF.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &


# fig2b pedestrians experiments

print_in_color "\033[0;34m" "Varas Inverted Field - fig2b_pedestrians - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2b_pedestrians_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -m3 -ekirchner_2b_pedestrians.txt -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

print_in_color "\033[0;34m" "Varas Inverted Field - fig2b_pedestrians - Experiment - kd=$KD_OFF"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2b_pedestrians_kd$KD_OFF.txt -aaux_kirchner_fig2b.txt -m3 -ekirchner_2b_pedestrians.txt -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2b_pedestrians - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2b_pedestrians_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -m3 -ekirchner_2b_pedestrians.txt -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2b_pedestrians - Experiment - kd=$KD_OFF"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2b_pedestrians_kd$KD_OFF.txt -aaux_kirchner_fig2b.txt -m3 -ekirchner_2b_pedestrians.txt -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# # alizadeh_crowd experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_crowd - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_crowd_kd$KD_ON.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_crowd - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_crowd_kd$KD_OFF.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_crowd - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_crowd_kd$KD_ON.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_crowd - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_crowd_kd$KD_OFF.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #daniel_classroom experiments
# print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_kd$KD_ON.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_kd$KD_OFF.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_kd$KD_ON.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_kd$KD_OFF.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #daniel_classroom_dense experiments
# print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom_dense - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_dense_kd$KD_ON.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_dense_kd$KD_OFF.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_dense_kd$KD_ON.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_dense_kd$KD_OFF.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #alizadeh_restaurant_1 experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_1 - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_1_kd$KD_ON.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_1 - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_1_kd$KD_OFF.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_1 - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_1_kd$KD_ON.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_1 - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_1_kd$KD_OFF.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #alizadeh_restaurant_2 experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_2 - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_2_kd$KD_ON.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_2 - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_2_kd$KD_OFF.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_2 - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_2_kd$KD_ON.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_2 - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_2_kd$KD_OFF.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

#alizadeh_restaurant_uniform experiments

print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_uniform - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_uniform_kd$KD_ON.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_uniform - Experiment - kd=$KD_OFF"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_uniform_kd$KD_OFF.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_uniform - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_uniform_kd$KD_ON.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_uniform - Experiment - kd=$KD_OFF"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_uniform_kd$KD_OFF.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #silva_classroom experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - silva_classroom - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_classroom_kd$KD_ON.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - silva_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_classroom_kd$KD_OFF.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_classroom - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_classroom_kd$KD_ON.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_classroom_kd$KD_OFF.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #silva_laboratory experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - silva_laboratory - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_laboratory_kd$KD_ON.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - silva_laboratory - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_laboratory_kd$KD_OFF.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_laboratory - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_laboratory_kd$KD_ON.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_laboratory - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_laboratory_kd$KD_OFF.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

wait

# ##################################### Movement ###################################################################
NUM_SIMU=1
OUTPUT_TYPE=1

varas_dir_name="$dir_name/inverted_varas/mov"
alizadeh_dir_name="$dir_name/inverted_alizadeh/mov"

mkdir -p output/$varas_dir_name
mkdir -p output/$alizadeh_dir_name

# # fig2a experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2a - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_kd$KD_ON.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2a - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_kd$KD_OFF.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE  --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_kd$KD_ON.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE  --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_kd$KD_OFF.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# # fig2a_obstacles experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2a_obstacles - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_obstacles_kd$KD_ON.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2a_obstacles - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_obstacles_kd$KD_OFF.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a_obstacles - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_obstacles_kd$KD_ON.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a_obstacles - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_obstacles_kd$KD_OFF.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# # fig2b experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2b - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2b_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - fig2b - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2b_kd$KD_OFF.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2b - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2b_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2b - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2b_kd$KD_OFF.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# fig2b pedestrians experiments

print_in_color "\033[0;34m" "Varas Inverted Field - fig2b_pedestrians - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2b_pedestrians_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -m3 -ekirchner_2b_pedestrians.txt -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

print_in_color "\033[0;34m" "Varas Inverted Field - fig2b_pedestrians - Experiment - kd=$KD_OFF"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2b_pedestrians_kd$KD_OFF.txt -aaux_kirchner_fig2b.txt -m3 -ekirchner_2b_pedestrians.txt -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2b_pedestrians - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2b_pedestrians_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -m3 -ekirchner_2b_pedestrians.txt -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2b_pedestrians - Experiment - kd=$KD_OFF"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2b_pedestrians_kd$KD_OFF.txt -aaux_kirchner_fig2b.txt -m3 -ekirchner_2b_pedestrians.txt -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# # alizadeh_crowd experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_crowd - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_crowd_kd$KD_ON.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_crowd - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_crowd_kd$KD_OFF.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_crowd - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_crowd_kd$KD_ON.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_crowd - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_crowd_kd$KD_OFF.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #daniel_classroom experiments
# print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_kd$KD_ON.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_kd$KD_OFF.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_kd$KD_ON.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_kd$KD_OFF.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #daniel_classroom_dense experiments
# print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom_dense - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_dense_kd$KD_ON.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_dense_kd$KD_OFF.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_dense_kd$KD_ON.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_dense_kd$KD_OFF.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #alizadeh_restaurant_1 experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_1 - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_1_kd$KD_ON.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_1 - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_1_kd$KD_OFF.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_1 - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_1_kd$KD_ON.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_1 - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_1_kd$KD_OFF.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #alizadeh_restaurant_2 experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_2 - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_2_kd$KD_ON.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_2 - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_2_kd$KD_OFF.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_2 - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_2_kd$KD_ON.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_2 - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_2_kd$KD_OFF.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

#alizadeh_restaurant_uniform experiments

print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_uniform - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_uniform_kd$KD_ON.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_uniform - Experiment - kd=$KD_OFF"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_uniform_kd$KD_OFF.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_uniform - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_uniform_kd$KD_ON.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_uniform - Experiment - kd=$KD_OFF"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_uniform_kd$KD_OFF.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #silva_classroom experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - silva_classroom - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_classroom_kd$KD_ON.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - silva_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_classroom_kd$KD_OFF.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_classroom - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_classroom_kd$KD_ON.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_classroom - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_classroom_kd$KD_OFF.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

# #silva_laboratory experiments

# print_in_color "\033[0;34m" "Varas Inverted Field - silva_laboratory - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_laboratory_kd$KD_ON.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Varas Inverted Field - silva_laboratory - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_laboratory_kd$KD_OFF.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=4 --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_laboratory - Experiment - kd=$KD_ON"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_laboratory_kd$KD_ON.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements &

# print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_laboratory - Experiment - kd=$KD_OFF"
# $RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_laboratory_kd$KD_OFF.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --kd=$KD_OFF --ks=2 --static-field=5 --allow-diagonal-movements &

wait


##################################### Static Fields ###################################################################
NUM_SIMU=1
OUTPUT_TYPE=1

varas_dir_name="$dir_name/inverted_varas/static_field/lixo"
alizadeh_dir_name="$dir_name/inverted_alizadeh/static_field/lixo"
varas_dir_name_sff="$dir_name/inverted_varas/static_field"
alizadeh_dir_name_sff="$dir_name/inverted_alizadeh/static_field"

mkdir -p output/$varas_dir_name
mkdir -p output/$alizadeh_dir_name
mkdir -p output/$varas_dir_name_sff
mkdir -p output/$alizadeh_dir_name_sff

# fig2a experiments

print_in_color "\033[0;34m" "Varas Inverted Field - fig2a - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_kd$KD_ON.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_fig2a.txt &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_kd$KD_ON.txt -aaux_kirchner_fig2a.txt -l35 -c35 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE  --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_fig2a.txt &

# fig2a_obstacles experiments

print_in_color "\033[0;34m" "Varas Inverted Field - fig2a_obstacles - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2a_obstacles_kd$KD_ON.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_fig2a_obstacles.txt &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2a_obstacles - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2a_obstacles_kd$KD_ON.txt -ekirchner_35by35_obst.txt -m2 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_fig2a_obstacles.txt &

# fig2b experiments

print_in_color "\033[0;34m" "Varas Inverted Field - fig2b - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2b_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_fig2b.txt &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2b - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2b_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -l32 -c62 -m5 -O$OUTPUT_TYPE -s$NUM_SIMU --density=$DENSIDADE --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_fig2b.txt &

# fig2b pedestrians experiments

print_in_color "\033[0;34m" "Varas Inverted Field - fig2b pedestrians - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_fig2b_pedestrians_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -m3 -ekirchner_2b_pedestrians.txt -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_2b_pedestrians.txt &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - fig2b pedestrians - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_fig2b_pedestrians_kd$KD_ON.txt -aaux_kirchner_fig2b.txt -m3 -ekirchner_2b_pedestrians.txt -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_2b_pedestrians.txt &

# alizadeh_crowd experiments

print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_crowd - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_crowd_kd$KD_ON.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_alizadeh_crowd.txt &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_crowd - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_crowd_kd$KD_ON.txt -ealizadeh_crowd.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_alizadeh_crowd.txt &

#daniel_classroom experiments
print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_kd$KD_ON.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_daniel_classroom.txt &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_kd$KD_ON.txt -edaniel_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_daniel_classroom.txt &

#daniel_classroom_dense experiments
print_in_color "\033[0;34m" "Varas Inverted Field - daniel_classroom_dense - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_daniel_classroom_dense_kd$KD_ON.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_daniel_classroom_dense.txt &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - daniel_classroom_dense - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_daniel_classroom_dense_kd$KD_ON.txt -edaniel_classroom_dense.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_daniel_classroom_dense.txt &

#alizadeh_restaurant_1 experiments

print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_1 - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_1_kd$KD_ON.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_alizadeh_restaurant_1.txt &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_1 - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_1_kd$KD_ON.txt -ealizadeh_restaurant_1.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_alizadeh_restaurant_1.txt &

#alizadeh_restaurant_2 experiments

print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_2 - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_2_kd$KD_ON.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_alizadeh_restaurant_2.txt &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_2 - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_2_kd$KD_ON.txt -ealizadeh_restaurant_2.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_alizadeh_restaurant_2.txt &

#alizadeh_restaurant_uniform experiments

print_in_color "\033[0;34m" "Varas Inverted Field - alizadeh_restaurant_uniform - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_alizadeh_restaurant_uniform_kd$KD_ON.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_alizadeh_restaurant_uniform.txt &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - alizadeh_restaurant_uniform - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_alizadeh_restaurant_uniform_kd$KD_ON.txt -ealizadeh_restaurant_uniform.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_alizadeh_restaurant_uniform.txt &

#silva_classroom experiments

print_in_color "\033[0;34m" "Varas Inverted Field - silva_classroom - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_classroom_kd$KD_ON.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_silva_classroom.txt  --traversable-off  &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_classroom - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_classroom_kd$KD_ON.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_silva_classroom.txt  --traversable-off &

#silva_laboratory experiments

print_in_color "\033[0;34m" "Varas Inverted Field - silva_laboratory - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$varas_dir_name/varas_inverted_silva_laboratory_kd$KD_ON.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=2 --static-field=4 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$varas_dir_name_sff/varas_inverted_silva_laboratory.txt  --traversable-off &

print_in_color "\033[0;34m" "Alizadeh Inverted Field - silva_laboratory - Experiment - kd=$KD_ON"
$RUN_COMMAND -o$alizadeh_dir_name/alizadeh_inverted_silva_laboratory_kd$KD_ON.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD_ON --ks=1 --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --print-sff >> output/$alizadeh_dir_name_sff/azalideh_inverted_silva_laboratory.txt  --traversable-off &