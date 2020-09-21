% Antenna Synthesis
% Uniform Linear Array
% function uniformlineararray(d,beta,N)
% d = distance (* wavelength)
% beta = phase difference
% N = number of elements
clc 
clear all
close all

f=3e8;
c=3e8;
lambda=c/f;
N=3;
beta=deg2rad(-65);
d=0.5.*lambda;
len = 1000;
theta = linspace(0,2*pi,len);
psy = 2.*pi.*d.*cos(theta)+beta;
AF = 1/N.*sin(N/2.*psy)./sin(1/2.*psy);

% Polar Plot
figure(1)
polarplot(theta,AF);
set(gca,'ThetaZeroLocation','top')
title('Polarization Factor Vs theta');
% 2D-Rectangular Plot
figure(2)
plot(theta,AF);
grid on;
title('Polarization Factor Vs theta');
xlabel('Theta');
ylabel('Array Factor');
phi = linspace(0,2*pi,len);
% 3D-Plot
[T,P] = meshgrid(theta,phi);
PSY = 2.*pi.*d.*cos(T)+beta;
R = 1/N.*sin(N/2.*PSY)./sin(1/2.*PSY);
%Convert Spherical to Cartesian coordinates
[X,Y,Z] = sph2cart(T,P,R);
figure(3)
mesh(X,Y,Z);
% patternCustom(Z,X,Y)
title('Visualization Array Factor 3D');
figure(4)
patternCustom(AF,theta,theta)