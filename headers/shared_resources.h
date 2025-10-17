#ifndef SHARED_RESOURCES_H
#define SHARED_RESOURCES_H

#include<stdbool.h>

enum Simulation_Type {
    SIMULATION_DENSITY = 0,
    SIMULATION_ALPHA,
    SIMULATION_DELTA,
    SIMULATION_STATIC_COUPLING,
    SIMULATION_DYNAMIC_COUPLING,
    SIMULATION_FIRE_COUPLING,
    SIMULATION_DOOR_LOCATION_ONLY
};
// All simulation types support the variation of door location.

enum Output_Format {
    OUTPUT_VISUALIZATION = 1, 
    OUTPUT_TIMESTEPS_COUNT, 
    OUTPUT_HEATMAP,
    OUTPUT_TRAVERSABLE_FAILS,
    OUTPUT_TRAVERSABLE_SUCCESSES,
    OUTPUT_DEAD_PEDESTRIANS,
    OUTPUT_PEDESTRIANS_BY_TIMESTEP,
    OUTPUT_DEAD_BY_TIMESTEP,
};

enum Environment_Origin {
    ONLY_STRUCTURE = 1, 
    STRUCTURE_AND_DOORS, 
    STRUCTURE_AND_PEDESTRIANS, 
    STRUCTURE_DOORS_AND_PEDESTRIANS, 
    AUTOMATIC_CREATED
};

enum Static_Field_Method {
    KIRCHNER_ALTERNATIVE_STATIC_FIELD = 1,
    KIRCHNER_ORIGINAL_STATIC_FIELD,
    KIRCHNER_NORMALIZED_ORIGINAL_STATIC_FIELD,
    INVERTED_VARAS_STATIC_FIELD,
    INVERTED_ALIZADEH_STATIC_FIELD
};

enum Static_Weight_Grid {
    NORMAL_STATIC_WEIGHT = 0,
    IMPASSABLE_STATIC_WEIGHT
};

typedef enum Function_Status {
    FAILURE = 0, 
    END_PROGRAM = 0,
    SUCCESS = 1, 
    INACCESSIBLE_EXIT = 2
}Function_Status;

typedef struct{
    int lin;
    int col;
}Location;

#define TOLERANCE 1E-10
#define CELL_LENGTH 0.4
#define TIMESTEP_TIME (4.0 / 15)

#define IMPASSABLE_OBJECT -1000
#define TRAVERSABLE_OBJECT -1001
#define EXIT_CELL 1 // The exit value in the Varas article.
#define EMPTY_CELL -1002
#define FIRE_CELL -1003
#define DANGER_CELL -1004 // Cell adjacent to a fire that isn't a risky cell.
#define RISKY_CELL -1005 //  Cell between a fire and a wall.

#define IMPASSABLE_OBSC_TRAVERSABILITY 0 
// #define HARD_OBSC_TRAVERSABILITY 0.3 
//#define MEDIUM_OBSC_TRAVERSABILITY 0.6 
// #define EASY_OBSC_TRAVERSABILITY 0.9 
#define EMPTY_CELL_TRAVERSABILITY 1 

bool origin_uses_auxiliary_data();
bool origin_uses_static_pedestrians();
bool origin_uses_static_exits();
bool are_same_coordinates(Location first, Location second);
double euclidean_distance(Location first, Location second);
float rand_within_limits(float min, float max);
bool probability_test(double probability);
int roulette_wheel_selection(double *probability_list, int length, double total_probability);

extern Location von_neumann_neighbor_modifiers[4];
extern Location moore_neighbor_modifiers[8];

#endif