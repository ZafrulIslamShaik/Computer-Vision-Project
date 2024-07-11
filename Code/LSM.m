%  function for a least squares correlation
function end_value = LSM (start_img,width, height)

% Calculating the Least Squares Correlation

% for initial_img
[x, y] = meshgrid(width:height,width:height);    

ref_window = start_img(width:height,width:height); 

[fx, fy] = gradient(ref_window,2);

% Obtaining A matrix from LSM Calcuation
A= [sum(sum(fx.^2.*(x.^2))) sum(sum(fx.^2.*(x.*y))) sum(sum(fx.*fy.*(x.*x))) sum(sum(fx.*fy.*(x.*y))) ;sum(sum(fx.^2.*(x.*y))) sum(sum(fx.^2.*(y.^2))) sum(sum(fx.*fy.*(x.*y))) sum(sum(fx.*fy.*(y.^2)));
    sum(sum(fx.*fy.*(x.^2))) sum(sum(fx.*fy.*(x.*y))) sum(sum(fy.^2.*(x.^2))) sum(sum(fy.^2.*(x.*y)));sum(sum(fx.*fy.*(x.*y))) sum(sum(fx.*fy.*(y.^2))) sum(sum(fy.^2.*(x.*y))) sum(sum(fy.^2.*y.^2))];
% B Matrix Calculation
phi = deg2rad(90);
B=[cos(phi) -sin(phi) 0 0; sin(phi) cos(phi) 0 0 ;0 0 0 0;0 0 0 1];

% Obtaining the value of D by using Moore-Penrose Pseudoinverse to matrix A
d = pinv(A).*B; 

end_value = [1+d(1), d(2), 0; d(3), 1 + d(4), 0; 0, 0, 1];