# HeatDiffusionFORTRAN

This project implements a heat diffusion calculator written in modern Fortran. It simulates how heat spreads along a straight rod over time. The program reads settings from a configuration file, runs the diffusion update loop, and writes the final temperature distribution to a CSV file.

## Build Instructions

Compile the program from the project root:

    gfortran -std=f2008 -O2 \
      src/config_module.f90 \
      src/grid_module.f90 \
      src/solver_module.f90 \
      src/io_module.f90 \
      src/main.f90 \
      -o heat_diffusion

This creates an executable named:

    heat_diffusion

## Run Instructions

Run the program with:

    ./heat_diffusion

The program reads simulation settings from:

    config/heat_config.in

The final temperature distribution is written to:

    output/final_temperature.csv

## Example Configuration File

Below is an example of the expected format for heat_config.in:

    diffusivity
    0.01
    x_min
    0.0
    x_max
    1.0
    n_points
    101
    t_final
    0.1
    dt
    1.0e-4
    temp_left
    0.0
    temp_right
    0.0

## Project Structure

    src/
      config_module.f90     - Reads simulation settings
      grid_module.f90       - Builds the spatial grid
      solver_module.f90     - Initializes and updates temperatures
      io_module.f90         - Writes CSV output
      main.f90              - Runs the full simulation

    config/
      heat_config.in        - User-editable simulation settings

    output/
      final_temperature.csv - Generated after running

## What the Program Does

1. Loads simulation settings from the config file.
2. Builds a grid representing positions along a rod.
3. Creates an initial temperature profile.
4. Applies a diffusion update rule for the specified number of time steps.
5. Writes the final temperature distribution to a CSV file.

## Plotting the Output (Optional)

Example Python snippet for plotting:

    import pandas as pd
    import matplotlib.pyplot as plt

    df = pd.read_csv("output/final_temperature.csv")
    plt.plot(df["position"], df["temperature"])
    plt.xlabel("Position")
    plt.ylabel("Temperature")
    plt.title("Final Temperature Distribution")
    plt.show()
