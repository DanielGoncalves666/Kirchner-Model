#ifndef FIRE_H
#define FIRE_H

#include"shared_resources.h"
#include"grid.h"

void zheng_fire_propagation();
void calculate_distance_to_fire();

void determine_risky_cells();
void calculate_fire_floor_field();

extern Double_Grid fire_distance_grid;
extern Int_Grid fire_grid;
extern Int_Grid initial_fire_grid;
extern Int_Grid risky_cells_grid;

#endif