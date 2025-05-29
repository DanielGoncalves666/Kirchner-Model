#ifndef EXIT_H
#define EXIT_H

#include"shared_resources.h"
#include"grid.h"

struct exit {
    int width; // in contiguous cells
    Location *coordinates; // cells that form up the exit
    Double_Grid static_weight;
    Double_Grid impassable_static_weight;
    Double_Grid alizadeh_dynamic_weight;
    Double_Grid floor_field; // Temporarily holds the Alizadeh field for a given combination of the alizadeh_dynamic_weight with one of the static_weight grids.
};
typedef struct exit * Exit;

typedef struct{
    Double_Grid static_floor_field;
    Double_Grid impassable_static_floor_field; // Static field considering traversable obstacles as impassable.
    Int_Grid dynamic_floor_field;
    Exit *list;
    int num_exits;
} Exits_Set;

Function_Status add_new_exit(Location exit_coordinates);
Function_Status expand_exit(Exit original_exit, Location new_coordinates);
Function_Status allocate_exits_set_fields();
Function_Status calculate_kirchner_static_field(Double_Grid target_grid, bool traversable_as_impassable);
Function_Status calculate_inverted_varas_static_field(Double_Grid target_grid, bool traversable_as_impassable);
Function_Status calculate_inverted_alizadeh_static_field(Double_Grid target_grid, bool traversable_as_impassable);
Function_Status calculate_all_static_weights(bool traversable_as_impassable);
void deallocate_exits();

extern Int_Grid exits_only_grid;
extern Exits_Set exits_set;

#endif