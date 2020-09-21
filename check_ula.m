clc
clear 
close all

f=3e6;
c=3e8;
lambda=c/f;
d=lambda;

N=2;
x=1:N;
ux = [-1:0.025:1];
uy = [-1:0.025:1];
h1=exp(1j*x*2*pi*d.*(ux)'./lambda);
h2=exp(1j*x*2*pi*d.*(uy)'./lambda);
h2=ones(81,2);
Beam=h1*h2';
BP = abs(Beam)/max(max(abs(Beam)));

(BP,ux.*20.*pi,uy.*20.*pi)