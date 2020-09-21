%% ULA response



clc
clear 
close all

f=3e9;
c=3e8;
lambda=c/f;
d=lambda/2;

ux=deg2rad(30);
uy=deg2rad(10);

ux = [-1:0.025:1];
uy = [-1:0.025:1];

N=8;
x=1:N;

M=8;
y=1:M;

h_t=exp(1j*x*2*pi*d.*(ux)'./lambda);
h_r=exp(1j*y*2*pi*d.*(uy)'./lambda);

Hto = h_t.*h_r;
Beam=Hto;

% Beam= Hto*Hto';

BP = abs(Beam)/max(max(abs(Beam)));
figure
G = 10*log10(abs(BP).^2);
G = max(G,-150);
mesh(ux,uy,(BP))

% figure

% polarplot(Hto,'-*')
% hold on
% polarplot(Htoprec,'-^')
% polarplot(imag(Hto),'^')