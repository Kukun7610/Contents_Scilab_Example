// Generate a vector from -pi/2 to pi/2 with 40 points
u = linspace(-%pi/2, %pi/2, 40);
// Generate a vector from 0 to 2pi with 20 points
v = linspace(0, 2*%pi, 20); 



// Define a vector
t = -7 : .15 : 7;
// Define a grid
[x, y] = meshgrid(t, t);
// Define your function
z = cos(x) .* cos(y) .* exp(-sqrt(x.^2 + y.^2)/3);
// Plot default view
surf(z)
