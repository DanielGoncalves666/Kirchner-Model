#!/bin/bash

# Prints the provided text in the given color.
# $1 Sequence code of the chosen color.
# $2 The string to be printed.
print_in_color()
{
    echo -e "$1$2\033[0m"
}

clear
print_in_color "\033[0;32m" "TCC Traversable Obstacles Experiment!"

dir_name="tcc-traversable-experiments"
simu_dir="$dir_name/simu"
mov_dir="$dir_name/mov"
static_dir="$dir_name/static_field"
garbage_dir="$static_dir/garbage"
statistics_dir="$dir_name/statistics"
fail_statistics_dir="$dir_name/statistics/fails"
successes_statistics_dir="$dir_name/statistics/successes"

rm -r "output/$static_dir"

mkdir -p output/$dir_name
mkdir -p output/$simu_dir
mkdir -p output/$mov_dir
mkdir -p output/$static_dir
mkdir -p output/$garbage_dir
mkdir -p output/$statistics_dir
mkdir -p output/$fail_statistics_dir
mkdir -p output/$successes_statistics_dir

./compile.sh
RUN_COMMAND="./build/kirchner.exe"

KD=1
KS=2

for TRAVERSABILITY in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9; do

    # NUM_SIMU=1000
    # OUTPUT_TYPE=2
    # COOLDOWN=-1

    # #alizadeh_restaurant_1 experiments

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_1 - Experiment"
    # $RUN_COMMAND -o$simu_dir/alizadeh_restaurant_1_simu_traversable_$TRAVERSABILITY.txt -ealizadeh_restaurant_1_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_1 - Experiment - traversable-off"
    # $RUN_COMMAND -o$simu_dir/alizadeh_restaurant_1_simu_traversable_OFF.txt -ealizadeh_restaurant_1_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off &

    # #alizadeh_restaurant_uniform experiments

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_uniform - Experiment"
    # $RUN_COMMAND -o$simu_dir/alizadeh_restaurant_uniform_simu_traversable_$TRAVERSABILITY.txt -ealizadeh_restaurant_uniform_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_uniform - Experiment - traversable-off"
    # $RUN_COMMAND -o$simu_dir/alizadeh_restaurant_uniform_simu_traversable_OFF.txt -ealizadeh_restaurant_uniform_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off &

    # #silva_classroom experiments

    # print_in_color "\033[0;34m" "Traversable - silva_classroom - Experiment"
    # $RUN_COMMAND -o$simu_dir/silva_classroom_simu_traversable_$TRAVERSABILITY.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    # print_in_color "\033[0;34m" "Traversable - silva_classroom - Experiment - traversable-off"
    # $RUN_COMMAND -o$simu_dir/silva_classroom_simu_traversable_OFF.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off &

    # #silva_laboratory experiments

    # print_in_color "\033[0;34m" "Traversable - silva_laboratory - Experiment"
    # $RUN_COMMAND -o$simu_dir/silva_laboratory_simu_traversable_$TRAVERSABILITY.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    # print_in_color "\033[0;34m" "Traversable - silva_laboratory - Experiment - traversable-off"
    # $RUN_COMMAND -o$simu_dir/silva_laboratory_simu_traversable_OFF.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off &

    # #daniel_anfitratro experiments

    # print_in_color "\033[0;34m" "Traversable - daniel_anfiteatro - Experiment"
    # $RUN_COMMAND -o$simu_dir/daniel_anfiteatro_simu_traversable_$TRAVERSABILITY.txt -edaniel_anfiteatro.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    # print_in_color "\033[0;34m" "Traversable - daniel_anfiteatro - Experiment - traversable-off"
    # $RUN_COMMAND -o$simu_dir/daniel_anfiteatro_simu_traversable_OFF.txt -edaniel_anfiteatro.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off &

    # wait

    # ##################################### Movement ###################################################################
    # NUM_SIMU=1
    # OUTPUT_TYPE=1
    # COOLDOWN=0

    # #alizadeh_restaurant_1 experiments

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_1 - Movement"
    # $RUN_COMMAND -o$mov_dir/alizadeh_restaurant_1_mov_traversable_$TRAVERSABILITY.txt -ealizadeh_restaurant_1_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_1 - Movement - traversable-off"
    # $RUN_COMMAND -o$mov_dir/alizadeh_restaurant_1_mov_traversable_OFF.txt -ealizadeh_restaurant_1_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off &

    # #alizadeh_restaurant_uniform experiments

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_uniform - Movement"
    # $RUN_COMMAND -o$mov_dir/alizadeh_restaurant_uniform_mov_traversable_$TRAVERSABILITY.txt -ealizadeh_restaurant_uniform_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_uniform - Movement - traversable-off"
    # $RUN_COMMAND -o$mov_dir/alizadeh_restaurant_uniform_mov_traversable_OFF.txt -ealizadeh_restaurant_uniform_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off &

    # #silva_classroom experiments

    # print_in_color "\033[0;34m" "Traversable - silva_classroom - Movement"
    # $RUN_COMMAND -o$mov_dir/silva_classroom_mov_traversable_$TRAVERSABILITY.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    # print_in_color "\033[0;34m" "Traversable - silva_classroom - Movement - traversable-off"
    # $RUN_COMMAND -o$mov_dir/silva_classroom_mov_traversable_OFF.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off &

    # #silva_laboratory experiments

    # print_in_color "\033[0;34m" "Traversable - silva_laboratory - Movement"
    # $RUN_COMMAND -o$mov_dir/silva_laboratory_mov_traversable_$TRAVERSABILITY.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    # print_in_color "\033[0;34m" "Traversable - silva_laboratory - Movement - traversable-off"
    # $RUN_COMMAND -o$mov_dir/silva_laboratory_mov_traversable_OFF.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off &

    # #daniel_anfitratro experiments

    # print_in_color "\033[0;34m" "Traversable - daniel_anfiteatro - Movement"
    # $RUN_COMMAND -o$mov_dir/daniel_anfiteatro_mov_traversable_$TRAVERSABILITY.txt -edaniel_anfiteatro.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    # print_in_color "\033[0;34m" "Traversable - daniel_anfiteatro - Movement - traversable-off"
    # $RUN_COMMAND -o$mov_dir/daniel_anfiteatro_mov_traversable_OFF.txt -edaniel_anfiteatro.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off &

    # wait

    # ##################################### Traversable Fails ###################################################################
    NUM_SIMU=1000
    OUTPUT_TYPE=4
    COOLDOWN=-1

    #alizadeh_restaurant_1 experiments

    print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_1 - Traversable Fails"
    $RUN_COMMAND -o$fail_statistics_dir/alizadeh_restaurant_1_mov_traversable_${TRAVERSABILITY}_fails.txt -ealizadeh_restaurant_1_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    #alizadeh_restaurant_uniform experiments

    print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_uniform - Traversable Fails"
    $RUN_COMMAND -o$fail_statistics_dir/alizadeh_restaurant_uniform_mov_traversable_${TRAVERSABILITY}_fails.txt -ealizadeh_restaurant_uniform_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    #silva_classroom experiments

    print_in_color "\033[0;34m" "Traversable - silva_classroom - Traversable Fails"
    $RUN_COMMAND -o$fail_statistics_dir/silva_classroom_mov_traversable_${TRAVERSABILITY}_fails.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    #silva_laboratory experiments

    print_in_color "\033[0;34m" "Traversable - silva_laboratory - Traversable Fails"
    $RUN_COMMAND -o$fail_statistics_dir/silva_laboratory_mov_traversable_${TRAVERSABILITY}_fails.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    #daniel_anfitratro experiments

    print_in_color "\033[0;34m" "Traversable - daniel_anfiteatro - Traversable Fails"
    $RUN_COMMAND -o$fail_statistics_dir/daniel_anfiteatro_mov_traversable_${TRAVERSABILITY}_fails.txt -edaniel_anfiteatro.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    wait

# ##################################### Traversable Successes ###################################################################
    NUM_SIMU=1000
    OUTPUT_TYPE=5
    COOLDOWN=-1

    #alizadeh_restaurant_1 experiments

    print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_1 - Traversable Successes"
    $RUN_COMMAND -o$successes_statistics_dir/alizadeh_restaurant_1_mov_traversable_${TRAVERSABILITY}_successes.txt -ealizadeh_restaurant_1_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    #alizadeh_restaurant_uniform experiments

    print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_uniform - Traversable Successes"
    $RUN_COMMAND -o$successes_statistics_dir/alizadeh_restaurant_uniform_mov_traversable_${TRAVERSABILITY}_successes.txt -ealizadeh_restaurant_uniform_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    #silva_classroom experiments

    print_in_color "\033[0;34m" "Traversable - silva_classroom - Traversable Successes"
    $RUN_COMMAND -o$successes_statistics_dir/silva_classroom_mov_traversable_${TRAVERSABILITY}_successes.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    #silva_laboratory experiments

    print_in_color "\033[0;34m" "Traversable - silva_laboratory - Traversable Successes"
    $RUN_COMMAND -o$successes_statistics_dir/silva_laboratory_mov_traversable_${TRAVERSABILITY}_successes.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    #daniel_anfitratro experiments

    print_in_color "\033[0;34m" "Traversable - daniel_anfiteatro - Traversable Successes"
    $RUN_COMMAND -o$successes_statistics_dir/daniel_anfiteatro_mov_traversable_${TRAVERSABILITY}_successes.txt -edaniel_anfiteatro.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY &

    wait

    ##################################### Static Fields ###################################################################
    # NUM_SIMU=1
    # OUTPUT_TYPE=1

    # #alizadeh_restaurant_1 experiments

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_1 - Static Field"
    # $RUN_COMMAND -o$garbage_dir/alizadeh_restaurant_1_mov_traversable_$TRAVERSABILITY.txt -ealizadeh_restaurant_1_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY --print-sff >> output/$static_dir/alizadeh_restaurant_1_traversable_${COOLDOWN}_sff.txt &

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_1 - Static Field - traversable-off"
    # $RUN_COMMAND -o$garbage_dir/alizadeh_restaurant_1_mov_traversable_OFF.txt -ealizadeh_restaurant_1_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off --print-sff >> output/$static_dir/alizadeh_restaurant_1_traversable_OFF_sff.txt &

    # #alizadeh_restaurant_uniform experiments

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_uniform - Static Field"
    # $RUN_COMMAND -o$garbage_dir/alizadeh_restaurant_uniform_mov_traversable_$TRAVERSABILITY.txt -ealizadeh_restaurant_uniform_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY --print-sff >> output/$static_dir/alizadeh_restaurant_uniform_${COOLDOWN}_sff.txt &

    # print_in_color "\033[0;34m" "Traversable - alizadeh_restaurant_uniform - Static Field - traversable-off"
    # $RUN_COMMAND -o$garbage_dir/alizadeh_restaurant_uniform_mov_traversable_OFF.txt -ealizadeh_restaurant_uniform_traversable.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off --print-sff >> output/$static_dir/alizadeh_restaurant_uniform_traversable_OFF_sff.txt &

    # #silva_classroom experiments

    # print_in_color "\033[0;34m" "Traversable - silva_classroom - Static Field"
    # $RUN_COMMAND -o$garbage_dir/silva_classroom_mov_traversable_$TRAVERSABILITY.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY --print-sff >> output/$static_dir/silva_classroom_${COOLDOWN}_sff.txt &

    # print_in_color "\033[0;34m" "Traversable - silva_classroom - Static Field - traversable-off"
    # $RUN_COMMAND -o$garbage_dir/silva_classroom_mov_traversable_OFF.txt -esilva_classroom.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off --print-sff >> output/$static_dir/silva_classroom_traversable_OFF_sff.txt &

    # #silva_laboratory experiments

    # print_in_color "\033[0;34m" "Traversable - silva_laboratory - Static Field"
    # $RUN_COMMAND -o$garbage_dir/silva_laboratory_mov_traversable_$TRAVERSABILITY.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY --print-sff >> output/$static_dir/silva_laboratory_${COOLDOWN}_sff.txt &

    # print_in_color "\033[0;34m" "Traversable - silva_laboratory - Static Field - traversable-off"
    # $RUN_COMMAND -o$garbage_dir/silva_laboratory_mov_traversable_OFF.txt -esilva_laboratory.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off --print-sff >> output/$static_dir/silva_laboratory_traversable_OFF_sff.txt  &

    # #daniel_anfitratro experiments

    # print_in_color "\033[0;34m" "Traversable - daniel_anfiteatro - Static Field"
    # $RUN_COMMAND -o$garbage_dir/daniel_anfiteatro_mov_traversable_$TRAVERSABILITY.txt -edaniel_anfiteatro.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --cooldown=$COOLDOWN --traversability=$TRAVERSABILITY --print-sff >> output/$static_dir/daniel_anfiteatro_${COOLDOWN}_sff.txt &

    # print_in_color "\033[0;34m" "Traversable - daniel_anfiteatro - Static Field - traversable-off"
    # $RUN_COMMAND -o$garbage_dir/daniel_anfiteatro_mov_traversable_OFF.txt -edaniel_anfiteatro.txt -m4 -O$OUTPUT_TYPE -s$NUM_SIMU --delta=0.3 --alpha=0.3 --kd=$KD --ks=$KS --static-field=5 --ignore-self-trace --skip-new-particles-decay --allow-diagonal-movements --traversable-off --print-sff >> output/$static_dir/daniel_anfiteatro_traversable_OFF_sff.txt &

    # wait

done

rm -r output/$garbage_dir

