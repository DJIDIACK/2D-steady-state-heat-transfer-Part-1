###### Problem Statement



The objective of this project is to develop a finite element solver for
two-dimensional steady-state heat transfer problems. The model considers
heat conduction within a domain subjected to thermal sources and boundary
conditions.



The computational framework is designed to import mesh and problem data
from GiD, allowing the definition of geometry, materials, and thermal
boundary conditions. The domain is discretized using three-node triangular
elements.



The formulation includes the treatment of essential and natural boundary
conditions, numerical integration of elemental matrices, and computation
of internal variables such as temperature gradients and heat flux.



The developed solver is validated against reference solutions to ensure
accuracy and consistency of the numerical implementation. The project
serves as an introduction to multi-dimensional finite element analysis
and provides a foundation for more advanced thermal and multiphysics
simulations.

