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
dir_mov="$dir_name/mov"
dir_timesteps="$dir_name/timesteps"
dir_dead="$dir_name/dead"
dir_num_pedestrians="$dir_name/num_pedestrians"
mkdir -p output/$dir_name
mkdir -p output/$dir_mov
mkdir -p output/$dir_timesteps
mkdir -p output/$dir_dead
mkdir -p output/$dir_num_pedestrians

SIMU=1
OUT=1

for ambient in "daniel_anfiteatro_fogo_centro" "daniel_anfiteatro_fogo_superior" "daniel_anfiteatro_fogo_porta_esquerda" "daniel_anfiteatro_fogo_fileiras" "daniel_anfiteatro_fogo_centro_inferior"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_mov/fire_experiment_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 &
done

print_in_color "\033[0;34m" "Fire Experiment - daniel_anfiteatro - Sem fogo"
$RUN_COMMAND -o$dir_mov/fire_experiment_daniel_anfiteatro_no_fire.txt -m4 -edaniel_anfiteatro.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire &

for ambient in "silva_laboratory_fogo_corredor_centro" "silva_laboratory_fogo_corredor_direita" "silva_laboratory_fogo_corredor_esquerda" "silva_laboratory_fogo_fileiras_centro" "silva_laboratory_fogo_fileiras_esquerda" "silva_laboratory_fogo_meio"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_mov/fire_experiment_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 &
done

print_in_color "\033[0;34m" "Fire Experiment - silva_laboratory - Sem fogo"
$RUN_COMMAND -o$dir_mov/fire_experiment_silva_laboratory_no_fire.txt -m4 -esilva_laboratory.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire &

## traversable-off

for ambient in "daniel_anfiteatro_fogo_centro" "daniel_anfiteatro_fogo_superior" "daniel_anfiteatro_fogo_porta_esquerda" "daniel_anfiteatro_fogo_fileiras" "daniel_anfiteatro_fogo_centro_inferior"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_mov/fire_experiment_traversable_off_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 --traversable-off &
done

print_in_color "\033[0;34m" "Fire Experiment - daniel_anfiteatro - Sem fogo"
$RUN_COMMAND -o$dir_mov/fire_experiment_traversable_off_daniel_anfiteatro_no_fire.txt -m4 -edaniel_anfiteatro.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire --traversable-off &

for ambient in "silva_laboratory_fogo_corredor_centro" "silva_laboratory_fogo_corredor_direita" "silva_laboratory_fogo_corredor_esquerda" "silva_laboratory_fogo_fileiras_centro" "silva_laboratory_fogo_fileiras_esquerda" "silva_laboratory_fogo_meio"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_mov/fire_experiment_traversable_off_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 --traversable-off &
done

print_in_color "\033[0;34m" "Fire Experiment - silva_laboratory - Sem fogo"
$RUN_COMMAND -o$dir_mov/fire_experiment_traversable_off_silva_laboratory_no_fire.txt -m4 -esilva_laboratory.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire --traversable-off &

wait

SIMU=2
OUT=1000

for ambient in "daniel_anfiteatro_fogo_centro" "daniel_anfiteatro_fogo_superior" "daniel_anfiteatro_fogo_porta_esquerda" "daniel_anfiteatro_fogo_fileiras" "daniel_anfiteatro_fogo_centro_inferior"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_mov/fire_experiment_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 &
done

print_in_color "\033[0;34m" "Fire Experiment - daniel_anfiteatro - Sem fogo"
$RUN_COMMAND -o$dir_mov/fire_experiment_daniel_anfiteatro_no_fire.txt -m4 -edaniel_anfiteatro.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire &

for ambient in "silva_laboratory_fogo_corredor_centro" "silva_laboratory_fogo_corredor_direita" "silva_laboratory_fogo_corredor_esquerda" "silva_laboratory_fogo_fileiras_centro" "silva_laboratory_fogo_fileiras_esquerda" "silva_laboratory_fogo_meio"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_mov/fire_experiment_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 &
done

print_in_color "\033[0;34m" "Fire Experiment - silva_laboratory - Sem fogo"
$RUN_COMMAND -o$dir_mov/fire_experiment_silva_laboratory_no_fire.txt -m4 -esilva_laboratory.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire --traversable-off &

########## traversable-off

for ambient in "daniel_anfiteatro_fogo_centro" "daniel_anfiteatro_fogo_superior" "daniel_anfiteatro_fogo_porta_esquerda" "daniel_anfiteatro_fogo_fileiras" "daniel_anfiteatro_fogo_centro_inferior"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_mov/fire_experiment_traversable_off_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 --traversable-off &
done

print_in_color "\033[0;34m" "Fire Experiment - daniel_anfiteatro - Sem fogo"
$RUN_COMMAND -o$dir_mov/fire_experiment_traversable_off_daniel_anfiteatro_no_fire.txt -m4 -edaniel_anfiteatro.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire --traversable-off &

for ambient in "silva_laboratory_fogo_corredor_centro" "silva_laboratory_fogo_corredor_direita" "silva_laboratory_fogo_corredor_esquerda" "silva_laboratory_fogo_fileiras_centro" "silva_laboratory_fogo_fileiras_esquerda" "silva_laboratory_fogo_meio"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_mov/fire_experiment_traversable_off_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 --traversable-off &
done

print_in_color "\033[0;34m" "Fire Experiment - silva_laboratory - Sem fogo"
$RUN_COMMAND -o$dir_mov/fire_experiment_traversable_off_silva_laboratory_no_fire.txt -m4 -esilva_laboratory.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire --traversable-off &

wait

SIMU=1000
OUT=6

for ambient in "daniel_anfiteatro_fogo_centro" "daniel_anfiteatro_fogo_superior" "daniel_anfiteatro_fogo_porta_esquerda" "daniel_anfiteatro_fogo_fileiras" "daniel_anfiteatro_fogo_centro_inferior"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_dead/fire_experiment_dead_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600  &
done

for ambient in "silva_laboratory_fogo_corredor_centro" "silva_laboratory_fogo_corredor_direita" "silva_laboratory_fogo_corredor_esquerda" "silva_laboratory_fogo_fileiras_centro" "silva_laboratory_fogo_fileiras_esquerda" "silva_laboratory_fogo_meio"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_dead/fire_experiment_dead_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 &
done

for ambient in "daniel_anfiteatro_fogo_centro" "daniel_anfiteatro_fogo_superior" "daniel_anfiteatro_fogo_porta_esquerda" "daniel_anfiteatro_fogo_fileiras" "daniel_anfiteatro_fogo_centro_inferior"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_dead/fire_experiment_dead_traversable_off_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 --traversable-off &
done

for ambient in "silva_laboratory_fogo_corredor_centro" "silva_laboratory_fogo_corredor_direita" "silva_laboratory_fogo_corredor_esquerda" "silva_laboratory_fogo_fileiras_centro" "silva_laboratory_fogo_fileiras_esquerda" "silva_laboratory_fogo_meio"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_dead/fire_experiment_dead_traversable_off_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 --traversable-off &
done

wait

SIMU=1
OUT=7

for ambient in "daniel_anfiteatro_fogo_centro" "daniel_anfiteatro_fogo_superior" "daniel_anfiteatro_fogo_porta_esquerda" "daniel_anfiteatro_fogo_fileiras" "daniel_anfiteatro_fogo_centro_inferior"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_num_pedestrians/pedestres_no_ambiente_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 &
done

print_in_color "\033[0;34m" "Fire Experiment - daniel_anfiteatro - Sem fogo"
$RUN_COMMAND -o$dir_num_pedestrians/pedestres_no_ambiente_daniel_anfiteatro_no_fire.txt -m4 -edaniel_anfiteatro.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire &

for ambient in "silva_laboratory_fogo_corredor_centro" "silva_laboratory_fogo_corredor_direita" "silva_laboratory_fogo_corredor_esquerda" "silva_laboratory_fogo_fileiras_centro" "silva_laboratory_fogo_fileiras_esquerda" "silva_laboratory_fogo_meio"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_num_pedestrians/pedestres_no_ambiente_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 &
done

print_in_color "\033[0;34m" "Fire Experiment - silva_laboratory - Sem fogo"
$RUN_COMMAND -o$dir_num_pedestrians/pedstres_no_ambiente_silva_laboratory_no_fire.txt -m4 -esilva_laboratory.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire &

####### --traversable-off

for ambient in "daniel_anfiteatro_fogo_centro" "daniel_anfiteatro_fogo_superior" "daniel_anfiteatro_fogo_porta_esquerda" "daniel_anfiteatro_fogo_fileiras" "daniel_anfiteatro_fogo_centro_inferior"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_num_pedestrians/pedestres_no_ambiente_traversable_off_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 --traversable-off &
done

print_in_color "\033[0;34m" "Fire Experiment - daniel_anfiteatro - Sem fogo"
$RUN_COMMAND -o$dir_num_pedestrians/pedestres_no_ambiente_traversable_off_daniel_anfiteatro_no_fire.txt -m4 -edaniel_anfiteatro.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire --traversable-off &

for ambient in "silva_laboratory_fogo_corredor_centro" "silva_laboratory_fogo_corredor_direita" "silva_laboratory_fogo_corredor_esquerda" "silva_laboratory_fogo_fileiras_centro" "silva_laboratory_fogo_fileiras_esquerda" "silva_laboratory_fogo_meio"; do
    print_in_color "\033[0;34m" "Fire Experiment - $ambient"
    $RUN_COMMAND -o$dir_num_pedestrians/pedestres_no_ambiente_traversable_off_$ambient.txt -m4 -e$ambient.txt -O$OUT -s$SIMU --static-field=5 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --spread-rate=0.1 --kf=600 --traversable-off &
done

print_in_color "\033[0;34m" "Fire Experiment - silva_laboratory - Sem fogo"
$RUN_COMMAND -o$dir_num_pedestrians/pedstres_no_ambiente_traversable_off_silva_laboratory_no_fire.txt -m4 -esilva_laboratory.txt -O$OUT -s$SIMU --static-field=5 --kf=500 --ks=2 --kd=1 --delta=0.3 --alpha=0.3 --ignore-self-trace  --skip-new-particles-decay --allow-diagonal-movements --cooldown=5 --traversability=0.5 --no-fire --traversable-off &

wait