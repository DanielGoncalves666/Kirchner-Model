# Implementation of the Kirchner model for Pedestrian Evacuation

This repository contains an implementation of the Kirchner model for pedestrian evacuation using cellular automata.

## Terminology

### Simulation

The term **simulation** stands for a single execution of the evacuation process, which begins when pedestrians are placed in the environment and ends when the environment is empty.

### Simulation Set

The term **simulation set** refers to a group of simulations with the same parameters, except for the **seed** parameter, which changes from one simulation to the next.

## How to compile and run

To compile and run the program, execute the following command in your shell, replacing `[arguments]` with the desired command-line arguments:

```bash
./kirchner.sh [arguments]
```

## Input and Output Files

### Environment Files

The environment files must be placed in the `environment/` directory. Each file must contain, in its first line, the dimensions of the environment (number of lines and columns, respectively). The subsequent lines must represent the actual environment, drawn with the following symbols:

|Symbol    | Meaning                   |
|    ---   |        ---                |
| \#       | Impassable Obstacles      |
| e or E   | Easy passable obstacles   |
| m or M   | Medium passable obstacles |
| h or H   | Hard passable obstacles   |
| p or P   | Pedestrians               |
| _        | Exits                     |
| .        | Nothing                   |

### Auxiliary Files

The auxiliary files must be placed in the `auxiliary/` directory. An auxiliary file contains, in each of its lines, the coordinates of the exits to be used in a single **simulation set** for the environment load methods that don't use static exits. Environment load methods that don't require an auxiliary file will simply ignore it if provided.

The following syntax must be used when writing the content of an auxiliary file:

1. Commas (`,`) are used to separate different exits in a single **simulation set**.
2. The addition symbol (`+`) is used to indicate that the next pair of coordinates is part of the same exit (an exit expansion).
3. A period (`.`) is used to indicate the end of the list of coordinates for a **simulation set**.

#### Example without expansion

```text
line1 column1, line2 column2, [...], lineN columnN.
```

#### Example with expansion

```text
line1_1 column1_1+ line1_2 column1_2, [...].
```

#### Observations

1. There is no upper limit to the number of different exits or the number of coordinates attached to a single exit. Furthermore, even if the coordinates for a single exit aren't adjacent, the simulation set is still considered valid.

2. Repetitive exits are accepted in a single simulation set and are treated as distinct exits by the program. This can cause inconsistencies, as more than one pedestrian can exit the environment from the same place.

### Output Files

The output files, generated by the program, are placed in the `output` directory. If the -o option is not provided when running the program, the output data will be printed to stdout. If the -o option is provided without specifying a filename, a name is automatically generated for the output file.

## Program's help message

```text
Usage: kirchner.exe [OPTION...]
kirchner - Simulates pedestrian evacuation using the Kirchner (2002) model.

  
Files:

  -a, --auxiliary-file=AUXILIARY-FILE
                             Name of the configuration file that contains the
                             coordinates of exits for each simulation set.
  -e, --env-file=ENV-FILE    Name of the file that contains environment
                             information: dimensions and its mapped features,
                             including obstacles, walls, and optionally,
                             pedestrians and doors.
  -o, --output-file[=OUTPUT-FILE]
                             Specifies whether the output should be stored in a
                             file (default is stdout), with the file name being
                             optionally provided.
  
Input/Output Configuration:

  -m, --env-load-method=METHOD   How the environment will be loaded or whether
                             it will be created.
  -O, --output-format=FORMAT The type of output to be generated by the
                             simulations.
  
Environment Dimensions (required for auto created environments):

  -c, --col=COLUMNS          Number of columns for the environment when it is
                             being created.
  -l, --lin=LINES            Number of lines for the environment when it is
                             being created.
  
Simulation Variables (optional):

      --diagonal=DIAGONAL    The diagonal value for calculation of the static
                             floor field (default is 1.5).
      --seed=SEED            Initial seed for the srand function (default is
                             0). If a negative number is given, the starting
                             seed will be set to the value returned by time().
      --static-field=STATIC  The method use to determine the static floor
                             field. Defaults to 1 (Kirchner's method).
  -s, --simu=SIMULATIONS     Number of simulations for each simulation set
                             (default is 1).
  
Variables and toggle options related to pedestrians (all optional):

      --allow-x-movement     The movement of pedestrians isn't restricted when
                             X movements occur.
      --avoid-corner-movement   Prevents movement in the corners of walls and
                             obstacles. A single diagonal movement through the
                             corner of a obstacle becomes three movements.
      --immediate-exit       The pedestrians will exit the environment the
                             moment they reach an exit, instead of waiting a
                             timestep in the LEAVING state.
  -p, --ped=PEDESTRIANS      Manually set the number of pedestrians to be
                             randomly placed in the environment. If provided
                             takes precedence over --density.
  
Kirchner model constants and options:

      --alpha=ALPHA          The probability that a particle in the dynamic
                             floor field will undergo diffusion. Value must be
                             between 0 and 1, both inclusive. Defaults to 0.5.
      --delta=DELTA          The probability that a particle in the dynamic
                             floor field will decay. Value must be between 0
                             and 1, both inclusive. Defaults to 0.5.
      --density=DENSITY      The percentage of unoccupied cells in the
                             environment that should be filled by pedestrians.
                             Defaults to 0.3.
      --dyn-definition=DYN   Determines how the dynamic floor field is defined,
                             either as a virtual velocity density field or a
                             particle density field.
      --ignore-self-trace    When calculating transition probabilities for a
                             pedestrian, ignores the most recent particle
                             deposited by that pedestrian.
      --kd=KD                The dynamic field coupling constant that
                             determines the strength of the dynamic floor field
                             when calculating the transition probabilities for
                             pedestrians. Must be non-negative. Defaults to
                             0.5. Defaults to 1.
      --ks=KS                The static field coupling constant that determines
                             the strength of the static floor field when
                             calculating the transition probabilities for
                             pedestrians. Must be non-negative. Defaults to
                             0.5. Defaults to 1.
  
Range values for simulation focused on a constant:

      --max=MAX              The maximum value that the variable constant will
                             assume. Defaults to 1.
      --min=MIN              The minimum value that the variable constant will
                             assume. Defaults to 0.
      --step=STEP            The step value for incrementing the variable
                             constant. Defaults to 0.01
  
Toggle Options (optional):

      --debug                Prints debug information to stdout.
      --simulation-set-info  Prints simulation set information (exits
                             coordinates) to the output file.
      --single-exit-flag     Prints a flag (#1) before the results for every
                             simulation set that has only one exit.
  
Additional Information:

  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

If no file is provided with --env-file, the varas_queue.txt file will be used.
The file provided with --auxiliary-file must contain, on each line, the
coordinates of the exits for a single simulation set. The syntax to be used is
described in the project's readme.

The --env-load-method option specifies whether the environment will be created
or loaded from the file provided by --env-file, as well as how it will be
loaded if applicable. The following choices are available:
        Environment loaded from a file:
                1 -           Only the environment structure (walls and obstacles).
                2 -           Environment structure and static exits.
                3 -           Environment structure and static pedestrians.
                4 - (default) Environment structure, static exits and static pedestrians.
        Environment auto created:
                5 -           Environment structure will be a empty room with dimensions of
LINES and COLUMNS (including the walls surrounding it).

Choices 1, 3 and 5 require the file provided by the --auxiliary-file option in
order to include exits in the simulation.

The --output-format option specifies which data generated by the simulations
shall be written to the output stream. The following choices are available:
         1 - (default) Visual print of the environment.
         2 -           Number of timesteps required for the termination of each
simulation.
         3 -           Heatmap of the environment cells.

The --static-field option specifies the method used to calculate the static
floor field. The following choices are available:
         1 - (default) Kirchner's static floor field.
         2 -           Inverted Varas's static floor field.

The --dyn-definition option specifies how the dynamic floor field is defined,
either as a particle density field or a velocity density field. In the particle
density field, pedestrians leave particles in the cell they occupy (before any
movement is attempted). In the velocity density field, they leave a particle
only in their previous location when they move. The following choices are
available:
         1 - (default) Velocity Density Field.
         2 -           Particle Density Field.

If all Kirchner constants are provided (with the --ped option counting as
--density), the program will perform simulations varying only the simulation
sets.
Alternatively, if only four constants are provided, the program will perform
simulations varying the missing constant. In this case, the --min, --max, and
--step options define the range and increment step for that constant.
Finally, if three or fewer constants are provided, the program will use default
values for the remaining constants.

The --ignore-self-trace option is currently implemented for use with a velocity
density field. Adapting this functionality for a particle density field has not
been made.
Unnecessary options for some --env-load-method are ignored.
```
