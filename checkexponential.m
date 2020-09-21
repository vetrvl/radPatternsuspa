clc
clear
close all

d1=0:0.001:0.1;
d2=0.002:0.001:0.102;
f=3e9;
c=3e8;
lambda=c/f;

theta=deg2rad(0);
aea = exp(1j*(((2*pi*d1)/lambda)));
AA=angle(aea);
bea = exp(1j*(((2*pi*d2)/lambda)));
BB=angle(bea);
plot(imag(aea),'b')
hold on
plot(imag(bea),'r')
% CC=rad2deg(BB-AA)
 Cea = exp(1j*(((2*pi*d1)/lambda)+deg2rad(7.2)));
 CC=angle(Cea)
 BB
 plot(imag(Cea),'*')
 