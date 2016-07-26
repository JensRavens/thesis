### Finite-difference time-domain method

The finite-difference time-domain method (also called Yee's method after the mathematician Kane Yee) describes an algorithm to calculate time dependent electromagnetic fields based on Maxwell's equations. It has first been published in a paper by [Kane Yee in 1966][yee].

To describe a system it is broken down into a grid (which can but doesn't have to have equidistant points) which contains information about the current electric and magnetic fields and the permittivity at this point. After the grid is initialized, the next electric field values can be calculated from the magnetic field and - in a second step - the next electric field can be calculated from the magnetic field. By taking the permittivity into account this method is capable of describing inhomogenous complex systems of different materials and field sources.

[yee]: http://adsabs.harvard.edu/abs/1966ITAP...14..302Y (Numerical solution of inital boundary value problems involving maxwell's equations in isotropic media)
