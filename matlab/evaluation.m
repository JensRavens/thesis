m = map('map.png', 37);
average = [fdtd(big).image(m).average
fdtd(small).image(m).average
fdtd(big).at(35).average
fdtd(small).at(35).average
];
interpolate = [fdtd(big).image(m).extrapolate(570/2)
fdtd(small).image(m).extrapolate(570/2)
fdtd(big).at(35).extrapolate(570/2)
fdtd(small).at(35).extrapolate(570/2)];
cat(1, average', interpolate')