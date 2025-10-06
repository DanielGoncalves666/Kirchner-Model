#ifndef FIRE_H
#define FIRE_H

#include"shared_resources.h"
#include"grid.h"

void zheng_fire_propagation();
void calculate_distance_to_fire();
void calculate_fire_floor_field();
void determine_danger_cells();


#endif