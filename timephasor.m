%% time and phase relation

clc
clear 
close all

f=30e9;
c=3e8;
lambda=c/f;
id=lambda/2;
% m=1:4;
% phi=deg2rad(30);
% DistDIFF=(m-1).*id.*sin(phi)
% timediff=DistDIFF./c
%%
Nx = 2;
Ny = 2;
nx = 1:Nx;
ny = 1:Ny;
dolx = 0.5;
doly = 0.5;
array = ones(Nx,Ny); 
theta0 = deg2rad(25); 
phi0 = deg2rad(45);
count = 1;
for nx = 1:Nx
    for ny = 1:Ny
distdiff_x(count,:) = ((nx-1)*id*sin(theta0)*sin(phi0))./c;
distdiff_y(count,:) = ((ny-1)*id*sin(phi0)*cos(theta0))./c;
    end
    count = count +1;
end

