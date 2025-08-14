/* 
   File: exit.c
   Author: Daniel Gonçalves
   Date: 2023-10-15
   Description: This module contains declarations of structures to hold exit information and functions to create/expand exits, add exits to the exits set, and calculate the floor field.
*/

#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>

#include"../headers/cell.h"
#include"../headers/exit.h"
#include"../headers/grid.h"
#include"../headers/pedestrian.h"
#include"../headers/cli_processing.h"
#include"../headers/shared_resources.h"

#include"../headers/printing_utilities.h"

Int_Grid exits_only_grid = NULL; // Grid containing only the exits.
                                 // Contains cells with either EXIT_CELL or EMPTY_CELL values.

Exits_Set exits_set = {NULL, NULL, NULL, 0};

static Exit create_new_exit(Location exit_coordinates);
static Function_Status calculate_static_weight(Exit current_exit, int grid_to_calculate, bool traversable_as_impassable);
static Function_Status calculate_dynamic_weight(Exit current_exit, bool traversable_as_impassable);
static Function_Status calculate_exit_floor_field(Exit current_exit, bool traversable_as_impassable);
static void initialize_static_weight_grid(Exit current_exit, int grid_to_calculate, bool traversable_as_impassable);
static void initialize_dynamic_weight_grid(Exit current_exit, bool traversable_as_impassable);
static Function_Status calculate_all_dynamic_weights(bool traversable_as_impassable);
static Function_Status calculate_all_exits_floor_field(bool traversable_as_impassable);
static void invert_grid(Double_Grid target_grid);
static bool is_exit_accessible(Exit current_exit, int grid_to_consider);
static int identify_occupied_cells(Cell **occupied_cells, Exit current_exit);

/**
 * Adds a new exit to the exits set.
 * 
 * @param exit_coordinates New exit coordinates.
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
*/
Function_Status add_new_exit(Location exit_coordinates)
{
    Exit new_exit = create_new_exit(exit_coordinates);
    if(new_exit == NULL)
    {
        fprintf(stderr,"Failure on creating an exit at coordinates (%d,%d).\n",exit_coordinates.lin, exit_coordinates.col);
        return FAILURE;
    }

    exits_set.num_exits += 1;
    exits_set.list = realloc(exits_set.list, sizeof(Exit) * exits_set.num_exits);
    if(exits_set.list == NULL)
    {
        fprintf(stderr, "Failure in the realloc of the exits_set list.\n");
        return FAILURE;
    }    

    exits_set.list[exits_set.num_exits - 1] = new_exit;

    return SUCCESS;
}

/**
 * Expands an existing exit by adding a new cell based on the provided coordinates.
 * 
 * @param original_exit Exit to be expanded.
 * @param new_coordinates Coordinates of the cell to be added to the exit. 
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
*/
Function_Status expand_exit(Exit original_exit, Location new_coordinates)
{
    if(is_within_grid_lines(new_coordinates.lin) && is_within_grid_columns(new_coordinates.col))
    {
        original_exit->width += 1;
        original_exit->coordinates = realloc(original_exit->coordinates, sizeof(Location) * original_exit->width);
        if(original_exit->coordinates == NULL)
            return FAILURE;

        original_exit->coordinates[original_exit->width - 1] = new_coordinates;

        return SUCCESS;
    }

    return FAILURE;
}

/**
 * Allocates the static_floor_field and dynamic_floor_field grids.
 * 
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
*/
Function_Status allocate_exits_set_fields()
{
    exits_set.static_floor_field = allocate_double_grid(cli_args.global_line_number, cli_args.global_column_number);
    exits_set.impassable_static_floor_field = allocate_double_grid(cli_args.global_line_number, cli_args.global_column_number);
    exits_set.dynamic_floor_field = allocate_integer_grid(cli_args.global_line_number, cli_args.global_column_number);
    if(exits_set.static_floor_field == NULL || exits_set.impassable_static_floor_field == NULL || exits_set.dynamic_floor_field == NULL)
    {
        fprintf(stderr,"Failure during the allocation of the static_floor_field and dynamic_floor_field.\n");
        return FAILURE;
    }

    return SUCCESS;
}

/**
 * Calculates the static floor field as described in Annex A of Kirchner's 2002 article.
 * 
 * @param target_grid The double grid where the calculation will be stored.
 * @param traversable_as_impassable A boolean, indicating if the traversable obstacles in the environment should be considered as impassable (True) or not (False).
 * 
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
 */
Function_Status calculate_original_kirchner_static_field(Double_Grid target_grid, bool traversable_as_impassable)
{
    int num_exit_cells = 0; // The total number of exit cells.
    Location *exit_cell_coordinates = NULL; // A list of all the exit cells coordinates.

    fill_double_grid(target_grid, cli_args.global_line_number, cli_args.global_column_number, -1);
    copy_grid_structure(target_grid, obstacle_grid); // Copies the structure of the environment

    // Assign a value of -1 to all exit cells. Cells marked with -1 will have their static floor field values calculated next.
    // Additionally, construct a list containing the coordinates of all exit cells to simplify further processing.
    for(int exit_index = 0; exit_index < exits_set.num_exits; exit_index++) 
    {
        Exit current_exit = exits_set.list[exit_index];
        for(int cell_index = 0; cell_index < current_exit->width; cell_index++)
        {
            Location current_cell = current_exit->coordinates[cell_index];
            target_grid[current_cell.lin][current_cell.col] = -1;

            exit_cell_coordinates = realloc(exit_cell_coordinates, sizeof(Location) * (num_exit_cells + 1));
            if(exit_cell_coordinates == NULL)
            {
                fprintf(stderr, "Failure in the realloc of the exit_cells_coordinates list.\n");
                return FAILURE;
            }

            exit_cell_coordinates[num_exit_cells] = current_cell;
            num_exit_cells++;
        }
    }

    double *max_values = calloc(num_exit_cells, sizeof(double));

    // Calculate the maximum value for all exits
    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(target_grid[i][j] == IMPASSABLE_OBJECT)
                continue;

            if(target_grid[i][j] == TRAVERSABLE_OBJECT)
            {
                if(traversable_as_impassable)
                {
                    target_grid[i][j] = IMPASSABLE_OBJECT; // TRAVERSABLE objects are turned into IMPASSABLE inside de static field
                    continue;
                }
                else
                    target_grid[i][j] = -1; // The TRAVERSABLE objects are turned into empty cells for the static field.
            }

            for(int cell_index = 0; cell_index < num_exit_cells; cell_index++)
            {
                Location current_exit_cell = exit_cell_coordinates[cell_index]; // The current exit cell being used as the reference.
                double distance_to_exit = euclidean_distance(current_exit_cell, (Location) {i,j});

                if(distance_to_exit > max_values[cell_index]){
                    max_values[cell_index] = distance_to_exit;
                }
            }
        }
    }

    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(target_grid[i][j] == IMPASSABLE_OBJECT)
                continue; 

            target_grid[i][j] = max_values[0] - euclidean_distance(exit_cell_coordinates[0], (Location) {i,j});
            for(int cell_index = 1; cell_index < num_exit_cells; cell_index++)
            {
                double next_distance = max_values[cell_index] - euclidean_distance(exit_cell_coordinates[cell_index], (Location) {i,j});
                if(next_distance < target_grid[i][j]){
                    target_grid[i][j] = next_distance;
                }
            }
            
        }
    }

    return SUCCESS;
}

/**
 * Calculates the static floor field as described in Annex A of Kirchner's 2002 article, with the addition of a normalization at the end.
 * The normalization used consists of the subtraction of the Maximum value obtained by the original description of the static field by the value of each cell.
 * 
 * @param target_grid The double grid where the calculation will be stored.
 * @param traversable_as_impassable A boolean, indicating if the traversable obstacles in the environment should be considered as impassable (True) or not (False).
 * 
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
 */
Function_Status calculate_normalized_original_kirchner_static_field(Double_Grid target_grid, bool traversable_as_impassable)
{
    int num_exit_cells = 0; // The total number of exit cells.
    Location *exit_cell_coordinates = NULL; // A list of all the exit cells coordinates.

    fill_double_grid(target_grid, cli_args.global_line_number, cli_args.global_column_number, -1);
    copy_grid_structure(target_grid, obstacle_grid); // Copies the structure of the environment

    // Assign a value of -1 to all exit cells. Cells marked with -1 will have their static floor field values calculated next.
    // Additionally, construct a list containing the coordinates of all exit cells to simplify further processing.
    for(int exit_index = 0; exit_index < exits_set.num_exits; exit_index++) 
    {
        Exit current_exit = exits_set.list[exit_index];
        for(int cell_index = 0; cell_index < current_exit->width; cell_index++)
        {
            Location current_cell = current_exit->coordinates[cell_index];
            target_grid[current_cell.lin][current_cell.col] = -1;

            exit_cell_coordinates = realloc(exit_cell_coordinates, sizeof(Location) * (num_exit_cells + 1));
            if(exit_cell_coordinates == NULL)
            {
                fprintf(stderr, "Failure in the realloc of the exit_cells_coordinates list.\n");
                return FAILURE;
            }

            exit_cell_coordinates[num_exit_cells] = current_cell;
            num_exit_cells++;
        }
    }

    double *max_values = calloc(num_exit_cells, sizeof(double));

    // Calculate the maximum value for all exits 
    for(int i = 0; i < cli_args.global_line_number; i++) 
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(target_grid[i][j] == IMPASSABLE_OBJECT)
                continue;

            if(target_grid[i][j] == TRAVERSABLE_OBJECT)
            {
                if(traversable_as_impassable)
                {
                    target_grid[i][j] = IMPASSABLE_OBJECT; // TRAVERSABLE objects are turned into IMPASSABLE inside de static field
                    continue;
                }
                else
                    target_grid[i][j] = -1; // The TRAVERSABLE objects are turned into empty cells for the static field.
            }

            for(int cell_index = 0; cell_index < num_exit_cells; cell_index++)
            {
                Location current_exit_cell = exit_cell_coordinates[cell_index]; // The current exit cell being used as the reference.
                double distance_to_exit = euclidean_distance(current_exit_cell, (Location) {i,j});

                if(distance_to_exit > max_values[cell_index]){
                    max_values[cell_index] = distance_to_exit;
                }
            }
        }
    }

    double max_final_value = -1;
    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(target_grid[i][j] == IMPASSABLE_OBJECT)
                continue; 

            target_grid[i][j] = max_values[0] - euclidean_distance(exit_cell_coordinates[0], (Location) {i,j});
            for(int cell_index = 1; cell_index < num_exit_cells; cell_index++)
            {
                double next_distance = max_values[cell_index] - euclidean_distance(exit_cell_coordinates[cell_index], (Location) {i,j});
                if(next_distance < target_grid[i][j]){
                    target_grid[i][j] = next_distance;
                }
            }
             
            if(target_grid[i][j] > max_final_value)
                max_final_value = target_grid[i][j];
        }
    }

    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(target_grid[i][j] == IMPASSABLE_OBJECT)
                continue; 

            target_grid[i][j] = max_final_value - target_grid[i][j];
        }
    }

    return SUCCESS;
}

/**
 * Calculates the alternative static floor field for the Kirchner Model.
 * 
 * @param target_grid The double grid where the calculation will be stored.
 * @param traversable_as_impassable A boolean, indicating if the traversable obstacles in the environment should be considered as impassable (True) or not (False).
 * 
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
 */
Function_Status calculate_alternative_kirchner_static_field(Double_Grid target_grid, bool traversable_as_impassable)
{
    int num_exit_cells = 0; // The total number of exit cells.
    Location *exit_cell_coordinates = NULL; // A list of all the exit cells coordinates.

    fill_double_grid(target_grid, cli_args.global_line_number, cli_args.global_column_number, -1);
    copy_grid_structure(target_grid, obstacle_grid); // Copies the structure of the environment

    // Assign a value of -1 to all exit cells. Cells marked with -1 will have their static floor field values calculated next.
    // Additionally, construct a list containing the coordinates of all exit cells to simplify further processing.
    for(int exit_index = 0; exit_index < exits_set.num_exits; exit_index++) 
    {
        Exit current_exit = exits_set.list[exit_index];
        for(int cell_index = 0; cell_index < current_exit->width; cell_index++)
        {
            Location current_cell = current_exit->coordinates[cell_index];
            target_grid[current_cell.lin][current_cell.col] = -1;

            exit_cell_coordinates = realloc(exit_cell_coordinates, sizeof(Location) * (num_exit_cells + 1));
            if(exit_cell_coordinates == NULL)
            {
                fprintf(stderr, "Failure in the realloc of the exit_cells_coordinates list.\n");
                return FAILURE;
            }

            exit_cell_coordinates[num_exit_cells] = current_cell;
            num_exit_cells++;
        }
    }

    double maximum_value = -1; // The maximum euclidean distance for any cell to an exit.
    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(target_grid[i][j] == IMPASSABLE_OBJECT)
                continue;

            if(target_grid[i][j] == TRAVERSABLE_OBJECT)
            {
                if(traversable_as_impassable)
                {
                    target_grid[i][j] = IMPASSABLE_OBJECT; // TRAVERSABLE objects are turned into IMPASSABLE inside de static field
                    continue;
                }
                else
                    target_grid[i][j] = -1; // The TRAVERSABLE objects are turned into empty cells for the static field.
            }

            for(int cell_index = 0; cell_index < num_exit_cells; cell_index++)
            {
                Location current_exit_cell = exit_cell_coordinates[cell_index]; // The current exit cell being used as the reference.
                double distance_to_exit = euclidean_distance(current_exit_cell, (Location) {i,j});

                if(target_grid[i][j] == -1 || distance_to_exit < target_grid[i][j])
                    target_grid[i][j] = distance_to_exit;
            }

            if(target_grid[i][j] > maximum_value)
                maximum_value = target_grid[i][j];
        }
    }

    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(target_grid[i][j] == IMPASSABLE_OBJECT)
                continue; 

            double normalized_distance = maximum_value - target_grid[i][j];
            target_grid[i][j] = normalized_distance;
        }
    }

    return SUCCESS;
}

/**
 * Calculates the inverted Varas static floor field. The largest values are placed at the exits, while the lowest are placed in the middle of the environment.
 *
 * @param target_grid The double grid where the calculation will be stored.
 * @param traversable_as_impassable A boolean, indicating if the traversable obstacles in the environment should be considered as impassable (True) or not (False).
 *
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
 */
Function_Status calculate_inverted_varas_static_field(Double_Grid target_grid, bool traversable_as_impassable)
{
    if(exits_set.num_exits <= 0 || exits_set.list == NULL || target_grid == NULL)
    {
        fprintf(stderr,"The number of exits (%d) is invalid, the exits list is NULL or the static_floor_field grid is NULL.\n", exits_set.num_exits);
        return FAILURE;
    }

    Double_Grid current_exit = exits_set.list[0]->static_weight;
    copy_double_grid(target_grid, current_exit); // uses the first exit as the base for the merging
    
    for(int exit_index = 1; exit_index < exits_set.num_exits; exit_index++)
    {
        current_exit = exits_set.list[exit_index]->static_weight;
        for(int i = 0; i < cli_args.global_line_number; i++)
        {
            for(int j = 0; j < cli_args.global_column_number; j++)
            {
                if(current_exit[i][j] == IMPASSABLE_OBJECT)
                    continue; // Ignore cells with obstacles in the current exit 

                if(target_grid[i][j] == IMPASSABLE_OBJECT)
                    target_grid[i][j] = current_exit[i][j];
                    // Cell was an obstacle in the first door, but an exit on another.

                if(current_exit[i][j] < target_grid[i][j])
                    target_grid[i][j] = current_exit[i][j];
            }
        }
    }

    invert_grid( target_grid);

    return SUCCESS;
}

/**
 * Calculates the inverted Alizadeh Floor Field. The largest values are placed at the exits, while the lowest are placed in the middle of the environment.
 *  
 * @note The static weight calculation for normal and traversable as impassable must be calculated before this function is called.
 *  
 * @param target_grid The double grid where the calculation will be stored.
 * @param traversable_as_impassable A boolean, indicating on which static_floor_field the result of the combination of the exits floor fields should be stored. If true, stores in the impassable_static_floor_field, otherwise in the static_floor_field.
 * 
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
*/
Function_Status calculate_inverted_alizadeh_static_field(Double_Grid target_grid, bool traversable_as_impassable)
{
    if(exits_set.num_exits <= 0 || exits_set.list == NULL || target_grid == NULL)
    {
        fprintf(stderr,"The number of exits (%d) is invalid or the exits_set structure has at least one NULL value.\n", exits_set.num_exits);
        return FAILURE;
    }

    if( fill_double_grid(target_grid, cli_args.global_line_number, cli_args.global_column_number, 0) == FAILURE)
        return FAILURE;

    if( calculate_all_dynamic_weights(traversable_as_impassable) == FAILURE) // Dynamic fields calculated by the Alizadeh definition.
        return FAILURE;

    if( calculate_all_exits_floor_field(traversable_as_impassable) == FAILURE) // Alizadeh floor field calculation
        return FAILURE;
        
    Double_Grid current_exit = exits_set.list[0]->floor_field;
    copy_double_grid(target_grid, current_exit); // uses the first exit as the base for the merging
    
    for(int exit_index = 1; exit_index < exits_set.num_exits; exit_index++)
    {
        current_exit = exits_set.list[exit_index]->floor_field;
        for(int i = 0; i < cli_args.global_line_number; i++)
        {
            for(int h = 0; h < cli_args.global_column_number; h++)
            {
                if(current_exit[i][h] == IMPASSABLE_OBJECT && target_grid[i][h] != IMPASSABLE_OBJECT)
                    continue;

                if(current_exit[i][h] != IMPASSABLE_OBJECT && target_grid[i][h] == IMPASSABLE_OBJECT)
                {
                    target_grid[i][h] = current_exit[i][h];
                    continue;
                }

                if(target_grid[i][h] > current_exit[i][h])
                    target_grid[i][h] = current_exit[i][h];
            }
        }
    }

    if(cli_args.print_static_floor_field){
        printf("Original Alizadeh Static Floor Field (before inversion):\n");
        print_double_grid(target_grid);
    }

    invert_grid(target_grid);

    return SUCCESS;
}

/**
 * Calculates the static weights (both) of every exit in the exits_set.
 * 
 * @param traversable_as_impassable A boolean, indicating if the traversable obstacles in the environment should be considered as impassable (True) or not (False).
 * 
 * @return Function_Status: FAILURE (0), SUCCESS (1) or INACCESSIBLE_EXIT(2).
*/
Function_Status calculate_all_static_weights(bool traversable_as_impassable)
{
    if(exits_set.num_exits <= 0 || exits_set.list == NULL)
    {
        fprintf(stderr,"The number of exits (%d) is invalid or the exits list is NULL.\n", exits_set.num_exits);
        return FAILURE;
    }

    Function_Status returned_status;

    for(int exit_index = 0; exit_index < exits_set.num_exits; exit_index++)
    {
        // normal static_weight
        returned_status = calculate_static_weight(exits_set.list[exit_index], NORMAL_STATIC_WEIGHT, traversable_as_impassable); 
        if(returned_status != SUCCESS )
            return returned_status;

        // impassable_static_weight
        returned_status = calculate_static_weight(exits_set.list[exit_index], IMPASSABLE_STATIC_WEIGHT, traversable_as_impassable); 
        if(returned_status != SUCCESS )
            return returned_status;
    }

    return SUCCESS;
}

/**
 * Deallocate and reset the structures related to each exit and the exists set.
*/
void deallocate_exits()
{
    for(int exit_index = 0; exit_index < exits_set.num_exits; exit_index++)
    {
        Exit current = exits_set.list[exit_index];

        free(current->coordinates);
        deallocate_grid((void **) current->static_weight, cli_args.global_line_number);
        free(current);
    }

    free(exits_set.list);
    exits_set.list = NULL;

    deallocate_grid((void **) exits_set.static_floor_field, cli_args.global_line_number);
    deallocate_grid((void **) exits_set.impassable_static_floor_field, cli_args.global_line_number);
    deallocate_grid((void **) exits_set.dynamic_floor_field, cli_args.global_line_number);
    exits_set.static_floor_field = NULL;
    exits_set.impassable_static_floor_field = NULL;
    exits_set.dynamic_floor_field = NULL;

    exits_set.num_exits = 0;
}

/* ---------------- ---------------- ---------------- ---------------- ---------------- */
/* ---------------- ---------------- STATIC FUNCTIONS ---------------- ---------------- */
/* ---------------- ---------------- ---------------- ---------------- ---------------- */

/**
 * Creates a new exit structure based on the provided Location.
 * 
 * @param exit_coordinates New exit coordinates.
 * @return A NULL pointer, on error, or a Exit structure if the new exit is successfully created.
*/
static Exit create_new_exit(Location exit_coordinates)
{
    if(is_within_grid_lines(exit_coordinates.lin) && is_within_grid_columns(exit_coordinates.col))
    {
        Exit new_exit = malloc(sizeof(struct exit));
        if(new_exit != NULL)
        {
            new_exit->coordinates = malloc(sizeof(Location));
            if(new_exit->coordinates == NULL)
                return NULL;
            
            new_exit->coordinates[0] = exit_coordinates;
            new_exit->width = 1;

            new_exit->static_weight = allocate_double_grid(cli_args.global_line_number, cli_args.global_column_number);
            new_exit->impassable_static_weight = allocate_double_grid(cli_args.global_line_number, cli_args.global_column_number);
            new_exit->alizadeh_dynamic_weight = allocate_double_grid(cli_args.global_line_number, cli_args.global_column_number);
            new_exit->floor_field = allocate_double_grid(cli_args.global_line_number, cli_args.global_column_number);
        }

        return new_exit;
    }

    return NULL;
}

/**
 * Calculates the static weights for the given exit.
 * 
 * @param current_exit Exit for which the static weights will be calculated.
 * @param grid_to_calculate An integer, indicating which static_weight to calculate.    
 *                          0 for the normal static_weight, or any other value for the impassable_static_weight.
 *                          In the former the status of the traversable objects are determined by the traversable_as_impassable argument and the latter always 
 *                              considers traversable objects as impassable.
 * @param traversable_as_impassable A boolean, indicating if the traversable obstacles in the environment should be considered as impassable (True) or not (False).
 * 
 * @return Function_Status: FAILURE (0), SUCCESS (1) or INACCESSIBLE_EXIT(2).
*/
static Function_Status calculate_static_weight(Exit current_exit, int grid_to_calculate, bool traversable_as_impassable)
{
    double floor_field_rule[][3] = 
            {{cli_args.diagonal,    1.0,    cli_args.diagonal},
             {       1.0,           0.0,           1.0       },
             {cli_args.diagonal,    1.0,    cli_args.diagonal}};

    initialize_static_weight_grid(current_exit, grid_to_calculate, traversable_as_impassable);
    
    if(is_exit_accessible(current_exit, grid_to_calculate || traversable_as_impassable) == false)
    return INACCESSIBLE_EXIT;
             
    Double_Grid static_weight = grid_to_calculate ? current_exit->impassable_static_weight : current_exit->static_weight;
    Double_Grid auxiliary_grid = allocate_double_grid(cli_args.global_line_number,cli_args.global_column_number);
    // stores the chances for the timestep t + 1

    if(auxiliary_grid == NULL)
    {
        fprintf(stderr, "Failure to allocate the auxiliary_grid at calculate_static_weight.\n");
        return FAILURE;
    }

    copy_double_grid(auxiliary_grid, static_weight); // copies the base structure of the floor field

    bool has_changed;
    do
    {
        has_changed = false;
        for(int i = 0; i < cli_args.global_line_number; i++)
        {
            for(int h = 0; h < cli_args.global_column_number; h++)
            {
                double current_cell_value = static_weight[i][h];

                if(current_cell_value == IMPASSABLE_OBJECT || current_cell_value == 0.0) // floor field calculations occur only on cells with values
                    continue;

                for(int j = -1; j < 2; j++)
                {
                    if(! is_within_grid_lines(i + j))
                        continue;
                    
                    for(int k = -1; k < 2; k++)
                    {
                        if(! is_within_grid_columns(h + k))
                            continue;

                        if(static_weight[i + j][h + k] == IMPASSABLE_OBJECT || static_weight[i + j][h + k] == EXIT_CELL)
                            continue;

                        if(j != 0 && k != 0)
                        {
                            if(! is_diagonal_valid((Location){i,h},(Location){j,k},static_weight))
                                continue;
                        }

                        double adjacent_cell_value = current_cell_value + floor_field_rule[1 + j][1 + k];
                        if(auxiliary_grid[i + j][h + k] == 0.0)
                        {    
                            auxiliary_grid[i + j][h + k] = adjacent_cell_value;
                            has_changed = true;
                        }
                        else if(adjacent_cell_value < auxiliary_grid[i + j][h + k])
                        {
                            auxiliary_grid[i + j][h + k] = adjacent_cell_value;
                            has_changed = true;
                        }
                    }
                }
            }
        }
        copy_double_grid(static_weight,auxiliary_grid); 
        // make sure static_weight now holds t + 1 timestep, allowing auxiliary_grid to hold t + 2 timestep.
    }
    while(has_changed);

    deallocate_grid((void **) auxiliary_grid, cli_args.global_line_number);

    return SUCCESS;
}

/**
 * Calculates the dynamic weights for the given exit.
 * 
 * @note To ensure that the Final Floor Field matches the examples provided in the Alizadeh article, the division by 2 on the num_cells_equal_value needs to be removed.
 * 
 * @param current_exit Exit for which the dynamic weights will be calculated.
 * @param traversable_as_impassable A boolean, indicating if the static weight grid to be considered is the standard or the one with the traversable objects considered as impassable (impassable_static_weight).
 * 
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
*/
static Function_Status calculate_dynamic_weight(Exit current_exit, bool traversable_as_impassable)
{
    Cell *occupied_cells = NULL;

    int num_occupied_cells = identify_occupied_cells(&occupied_cells, current_exit);
    if(num_occupied_cells == -1)
        return FAILURE;
    
    quick_sort(occupied_cells, 0, num_occupied_cells - 1);
    
    initialize_dynamic_weight_grid(current_exit, traversable_as_impassable);
    Double_Grid dynamic_weight = current_exit->alizadeh_dynamic_weight;
    Double_Grid static_weight = traversable_as_impassable ? current_exit->impassable_static_weight : current_exit->static_weight; 

    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int h = 0; h < cli_args.global_column_number; h++)
        {
            if(dynamic_weight[i][h] == -1)
                continue;

            double static_weight_value = static_weight[i][h];

            int num_cells_equal_value = 0;
            int num_cells_smaller_value = count_cells_with_smaller_value(occupied_cells, num_occupied_cells, 
                static_weight_value, &num_cells_equal_value);

            if(num_cells_smaller_value == -1)
                num_cells_smaller_value = 0; // Not a single cell smaller than the current static_weight_value.

            dynamic_weight[i][h] = (num_cells_smaller_value + num_cells_equal_value) / (double) current_exit->width;
        }
    }

    free(occupied_cells);

    return SUCCESS;
}

/**
 * Combines the static and dynamic weights into the floor field for the given exit.
 * 
 * @note Before calling this function, it is imperative that the static weights of the given exit have already been calculated.
 * 
 * @param current_exit Exit for which the floor field will be calculated.
 * @param traversable_as_impassable A boolean, indicating if the static weight grid to be considered is the standard or the one with the traversable objects considered as impassable (impassable_static_weight).
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
*/
static Function_Status calculate_exit_floor_field(Exit current_exit, bool traversable_as_impassable)
{
    if(current_exit == NULL)
    {
        fprintf(stderr, "A Null pointer was received in 'calculate_exit_floor_field' instead of a valid Exit.\n");
        return FAILURE;
    }

    Double_Grid static_weight = traversable_as_impassable ? current_exit->impassable_static_weight : current_exit->static_weight;

    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int h = 0; h < cli_args.global_column_number; h++)
        {
            if(current_exit->alizadeh_dynamic_weight[i][h] == -1) // Cells with no dynamic weight (obstacles and walls).
                current_exit->floor_field[i][h] = static_weight[i][h];
            else
                current_exit->floor_field[i][h] = static_weight[i][h] + cli_args.alpha * current_exit->alizadeh_dynamic_weight[i][h];
        }
    }

    return SUCCESS;
}

/**
 * Calculates the dynamic weights of every exit in the exits_set.
 * 
 * @param traversable_as_impassable A boolean, indicating if the traversable obstacles in the environment should be considered as impassable (True) or not (False).
 * 
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
*/
static Function_Status calculate_all_dynamic_weights(bool traversable_as_impassable)
{
    if(exits_set.num_exits <= 0 || exits_set.list == NULL)
    {
        fprintf(stderr,"The number of exits (%d) is invalid or the exits list is NULL.\n", exits_set.num_exits);
        return FAILURE;
    }

    for(int exit_index = 0; exit_index < exits_set.num_exits; exit_index++)
    {
        if(calculate_dynamic_weight(exits_set.list[exit_index], traversable_as_impassable) == FAILURE)
            return FAILURE;
    }

    return SUCCESS;
}

/**
 * Calculates the floor field of every exit in the exits_set.
 * 
 * @param traversable_as_impassable A boolean, indicating if the traversable obstacles in the environment should be considered as impassable (True) or not (False).
 * 
 * @return Function_Status: FAILURE (0) or SUCCESS (1).
*/
static Function_Status calculate_all_exits_floor_field(bool traversable_as_impassable)
{
    if(exits_set.num_exits <= 0 || exits_set.list == NULL)
    {
        fprintf(stderr,"The number of exits (%d) is invalid or the exits list is NULL.\n", exits_set.num_exits);
        return FAILURE;
    }

    for(int exit_index = 0; exit_index < exits_set.num_exits; exit_index++)
    {
        if(calculate_exit_floor_field(exits_set.list[exit_index], traversable_as_impassable) == FAILURE)
            return FAILURE;
    }

    return SUCCESS;
}

/**
 * Copies the structure (obstacles and walls) from the obstacle_grid to the static weight grid 
 * for the provided exit. Additionally, adds the exit cells to it.
 * 
 * @param current_exit The exit for which the static weights will be initialized.
 * @param grid_to_calculate An integer, indicating which static_weight to initialize.    
 *                          0 for the normal static_weight, or any other value for the impassable_static_weight.
 *                          In the former the status of the traversable objects are determined by the traversable_as_impassable argument and the latter always 
 *                              considers traversable objects as impassable.
 * @param traversable_as_impassable A boolean, indicating if the traversable obstacles in the environment should be considered as impassable (True) or not (False).
*/
static void initialize_static_weight_grid(Exit current_exit, int grid_to_calculate, bool traversable_as_impassable)
{
    Double_Grid static_weight = grid_to_calculate ? current_exit->impassable_static_weight : current_exit->static_weight;

    // Add walls and obstacles to the static weight grid.
    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int h = 0; h < cli_args.global_column_number; h++)
        {
            double cell_value = obstacle_grid[i][h];
            if(cell_value == IMPASSABLE_OBJECT)
                static_weight[i][h] = IMPASSABLE_OBJECT;
            else if((traversable_as_impassable || grid_to_calculate == IMPASSABLE_STATIC_WEIGHT) && cell_value == TRAVERSABLE_OBJECT)
                static_weight[i][h] = IMPASSABLE_OBJECT;
            else
                static_weight[i][h] = 0.0; // Traversable objects are ignored for the calculation of the static field (if they aren't considered as IMPASSABLE).
        }
    }

    // Add the exit cells to the static weight grid.
    for(int i = 0; i < current_exit->width; i++)
    {
        Location exit_cell = current_exit->coordinates[i];

        static_weight[exit_cell.lin][exit_cell.col] = EXIT_CELL;
    }
}

/**
 * Adds an indicator (-1) to the dynamic weight grid to ensure that the positions occupied by obstacles or walls do not have the dynamic weight calculated.
 * 
 * @param traversable_as_impassable A boolean, indicating if the traversable obstacles in the environment should be considered as impassable (True) or not (False).
 * 
 * @param current_exit The exit for which the dynamic weights will be initialized.
*/
static void initialize_dynamic_weight_grid(Exit current_exit, bool traversable_as_impassable)
{
    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int h = 0; h < cli_args.global_column_number; h++)
        {
            double cell_value = obstacle_grid[i][h];
            if(cell_value == IMPASSABLE_OBJECT || (cell_value == TRAVERSABLE_OBJECT && traversable_as_impassable))
                current_exit->alizadeh_dynamic_weight[i][h] = -1;
            else
                current_exit->alizadeh_dynamic_weight[i][h] = 0.0;
        }
    }

    // Add the exit cells to the dynamic weight grid.
    for(int i = 0; i < current_exit->width; i++)
    {
        Location exit_cell = current_exit->coordinates[i];

        current_exit->alizadeh_dynamic_weight[exit_cell.lin][exit_cell.col] = 0.0;
    }
}

/**
 * Inverts the contents of the given grid in a way that the greatest value will become the lowest and vice-versa.
 * 
 * @param target_grid The grid whose content will be inverted.
 * @param traversable_as_impassable A boolean, indicating if the traversable obstacles in the environment should be considered as impassable (True) or not (False).
 */
static void invert_grid(Double_Grid target_grid){
    
    double max_value = -1; // Every value in the environment (with exception of the walls, that are ignored) have values above 0
    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            // TRAVERSABLE_OBJECT check just in case.
            if(target_grid[i][j] == IMPASSABLE_OBJECT || target_grid[i][j] == TRAVERSABLE_OBJECT)
                continue;

            if(target_grid[i][j] > max_value)
                max_value = target_grid[i][j];
        }
    }

    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(target_grid[i][j] == IMPASSABLE_OBJECT || target_grid[i][j] == TRAVERSABLE_OBJECT)
                continue; 

            // MAX_VALUE - CELL_VALUE
            double inverted_static_field_value = max_value - target_grid[i][j];
            target_grid[i][j] = inverted_static_field_value;
        }
    }
}

/**
 * Verify if the given exit is accessible.
 * 
 * @note An exit is accessible if there is, at least, one adjacent empty cell in the vertical or horizontal directions. 
 * 
 * @param current_exit The exit that will be verified.
 * @param grid_to_consider An integer, indicating which static_weight to consider.    
 *                          0 for the normal static_weight, or any other value for the impassable_static_weight.
 * @return bool, where True indicates tha the given exit is accessible, or False otherwise.
*/
static bool is_exit_accessible(Exit current_exit, int grid_to_consider)
{
    if(current_exit == NULL)
        return false;

    Double_Grid static_weight = grid_to_consider ? current_exit->impassable_static_weight : current_exit->static_weight;

    for(int exit_cell_index = 0; exit_cell_index < current_exit->width; exit_cell_index++)
    {
        Location c = current_exit->coordinates[exit_cell_index];

        for(int j = -1; j < 2; j++)
        {
            if(! is_within_grid_lines(c.lin + j))
                continue;

            for(int k = -1; k < 2; k++)
            {
                if(! is_within_grid_columns(c.col + k))
                    continue;

                if(static_weight[c.lin + j][c.col + k] == IMPASSABLE_OBJECT || static_weight[c.lin + j][c.col + k] == EXIT_CELL)
                    continue;

                if(j != 0 && k != 0)
                    continue; // diagonals

                return true;
            }
        }
    }

    return false;
}

/**
 * Identify the cells occupied by a pedestrian still in the environment and adds Cell structures with its locations and static weights to the given list.
 * 
 * @param occupied_cells A pointer to a list of Cell structures, where the Cell structures referring to occupied cells will be appended.
 * @param current_exit The exit from which the static weight values will be obtained for the occupied cells.
 * 
 * @return An integer, indicating the number of occupied cells or -1, in case of a failure.
*/
static int identify_occupied_cells(Cell **occupied_cells, Exit current_exit)
{
    int num_occupied_cells = 0;

    for(int p_index = 0; p_index < pedestrian_set.num_pedestrians; p_index++)
    {
        if(pedestrian_set.list[p_index]->state == GOT_OUT)
            continue;

        *occupied_cells = realloc(*occupied_cells, sizeof(Cell) * (num_occupied_cells + 1));
        if(*occupied_cells == NULL)
        {
            fprintf(stderr, "Failure during reallocation of the occupied_cells list in identify_occupied_cells.\n");
            return -1;
        }

        Location pedestrian_location = pedestrian_set.list[p_index]->current;

        (*occupied_cells)[num_occupied_cells].coordinates = pedestrian_location;
        (*occupied_cells)[num_occupied_cells].value = current_exit->static_weight[pedestrian_location.lin][pedestrian_location.col];

        num_occupied_cells++;
    }

    return num_occupied_cells;
}
