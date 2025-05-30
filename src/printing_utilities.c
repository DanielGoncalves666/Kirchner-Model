/* 
   File: printing_utilities.c
   Author: Daniel Gonçalves
   Date: 2023-10-15
   Description: This module contains functions to print some of the data generated by the simulations.
*/

#include<stdio.h>
#include<string.h>
#include<time.h>

#include"../headers/exit.h"
#include"../headers/pedestrian.h"
#include"../headers/cli_processing.h"
#include"../headers/printing_utilities.h"
#include"../headers/shared_resources.h"

/**
 * Print the command received by CLI on the provided stream.
 * 
 * @param output_stream Stream where the data will be written.
*/
void print_full_command(FILE *output_stream)
{
	if(output_stream != NULL)
	{
		fprintf(output_stream, "./kirchner.sh%s", cli_args.full_command);
		fprintf(output_stream,"\n--------------------------------------------------------------\n\n");
	}
	else
		fprintf(stderr, "No valid stream was provided at print_full_command.\n");
}

/**
 * Print the heatmap grid on the provided stream.
 * 
 * @note The value of each position of the grid is divided by the number of simulations in order to achieve the mean of all simulations.
 * 
 * @param output_stream Stream where the data will be written.
*/
void print_heatmap(FILE *output_stream)
{
	if(output_stream != NULL)
	{
		for(int i = 0; i < cli_args.global_line_number; i++){
			for(int h = 0; h < cli_args.global_column_number; h++)
				fprintf(output_stream, "%.2lf ", (double) heatmap_grid[i][h] / (double) cli_args.num_simulations);

			fprintf(output_stream,"\n");
		}
		fprintf(output_stream,"\n");
	}
	else
		fprintf(stderr, "No valid stream was provided at print_heatmap.\n");
}

/**
 * Print the pedestrian position grid (with emojis instead of values) on the provided stream.
 * 
 * @param output_stream Stream where the data will be written.
 * @param simulation_number Current simulation index
 * @param timestep Current simulation timestep.
*/
void print_pedestrian_position_grid(FILE *output_stream, int simulation_number, int timestep)
{
	if(!cli_args.write_to_file)
		printf("\e[1;1H\e[2J");

	fprintf(output_stream,"Simulation %d - timestep %d\n\n",simulation_number, timestep);

	if(output_stream != NULL)
	{
		for(int i = 0; i < cli_args.global_line_number; i++){
			for(int j = 0; j < cli_args.global_column_number; j++)
			{
				if(pedestrian_position_grid[i][j] != 0)
					fprintf(output_stream,"👤");
				else if(exits_only_grid[i][j] == EXIT_CELL)
					fprintf(output_stream,"🚪");
				else if(exits_set.static_floor_field[i][j] == IMPASSABLE_OBJECT)
					fprintf(output_stream,"🧱");
				// else if(obstacle_grid[i][j] == TRAVERSABLE_OBJECT && obstacle_traversability_grid[i][j] == EASY_OBSC_TRAVERSABILITY)
				// 	fprintf(output_stream,"🪑");
				else if(obstacle_grid[i][j] == TRAVERSABLE_OBJECT && obstacle_traversability_grid[i][j] == MEDIUM_OBSC_TRAVERSABILITY)
					fprintf(output_stream,"📋");
				// else if(obstacle_grid[i][j] == TRAVERSABLE_OBJECT && obstacle_traversability_grid[i][j] == HARD_OBSC_TRAVERSABILITY)
				// 	fprintf(output_stream,"🗄️");
				else if(pedestrian_position_grid[i][j] == 0)
					fprintf(output_stream,"⬛");
			}
			fprintf(output_stream,"\n");
		}
		fprintf(output_stream,"\n");
	}
	else
		fprintf(stderr, "No valid stream was provided at print_pedestrian_position_grid.\n");		
}

/**
 * Print the integer grid to stdout.
 * 
 * @param int_grid Integer grid to be printed.
*/
void print_int_grid(Int_Grid int_grid)
{
	for(int i = 0; i < cli_args.global_line_number; i++){
		for(int h = 0; h < cli_args.global_column_number; h++){
			printf("%3d ", int_grid[i][h]);
		}
		printf("\n\n");
	}
	printf("\n");
}

/**
 * Print the double grid to stdout.
 * 
 * @param double_grid Double grid to be printed.
*/
void print_double_grid(Double_Grid double_grid)
{
	for(int i = 0; i < cli_args.global_line_number; i++){
		for(int h = 0; h < cli_args.global_column_number; h++){
			if(double_grid[i][h] <= -1000.0)
				printf("%5.0lf ", double_grid[i][h]);
			else
				printf("%5.1lf ", double_grid[i][h]);
		}
		printf("\n\n");
	}
	printf("\n");
}


/**
 * Print information about the exits of a simulation set.
 * 
 * @param output_stream Stream where the data will be written.
*/
void print_simulation_set_information(FILE *output_stream)
{
	char separator = ',';
    char aggregator = '+';

	if(output_stream != NULL)
	{
		fprintf(output_stream, "Simulation set:");
		for(int exit_index = 0; exit_index < exits_set.num_exits; exit_index++)
		{
			if(exit_index == exits_set.num_exits - 1)
				separator = '.';

			Exit current_exit = exits_set.list[exit_index];
			
			int exit_width = current_exit->width;
			for(int cell_index = 0; cell_index < exit_width; cell_index++)
			{ 
				Location cell = current_exit->coordinates[cell_index];
				fprintf(output_stream, " %d %d%c", cell.lin, cell.col, 
										cell_index == exit_width - 1 ? separator : aggregator);
			}

		}

		fprintf(output_stream, "\n");
	}
	else
		fprintf(stderr, "No valid stream was provided at print_simulation_set_information.\n");
}

/**
 * Print a status message about the execution of the program to stdout.
 * 
 * @param set_index Current simulation set index.
 * @param set_quantity The number of simulations sets.
*/
void print_execution_status(int set_index, int set_quantity)
{
	char date_time[51];
            
	time_t current_time = time(NULL);
	struct tm * time_information = localtime(&current_time);
	
	if(set_index != 0)
	{
		fprintf(stdout, "\033[A\033[2K");
		fflush(stdout);
	}
	
	strftime(date_time,50,"%F %Z %T",time_information);
	fprintf(stdout, "Simulation set %5d/%d finalized at %s.\n", set_index + 1, set_quantity, date_time);
}

/**
 * Print a status message about the execution of the program to stdout.
 * 
 * @param value Current varying value.
 * @param max_value Max varying value.
*/
void print_varying_execution_status(double value, double max_value)
{
	char date_time[51];
            
	time_t current_time = time(NULL);
	struct tm * time_information = localtime(&current_time);
	
	if(value != 0)
	{
		fprintf(stdout, "\033[A\033[2K");
		fflush(stdout);
	}
	
	strftime(date_time,50,"%F %Z %T",time_information);
	fprintf(stdout, "Varying value: %6.3f/%.3f finalized at %s.\n", value, max_value, date_time);
}


/**
 * Prints a status message about the status of the simulation execution within a simulation set to stdout.
 * 
 * @param simu_index Current simulation index within the simulation set.
 * @param num_simulations Number of simulations to be performed.
*/
void print_simulation_index(int simu_index, int num_simulations)
{
	char date_time[51];
            
	time_t current_time = time(NULL);
	struct tm * time_information = localtime(&current_time);
	
	if(simu_index > 1)
	{
		fprintf(stdout, "\033[A\033[2K");
		fflush(stdout);
	}
	
	strftime(date_time,50,"%F %Z %T",time_information);
	fprintf(stdout, "Simulation: %5d/%d completed.\n", simu_index, num_simulations);
}

/**
 * Prints the given value `cli_args.num_simulation` times to the provided `stream`. The printed values serve as placeholders for simulations with invalid parameters, such as inaccessible exits.
 * 
 * @param stream Stream where the data will be written.
 * @param placeholder Value that will be printed.
*/
void print_placeholder(FILE *stream, int placeholder)
{
	for(int times = 0; times < cli_args.num_simulations; times++)
	{
		fprintf(stream, "%d ", placeholder);
	}
	fprintf(stream, "\n");
}
