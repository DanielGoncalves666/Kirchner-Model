/* 
   File: fire_Field.c
   Author: Daniel Gonçalves
   Date: 15/09/2024
   Description: 
*/

#include<stdlib.h>

#include"../headers/fire.h"
#include"../headers/exit.h"
#include"../headers/grid.h"
#include"../headers/cli_processing.h"
#include"../headers/shared_resources.h"

typedef struct{
    int main_coordinate; // The coordinate that is common to all coordinates in the secondary_coordinates array.
    int *secondary_coordinates;
    int length; // number of secondary coordinates
}coordinate_set;

typedef struct{
    int length; // number of coordinate sets
    coordinate_set *sets;
}coordinate_set_collection;

// static void calculate_distance_from_cells_to_fire();
// static Function_Status add_to_coordinates_collection(coordinate_set_collection *collection, Location coordinates);
// static void extract_fire_coordinate_sets(coordinate_set_collection *collection, bool line_direction);
// static void deallocate_coordinate_sets(coordinate_set_collection collection);
// static Function_Status determine_adjacent_coordinate_sets(coordinate_set_collection collection, int coordinate, coordinate_set **neighbor_sets, int *num_neighbors);
// static Function_Status determine_adjacent_secondary_coordinates(coordinate_set *set, int coordinate, int *neighbor_coordinates, int *num_neighbors);

/**
 * Propagate the fire in the environment, in accordance with the Zheng's 2011 article.
 * 
 * @note This propagation doesn't respect diagonal obstacles, it will propagate through it.
 */
void zheng_fire_propagation()
{
    Int_Grid aux_grid = allocate_integer_grid(cli_args.global_line_number, cli_args.global_column_number);
    copy_integer_grid(aux_grid, obstacle_grid);
    
    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(obstacle_grid[i][j] != FIRE_CELL)
                continue;

            for(int mm = 0; mm < 8; mm++)
            {
                if( ! is_within_grid_lines(i + moore_neighbor_modifiers[mm].lin) || 
                    ! is_within_grid_columns(j + moore_neighbor_modifiers[mm].col))
                    continue;

                if(moore_neighbor_modifiers[mm].lin != 0 && moore_neighbor_modifiers[mm].col != 0){
                    if(!is_diagonal_valid((Location){i,j}, moore_neighbor_modifiers[mm], exits_set.static_floor_field)){
                        continue;
                    }
                }

                if( obstacle_grid[i + moore_neighbor_modifiers[mm].lin][j + moore_neighbor_modifiers[mm].col] == IMPASSABLE_OBJECT)
                    continue;

                aux_grid[i + moore_neighbor_modifiers[mm].lin][j + moore_neighbor_modifiers[mm].col] = FIRE_CELL;
            }
        }
    }
    
    copy_integer_grid(obstacle_grid, aux_grid);
    deallocate_grid((void **) aux_grid, cli_args.global_line_number);
}

/**
 * Calculates the distance of every cell to the closest fire using the Varas calculation
 */
void calculate_distance_to_fire(){

    double floor_field_rule[][3] = 
            {{1.0, 1.0, 1.0},
             {1.0, 1.0, 1.0},
             {1.0, 1.0, 1.0}};


    for(int i = 0; i < cli_args.global_line_number; i++){
        for(int j = 0; j < cli_args.global_column_number; j++){
            if(obstacle_grid[i][j] == IMPASSABLE_OBJECT)
                fire_distance_grid[i][j] = -1; // Exits are considered as impassable
            else if(obstacle_grid[i][j] == FIRE_CELL)
                fire_distance_grid[i][j] = 1;
            else
                fire_distance_grid[i][j] = 0;
        }
    }

    Double_Grid auxiliary_grid = allocate_double_grid(cli_args.global_line_number,cli_args.global_column_number);
    copy_double_grid(auxiliary_grid, fire_distance_grid); 

    bool has_changed;
    do
    {
        has_changed = false;
        for(int i = 0; i < cli_args.global_line_number; i++)
        {
            for(int h = 0; h < cli_args.global_column_number; h++)
            {
                double current_cell_value = fire_distance_grid[i][h];

                if(current_cell_value <= 0) 
                    continue;

                for(int j = -1; j < 2; j++)
                {
                    if(! is_within_grid_lines(i + j))
                        continue;
                    
                    for(int k = -1; k < 2; k++)
                    {
                        if(! is_within_grid_columns(h + k))
                            continue;

                        if(abs(fire_distance_grid[i + j][h + k]) == 1)// IMPASSABLE_OBJECT or FIRE_CELL
                            continue;

                        if(j != 0 && k != 0)
                        {
                            if(! is_diagonal_valid((Location){i,h},(Location){j,k}, exits_set.static_floor_field))
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
        copy_double_grid(fire_distance_grid, auxiliary_grid); 
        // make sure static_weight now holds t + 1 timestep, allowing auxiliary_grid to hold t + 2 timestep.
    }
    while(has_changed);

    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int h = 0; h < cli_args.global_column_number; h++)
        {
            if(fire_distance_grid[i][h] == -1)
                continue;

            fire_distance_grid[i][h] -=1;
        }
    }

    deallocate_grid((void **) auxiliary_grid, cli_args.global_line_number);
}



/**
 * Calculates the fire floor field in accordance with the 2011 Zheng's article specifications.
 */
void calculate_fire_floor_field()
{
    fill_double_grid(exits_set.fire_floor_field, cli_args.global_line_number, cli_args.global_column_number, 0);

    double sum_of_all_distances = 0;
    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(obstacle_grid[i][j] == IMPASSABLE_OBJECT || obstacle_grid[i][j] == FIRE_CELL)
                continue;

            exits_set.fire_floor_field[i][j] = 1.0 / fire_distance_grid[i][j];
            sum_of_all_distances += exits_set.fire_floor_field[i][j];
        }
    }

    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(obstacle_grid[i][j] == IMPASSABLE_OBJECT || obstacle_grid[i][j] == FIRE_CELL)
                continue;

            if(fire_distance_grid[i][j] > cli_args.fire_gamma){
                exits_set.fire_floor_field[i][j] = 0;
            }
            else
                exits_set.fire_floor_field[i][j] /= sum_of_all_distances;        
        }
    }
}

/**
 * Determines the dangerous cells in the environment, i.e., cells that are adjacent to fire cells, and risky cells, i.e., dangerous cells that are adjacent to an impassable obstacle.
 */
void determine_danger_cells(){
    
    fill_integer_grid(danger_cell_grid, cli_args.global_line_number, cli_args.global_column_number, EMPTY_CELL);
    
    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(obstacle_grid[i][j] == FIRE_CELL){
                danger_cell_grid[i][j] = FIRE_CELL;

                for(int h = -1; h < 2; h++){
                    for(int k = -1; k < 2; k++){
                        if(obstacle_grid[i + h][j + k] != FIRE_CELL && obstacle_grid[i + h][j + k] != IMPASSABLE_OBJECT){
                            danger_cell_grid[i][j] = DANGER_CELL;
                        }
                    }
                }
            }
        }
    }

    for(int i = 0; i < cli_args.global_line_number; i++)
    {
        for(int j = 0; j < cli_args.global_column_number; j++)
        {
            if(danger_cell_grid[i][j] == DANGER_CELL){
                for(int h = -1; h < 2; h++){
                    for(int k = -1; k < 2; k++){
                        if(obstacle_grid[i + h][j + k] == IMPASSABLE_OBJECT) // If there is an impassable obstacle in the Moore vicinity of the danger cell, then it is considered a risky cell.
                            danger_cell_grid[i][j] == RISKY_CELL;
                    }
                }
            }
        }
    }
}
