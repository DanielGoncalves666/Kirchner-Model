/* 
   File: cli_processing.c
   Author: Daniel Gonçalves
   Date: 2024-05-20
   Description: This module contains the declaration of a struct that holds all the command line arguments, as well as the initial assignment of an instance. Furthermore, all necessary structs, documentation, and functions for the use of argp are defined.
*/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<time.h>
#include<argp.h>
#include<unistd.h>
#include<stdbool.h>

#include"../headers/cli_processing.h"

const char * argp_program_version = "Implementation of the Kirchner model for pedestrian evacuation using cellular automata.";
const char doc[] = "kirchner - Simulates pedestrian evacuation using the Kirchner (2002) model."
"\v"
"If no file is provided with --env-file, the varas_queue.txt file will be used.\n"
"The file provided with --auxiliary-file must contain, on each line, the coordinates of the exits for a single simulation set. The syntax to be used is described in the project's readme.\n"
"\n"
"The --env-load-method option specifies whether the environment will be created or loaded from the file provided by --env-file, as well as how it will be loaded if applicable. The following choices are available:\n"
"\tEnvironment loaded from a file:\n"
"\t\t1 - Only the environment structure (walls and obstacles).\n"
"\t\t2 - Environment structure and static exits.\n"
"\t\t3 - Environment structure and static pedestrians.\n"
"\t\t4 - (default) Environment structure, static exits and static pedestrians.\n"
"\tEnvironment auto created:\n"
"\t\t5 - Environment structure will be a empty room with dimensions of LINES and COLUMNS (including the walls surrounding it).\n"
"Choices 1, 3 and 5 require the file provided by the --auxiliary-file option in order to include exits in the simulation.\n"
"\n"
"The --output-format option specifies which data generated by the simulations shall be written to the output stream. The following choices are available:\n"
"\t 1 - (default) Visual print of the environment.\n"
"\t 2 - Number of timesteps required for the termination of each simulation.\n"
"\t 3 - Heatmap of the environment cells.\n"
"\n"
"If all Kirchner constants are provided (with the --ped option counting as --density), the program will perform simulations varying only the simulation sets.\n"
"Alternatively, if only four constants are provided, the program will perform simulations varying the missing constant. In this case, the --min, --max, and --step options define the range and increment step for that constant.\n"
"Finally, if three or fewer constants are provided, the program will use default values for the remaining constants.\n"
"\n"
"Unnecessary options for some --env-load-method are ignored.\n";

/* Keys for options without short-options. */
#define OPT_DIAGONAL 1000
#define OPT_SEED 1001
#define OPT_DEBUG 1002
#define OPT_SIMULATION_SET_INFO 1003
#define OPT_IMMEDIATE_EXIT 1004
#define OPT_AVOID_CORNER_MOVEMENT 1006
#define OPT_ALLOW_X_MOVEMENT 1007
#define OPT_SINGLE_EXIT_FLAG 1008
#define OPT_PEDESTRIAN_DENSITY 1009
#define OPT_ALPHA 1010
#define OPT_DELTA 1011
#define OPT_STATIC_COUPLING 1012
#define OPT_DYNAMIC_COUPLING 1013
#define OPT_MIN_SIMULATION_VALUE 2000
#define OPT_MAX_SIMULATION_VALUE 2001
#define OPT_STEP_VALUE 2002

struct argp_option options[] = {
    {"\nFiles:\n",0,0,OPTION_DOC,0,1},
    {"env-file", 'e', "ENV-FILE", 0, "Name of the file that contains environment information: dimensions and its mapped features, including obstacles, walls, and optionally, pedestrians and doors.",2},
    {"output-file", 'o', "OUTPUT-FILE", OPTION_ARG_OPTIONAL, "Specifies whether the output should be stored in a file (default is stdout), with the file name being optionally provided."},
    {"auxiliary-file", 'a', "AUXILIARY-FILE",0, "Name of the configuration file that contains the coordinates of exits for each simulation set."},

    {"\nInput/Output Configuration:\n",0,0,OPTION_DOC,0,3},    
    {"env-load-method", 'm', "METHOD",0, "How the environment will be loaded or whether it will be created.",4},
    {"output-format", 'O', "FORMAT", 0, "The type of output to be generated by the simulations."},
    
    {"\nEnvironment Dimensions (required for auto created environments):\n",0,0,OPTION_DOC,0,5},
    {"lin", 'l', "LINES", 0, "Number of lines for the environment when it is being created.",6},
    {"col", 'c', "COLUMNS", 0, "Number of columns for the environment when it is being created."},

    {"\nSimulation Variables (optional):\n",0,0,OPTION_DOC,0,7},
    {"simu", 's', "SIMULATIONS", 0, "Number of simulations for each simulation set (default is 1).",8},
    {"seed", OPT_SEED, "SEED", 0, "Initial seed for the srand function (default is 0). If a negative number is given, the starting seed will be set to the value returned by time()."},
    {"diagonal", OPT_DIAGONAL, "DIAGONAL", 0, "The diagonal value for calculation of the static floor field (default is 1.5)."},

    {"\nVariables and toggle options related to pedestrians (all optional):\n",0,0,OPTION_DOC,0,9},
    {"ped", 'p', "PEDESTRIANS", 0, "Manually set the number of pedestrians to be randomly placed in the environment. If provided takes precedence over --density.",10},
    {"immediate-exit", OPT_IMMEDIATE_EXIT, 0,0, "The pedestrians will exit the environment the moment they reach an exit, instead of waiting a timestep in the LEAVING state."},
    {"avoid-corner-movement",OPT_AVOID_CORNER_MOVEMENT,0,0, "Prevents movement in the corners of walls and obstacles. A single diagonal movement through the corner of a obstacle becomes three movements."},
    {"allow-x-movement",OPT_ALLOW_X_MOVEMENT,0,0, "The movement of pedestrians isn't restricted when X movements occur."},

    {"\nKirchner model constants:\n",0,0,OPTION_DOC,0, 11},
    {"density", OPT_PEDESTRIAN_DENSITY, "DENSITY", 0, "The percentage of unoccupied cells in the environment that should be filled by pedestrians. Defaults to 0.3.",12},
    {"alpha", OPT_ALPHA, "ALPHA", 0, "The probability that a particle in the dynamic floor field will undergo diffusion. Value must be between 0 and 1, both inclusive. Defaults to 0.5."},
    {"delta", OPT_DELTA, "DELTA", 0, "The probability that a particle in the dynamic floor field will decay. Value must be between 0 and 1, both inclusive. Defaults to 0.5."},
    {"ks", OPT_STATIC_COUPLING, "KS", 0, "The static field coupling constant that determines the strength of the static floor field when calculating the transition probabilities for pedestrians. Must be non-negative. Defaults to 0.5. Defaults to 1."},
    {"kd", OPT_DYNAMIC_COUPLING, "KD", 0, "The dynamic field coupling constant that determines the strength of the dynamic floor field when calculating the transition probabilities for pedestrians. Must be non-negative. Defaults to 0.5. Defaults to 1."},
    
    {"\nRange values for simulation focused on a constant:\n",0,0,OPTION_DOC,0, 13},
    {"min", OPT_MIN_SIMULATION_VALUE, "MIN", 0, "The minimum value that the variable constant will assume. Defaults to 0.", 14},
    {"max", OPT_MAX_SIMULATION_VALUE, "MAX", 0, "The maximum value that the variable constant will assume. Defaults to 1."},
    {"step", OPT_STEP_VALUE, "STEP", 0, "The step value for incrementing the variable constant. Defaults to 0.01"},

    {"\nToggle Options (optional):\n",0,0,OPTION_DOC,0, 15},
    {"debug", OPT_DEBUG, 0,0 , "Prints debug information to stdout.",16},
    {"simulation-set-info", OPT_SIMULATION_SET_INFO, 0, 0, "Prints simulation set information (exits coordinates) to the output file."},
    {"single-exit-flag", OPT_SINGLE_EXIT_FLAG, 0,0, "Prints a flag (#1) before the results for every simulation set that has only one exit."},

    {"\nAdditional Information:\n",0,0,OPTION_DOC,0,17},
    {0}
};

struct argp argp = {options,&parser_function, NULL, doc};

Command_Line_Args cli_args = {
    .full_command = "",
    .environment_filename="varas_queue.txt",
    .output_filename="",
    .auxiliary_filename="",
    .output_format = OUTPUT_VISUALIZATION,
    .environment_origin = STRUCTURE_DOORS_AND_PEDESTRIANS,
    .simulation_type = SIMULATION_DOOR_LOCATION_ONLY,
    .write_to_file=false,
    .show_debug_information=false,
    .show_simulation_set_info=false,
    .immediate_exit=false,
    .prevent_corner_crossing=false,
    .allow_X_movement = false,
    .single_exit_flag = false,
    .use_density = true,
    .global_line_number = 0,
    .global_column_number = 0,
    .num_simulations = 1, // A single simulation by default.
    .total_num_pedestrians = 0,
    .seed = 0,
    .diagonal = 1.5,
    .alpha=0.5,
    .delta=0.5,
    .ks=1,
    .kd=1,
    .density=0.3,
    .min=0,
    .max=1,
    .step=0.01
};
// When loading an environment global_line_number and global_column_number will no be obtained from the command line arguments. Besides, total_num_pedestrians will be automatic determined by the program on some environment origin formats.


/**
 * This function is called by argp for every option or argument parsed and defines actions for each of them. 
 *  
 * @param key The key field (from the options vector) of the parsed option (ARGP_KEY_ARG for positional arguments).
 * @param arg Value related to the given key. A 0(NULL) is received if not present.
 * @param state Useful information about the parsing state.
 * 
 * @return error_t, where 0 is success, ARGP_ERR_UNKNOWN if the key's value is not handles by this function or an actual error code.
*/
error_t parser_function(int key, char *arg, struct argp_state *state)
{
    static char kirchner_constants = 0;
    // A character that will be used to track which Kirchner constants (including pedestrian density or number of pedestrians) were provided by the user.
    // The 5 least significant bits of this char will be used to indicate whether the values for density (or number of pedestrians), alpha, delta, ks, and kd were provided, in that order.
    static int num_constants = 0; // The number of constants that were provided.

    Command_Line_Args *cli_args = state->input;

    extract_full_command(cli_args->full_command, key, arg);

    switch(key)
    {
        case 'o':
            if(arg != NULL)
                strcpy(cli_args->output_filename, arg);

            cli_args->write_to_file = true;
            break;
        case 'O':
            int output_format = atoi(arg);
            if(output_format < OUTPUT_VISUALIZATION || output_format > OUTPUT_HEATMAP)
            {
                fprintf(stderr, "Invalid output format.\n");
                return EIO;
            }
            cli_args->output_format = (enum Output_Format) output_format;

            break;
        case 'e':
            strcpy(cli_args->environment_filename, arg);
            break;
        case 'm':
            int environment_origin = atoi(arg);
            if(environment_origin < ONLY_STRUCTURE || environment_origin > AUTOMATIC_CREATED)
            {
                fprintf(stderr, "Invalid environment load method.\n");
                return EIO;
            }
            cli_args->environment_origin = (enum Environment_Origin) environment_origin;
            break;
        case 'a':
            strcpy(cli_args->auxiliary_filename, arg);
            break;
        case 'l':
            cli_args->global_line_number = atoi(arg);
            if(cli_args->global_line_number <= 0)
            {
                fprintf(stderr,"The number of lines must be positive.\n");
                return EIO;
            }
            break;
        case 'c':
            cli_args->global_column_number = atoi(arg);
            if(cli_args->global_column_number <= 0)
            {
                fprintf(stderr,"The number of columns must be positive.\n");
                return EIO;
            }
            break;
        case 'p':
            cli_args->total_num_pedestrians = atoi(arg);
            if(cli_args->total_num_pedestrians <= 0)
            {
                fprintf(stderr, "The number of pedestrians must be positive.\n");
                return EIO;
            }

            if((kirchner_constants & 16U) == 0)
            {
                num_constants++;
                kirchner_constants ^= 16U;
            }

            cli_args->use_density = false;
            
            break;
        case 's':
            cli_args->num_simulations = atoi(arg);
            if(cli_args->num_simulations <= 0)
            {
                fprintf(stderr, "The number of simulations must be positive.\n");
                return EIO;
            }
            break;
        case OPT_DIAGONAL:
            cli_args->diagonal = atof(arg);
            if(cli_args->diagonal < 0)
            {
                fprintf(stderr, "The diagonal value must be non-negative.\n");
                return EIO;
            }
            break;
        case OPT_SEED:
            cli_args->seed = atoi(arg);
            if(cli_args->seed < 0)
                cli_args->seed = time(NULL);
                
            break;
        case OPT_DEBUG:
            cli_args->show_debug_information = true;
            break;
        case OPT_SIMULATION_SET_INFO:
            cli_args->show_simulation_set_info = true;
            break;
        case OPT_IMMEDIATE_EXIT:
            cli_args->immediate_exit = true;
            break;
        case OPT_AVOID_CORNER_MOVEMENT:
            cli_args->prevent_corner_crossing = true;
            break;
        case OPT_ALLOW_X_MOVEMENT:
            cli_args->allow_X_movement = true;
            break;
        case OPT_SINGLE_EXIT_FLAG:
            cli_args->single_exit_flag = true;
            break;
        case OPT_PEDESTRIAN_DENSITY:
            cli_args->density = atof(arg);
            if(cli_args->density < 0 || cli_args->density > 1)
            {
                fprintf(stderr, "The Pedestrian density must be in the [0,1] range.\n");
                return EIO;
            }  

            if((kirchner_constants & 16U) == 0)
            {
                num_constants++;
                kirchner_constants ^= 16U;
            }

            break;
        case OPT_ALPHA:
            cli_args->alpha = atof(arg);
            if(cli_args->alpha < 0 || cli_args->alpha > 1)
            {
                fprintf(stderr, "The diffusion (alpha) probability must be in the [0,1] range.\n");
                return EIO;
            } 

            if((kirchner_constants & 8U) == 0)
            {
                num_constants++;
                kirchner_constants ^= 8U;
            }

            break;
        case OPT_DELTA:
            cli_args->delta = atof(arg);
            if(cli_args->delta < 0 || cli_args->delta > 1)
            {
                fprintf(stderr, "The decay (delta) probability must be in the [0,1] range.\n");
                return EIO;
            } 

            if((kirchner_constants & 4U) == 0)
            {
                num_constants++;
                kirchner_constants ^= 4U;
            }

            break;    
        case OPT_STATIC_COUPLING:
            cli_args->ks = atof(arg);
            if(cli_args->ks < 0)
            {
                fprintf(stderr, "The static field coupling constant must be a non-negative value.\n");
                return EIO;
            }
            
            if((kirchner_constants & 2U) == 0)
            {
                num_constants++;
                kirchner_constants ^= 2U;
            }

            break;
        case OPT_DYNAMIC_COUPLING:
            cli_args->kd = atof(arg);
            if(cli_args->kd < 0)
            {
                fprintf(stderr, "The dynamic field coupling constant must be a non-negative value.\n");
                return EIO;
            } 

            if((kirchner_constants & 1U) == 0)
            {
                num_constants++;
                kirchner_constants ^= 1U;
            }

            break;
        case OPT_MIN_SIMULATION_VALUE:
            cli_args->min = atof(arg);
            break;
        case OPT_MAX_SIMULATION_VALUE:
            cli_args->max = atof(arg);
            break;
        case OPT_STEP_VALUE:
            cli_args->step = atof(arg);
            if(cli_args->step <= 0)
            {
                fprintf(stderr, "The step value must be a positive number.\n");
                return EIO;
            }
            break;
        case ARGP_KEY_ARG:
            fprintf(stderr, "No positional argument was expect, but %s was given.\n", arg);
            return EINVAL;
            break;
        case ARGP_KEY_END:
            if(origin_uses_auxiliary_data() == true)
            {
                if( strcmp(cli_args->auxiliary_filename,"") == 0)
                {
                    fprintf(stderr, "--env-load-method 1, 3 and 5 require an auxiliary file to be provided.\n");
                    return EIO;
                }
            }
            else
            {
                if( strcmp(cli_args->auxiliary_filename,"") != 0)
                    strcpy(cli_args->auxiliary_filename,""); // when the auxiliary file is not needed.
            }

            if(cli_args->environment_origin == AUTOMATIC_CREATED)
            {
                if(cli_args->global_line_number == 0 || cli_args->global_column_number == 0)
                {
                    fprintf(stderr, "Environment dimensions were expect, but not provided.\n");
                    return EIO;
                }
            }

            if(cli_args->min > cli_args->max)
            {
                fprintf(stderr, "The value provided to the --min option must be lower than the value provided to the --max option.\n");
                return EIO;
            } 

            if(num_constants == 4)
            {
                for(int shift = 0; shift < 5; shift++)
                {
                    if( (kirchner_constants & (16U >> shift)) == 0 )
                    {
                        cli_args->simulation_type = (enum Simulation_Type) shift;
                        break;
                    }
                }
            }

            break;
        default:
            return ARGP_ERR_UNKNOWN;
            break;
    }

    return 0;
}


/**
 * Extracts and stores the full command received by the CLI into a string for later use. Each call to this function stores one option and its arguments, if present, into the string. 
 * 
 * @param full_command String where the option will be stored.
 * @param key The key field (from the options vector) of the parsed option.
 * @param arg Value related to the given key. A 0 (NULL) is received if not present.
*/
void extract_full_command(char *full_command, int key, char *arg)
{
    char aux[151];

    switch(key)
    {
        case OPT_DEBUG:
            sprintf(aux, " --debug");
            break;
        case OPT_SIMULATION_SET_INFO:
            sprintf(aux, " --simulation-set-info");
            break;
        case OPT_IMMEDIATE_EXIT:
            sprintf(aux, " --immediate-exit");
            break;
        case OPT_AVOID_CORNER_MOVEMENT:
            sprintf(aux, " --avoid-corner-movement");
            break;
        case OPT_ALLOW_X_MOVEMENT:
            sprintf(aux, " --allow-x-movement");
            break;
        case OPT_SINGLE_EXIT_FLAG:
            sprintf(aux, " --single-exit-flag");
            break;
        case OPT_SEED:
            sprintf(aux, " --seed=%s", arg);
            break;
        case OPT_DIAGONAL:
            sprintf(aux, " --diagonal=%s", arg);
            break;
        case OPT_PEDESTRIAN_DENSITY:
            sprintf(aux, " --density=%s", arg);
            break;
        case OPT_ALPHA:
            sprintf(aux, " --alpha=%s", arg);
            break;
        case OPT_DELTA:
            sprintf(aux, " --delta=%s", arg);
            break;
        case OPT_STATIC_COUPLING:
            sprintf(aux, " --ks=%s", arg);
            break;
        case OPT_DYNAMIC_COUPLING:
            sprintf(aux, " --kd=%s", arg);
            break;
        case OPT_MIN_SIMULATION_VALUE:
            sprintf(aux, " --min=%s", arg);
            break;
        case OPT_MAX_SIMULATION_VALUE:
            sprintf(aux, " --max=%s", arg);
            break;
        case OPT_STEP_VALUE:
            sprintf(aux, " --step=%s", arg);
            break;
        case 'o':
        case 'O':
        case 'e':
        case 'm':
        case 'a':
        case 'l':
        case 'c':
        case 'p':
        case 's':
            if(arg == NULL)
                sprintf(aux, " -%c",key);
            else
                sprintf(aux, " -%c%s",key, arg);

            break;
        default:
            return;
    }

    strcat(full_command, aux);
}

/**
 * Returns a pointer to the variable that holds the constant that needs to vary. If no constant will vary, a NULL pointer is returned.
 * 
 * @return A pointer to a double representing the constant that will vary, if the case.
 */
double *obtain_varying_constant()
{
    switch(cli_args.simulation_type)
    {
        case SIMULATION_DENSITY:
            return &(cli_args.density);
        case SIMULATION_ALPHA:
            return &(cli_args.alpha);
        case SIMULATION_DELTA:
            return &(cli_args.delta);
        case SIMULATION_STATIC_COUPLING:
            return &(cli_args.ks);
        case SIMULATION_DYNAMIC_COUPLING:
            return &(cli_args.kd);
        case SIMULATION_DOOR_LOCATION_ONLY:
        default:
            return NULL;
    }
}