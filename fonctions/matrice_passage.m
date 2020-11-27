function [M] = matrice_passage(lat_lambda,long_phi)

M = [-sin(lat_lambda)*cos(long_phi) -sin(long_phi) -cos(lat_lambda)*cos(long_phi);
     -sin(lat_lambda)*sin(long_phi) cos(long_phi) -cos(lat_lambda)*sin(long_phi);
     cos(lat_lambda) 0 -sin(lat_lambda)];
end

