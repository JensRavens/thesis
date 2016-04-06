reset
set ticslevel 0
set term png
set view map
set dgrid3d 150, 150
set xrange [-400:400]
set yrange [-400:400]
set pm3d interpolate 5,5
# set dgrid3d
set palette defined (0 0 0 0.5, 1 0 0 1, 2 0 0.5 1, 3 0 1 1, 4 0.5 1 0.5, 5 1 1 0, 6 1 0.5 0, 7 1 0 0, 8 0.5 0 0)
splot "data.dat" using 1:2:3 with pm3d
