# 2D Steady-State Heat Transfer Using Finite Element Method

This project presents the development of a finite element solver for
two-dimensional steady-state heat transfer problems. The objective is
to build a generic FEM application capable of handling complex geometries,
material properties, and thermal boundary conditions.

The solver is designed to import mesh and problem data from GiD and
compute temperature distribution, gradients, and heat flux within the domain.

The project emphasizes structured implementation, numerical integration,
and validation against reference solutions.

## Features

- 2D steady-state heat transfer formulation
- Triangular finite elements (T3)
- Numerical integration schemes
- Essential and natural boundary conditions
- Spatially varying heat source
- Computation of gradients and heat flux
- Export of results to GiD for post-processing

## Repository Structure

- `/matlab` : FEM solver and thermal routines
- `/report` : Project report
- `/figures` : Simulation results
- `/docs` : Problem description and methodology

## Requirements

- MATLAB
- GiD (for pre/post-processing)

## Author

Gilbert Djidiack Faye
