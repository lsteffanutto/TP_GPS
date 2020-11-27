function [x,y,z] = llh2xyz(l,l,h)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ce programme transforme un triplet de coordonn�es ellipsoidales
% (latitude, longitude, altitude) en coordonn�es cart�siennes dans la
% rep�re WGS84.
% Entr�e :
%  llh = (latit, longi, alti), triplet de coordonn�es ellipsoidales
% Sortie :
% xyz : triplet de coordonn�es cart�siennes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phi = llh(1); % latitude
lambda = llh(2);
h = llh(3);

a = 6378137.0000;
b = 6356732.0000;
e=sqrt(1-(b/a)^2);

sinphi = sin(phi);
cosphi = cos(phi);
coslam = cos(lambda);
sinlam = sin(lambda);
tan2phi = (tan(phi))^2;
tmp=1-e^2;
tmpden = sqrt(1+tmp*tan2phi);

x = (a*coslam)/tmpden+h*coslam*cosphi;
y = (a*sinlam)/tmpden+h*sinlam*cosphi;

tmp2 = sqrt(1-(e*sinphi)^2);
z = (a*tmp*sinphi)/tmp2+h*sinphi;

xyz(1) = x;
xyz(2) = y;
xyz(3) = z;