


clc
clear
close all
f=3e9;
c=3e8;
lambda=c/f;
thetad=deg2rad(0:1:360);
aziDd=deg2rad(0:1:360);
N=4;
x=0; y=0;
Wn= imag(exp(-1j.*(2.*pi/lambda).*sin(thetad).*( x.*cos(aziDd) + y.* sin(aziDd))));
x=1; y=1;
W1= imag(exp(-1j.*(2.*pi/lambda).*sin(thetad).*( x.*cos(aziDd) + y.* sin(aziDd))));

bbE=abs(Wn)*abs(W1)./max(max(abs(Wn)*abs(W1)'))
%  mesh(thetad,aziDd,bbE)
patternCustom(bbE,thetad,aziDd)


