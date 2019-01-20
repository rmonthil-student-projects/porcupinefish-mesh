# Porcupinefish modelisation for Computation Fluid Dynamics

Originally a school project at the INP-ENSEEIHT engineering school. The aim was to create a mesh representing the desired object that a solver could run with.

As this project was an opportunity to learn how to use [gmsh](http://gmsh.info), the script is far from perfect but at least it could help someone to do something better.

![Picture of a simulation non inflated.](https://github.com/LeDernier/porcupinefish/blob/master/img/PoissonComplet.png)

## Getting Started

Clone or download the project and unzip it. 

### Prerequisites

You will need [gmsh](http://gmsh.info) to create the geometry and the mesh.

## Generate the geometry and the mesh

Just open the "porcupinefish.geo" file with [gmsh](http://gmsh.info). It may take a while.

A lot of parameters can be changed to change the geometry. The most interesting are a accessible in gmsh GUI.

To make the fish inflate, juste change the two lines at the begining of the porcupinefish.geo file :

from

```
nonInflate = 1;
inflate = 0;
```

to

```
nonInflate = 0;
inflate = 1;
```

And reload the file using gmsh. It may take a while.

## Results using OpenFOAM and Paraview

This images are here to show that the mesh generated could run in [OpenFOAM](https://www.openfoam.com). 
The parameters used, choosen because of computation cost, did make the simulation physicaly incorect.
The result was visualized using [Paraview](https://www.paraview.org).

![Picture of a simulation inflated.](https://github.com/LeDernier/porcupinefish/blob/master/img/PoissonGonfle.png)

## License

This project is licensed under the Unlicense - see the [LICENSE.md](LICENSE.md) file for details