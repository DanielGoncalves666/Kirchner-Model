#ifndef CLI_PROCESSING_H
#define CLI_PROCESSING_H

#include<argp.h>
#include<stdbool.h>

#include"shared_resources.h"
#include"grid.h"

typedef struct{
    char full_command[600];
    char environment_filename[150];
    char output_filename[150];
    char auxiliary_filename[150];
    char dynamic_floor_field_filename[150];
    enum Output_Format output_format;
    enum Environment_Origin environment_origin;
    enum Simulation_Type simulation_type;
    Function_Status (*calculate_static_field)(Double_Grid a, bool b); // Pointer to the function that will be responsible for calculating the static floor field.
    bool write_to_file;
    bool show_debug_information;
    bool print_static_floor_field;
    bool print_dynamic_floor_field;
    bool show_simulation_set_info;
    bool immediate_exit;
    bool prevent_corner_crossing;
    bool allow_X_movement;
    bool allow_diagonal_movements;
    bool single_exit_flag;
    bool use_density; // Indicates if the number os pedestrians to be inserted (if the case) is to be based on the density or in the total_num_pedestrians.
    bool velocity_density_field; // Indicates if the dynamic field is defined as a velocity density field or not (i.e, a particle density field).
    bool ignore_latest_self_trace;
    bool skip_new_particles_decay;
    bool traversable_as_impassable; // Indicates if the traversable objects should be considered as impassable.
    int traversable_cooldown;
    double traversability_value;
    int global_line_number;
    int global_column_number;
    int num_simulations;
    int total_num_pedestrians;
    int seed;
    double diagonal;
    double alizadeh_alpha;
    double alpha;
    double delta;
    double ks;
    double kd;
    double density;
    double min;
    double max;
    double step;
} Command_Line_Args;

error_t parser_function(int key, char *arg, struct argp_state *state);
void extract_full_command(char *full_command, int key, char *arg);
double *obtain_varying_constant();

extern Command_Line_Args cli_args; // cli stands for command line interface
extern const char * argp_program_version;
extern const char doc[];
extern struct argp argp;

#endif