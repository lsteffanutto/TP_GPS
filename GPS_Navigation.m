clear all; close all; clc; beep off;

%% VAR
% radian=(pi/180)*degree;

%% 2. Po repère 2 => Po repère 1
%latitude, longitude
lat_lambda=(44+48/60);
long_phi= -35/60;

M=matrice_passage(lat_lambda,long_phi); %matrice de passage

Po2_deg=[lat_lambda;long_phi;0]; % Po repère 2 NED en deg

%coordonnées Po en radian dans repere NED
Po2_rad=(pi/180)*Po2_deg;          % Po repère 2 NED en rad

%%coordonnées cartésienne Po dans repere 1 (en m)
[Po1_cart] = llh2xyz(Po2_rad);

%% 3. Trajectoire véhicule repère 1 et repère 2

data=load('donnees_GPS_TP.mat');
trajectoire=load('trajectoire_TP.mat');

 %vecteur a initialiser proche de X

% 8 Satellites, 954 instants
XYZsat=data.XYZsat(:,:,:);  %contient les positions satellites (8 mesures GPS à chaque instant = Y(t)
PRN=data.PRN(:,:);          %PRN contient les pseudos-distances [CANAUX DE POURSUITE X INSTANTS]
trajectoire_vehicule=trajectoire.Xloc(:,:,:);
sigma2=1;
nsat=size(PRN,1);
% INIT INSTANT 0
b_init=0;
X_init=[Po1_cart]; % [x_0, y_0, z_0]

% INSTANT 1 (P.103)
% [x_1, y_1, z_1] => pour les 8 satellites
XYZ_1=XYZsat(:,:,1); % n=8 Positions satellites à l'instant t=1 => !!! aux 0 !!!
p_i_1=PRN(:,1);      % n=8 pseudo distance à l'instant t=1
w_1 = sqrt(sigma2/2)*randn(nsat,1);

diff_XYZ_init_t1 = X_init-XYZ_1; % [x_0-x_1, y_0-y_1, z_0-z_1] pour chaque satellites

delta_x=diff_XYZ_init_t1(:,1);
delta_y=diff_XYZ_init_t1(:,2);
delta_z=diff_XYZ_init_t1(:,3);

r_i_1= sqrt( delta_x.^2 + delta_y.^2 + delta_z.^2 );

derive_h_xi = delta_x / r_i_1;
derive_h_yi = delta_y / r_i_1;
derive_h_zi = delta_z / r_i_1;
derive_h_b = 1;