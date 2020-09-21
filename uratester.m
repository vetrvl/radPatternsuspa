clc
clear 
close all
Nx =4;
Ny=4;
f=30e9;
c=3e8;
lambda=c/f;
dx=lambda/2; %distance between elements (X)
dy=lambda/2;%distance between elements (Y)
AB=ones(Nx,Ny);
ve=10*pi/180;
% AB_phase=[0 80 160 240;
%           0 80 160 240;
%           270 0 0 0;
%           0 0 0 0]*pi/180; %Array phases
% AB_phase=repmat(ve,[Nx Ny]);
load('pqfile.mat')
AB_phase=zeros(Nx,Ny);
AB_phase=AF_Field';
% AB_coe=AB.*(cos(AB_phase)+1j*sin(AB_phase));
total_power= ( sum(sum(AB.^2)) ); 
theta0=[pi/50:pi/50:pi];
phi0=[pi/50:pi/50:2*pi];
[phi,theta]=meshgrid(phi0,theta0);
sinU=sin(theta).*cos(phi);
sinV=sin(theta).*sin(phi);
AF_Field=0;
for n=1:Nx
    for m=1:Ny
        AF_Field =AB_coe(n,m)*exp(1j*2*pi*(n-1)/lambda*dx*(sinU)).*exp(1j*2*pi*(m-1)/lambda*dy*(sinV)) + AF_Field; 
    end
end
AF_power=AF_Field.^2;
AF_power_normalized=AF_power/total_power;

save('pqfile.mat','AF_Field')

%Plotting
%mesh(phi0*180/pi,theta0*180/pi,20*log10(abs(AF)))
axis([0 360 0 180 -10 6])
surf(phi0*180/pi,theta0*180/pi,(abs(AF_power_normalized))), colorbar
xlabel('\phi')
ylabel('\theta')
shading interp
