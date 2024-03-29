close all

f=3e9;
c=3e8;
l=c/f;
d=l/2;
no_elements=2;

theta=0:pi/180:2*pi;
n=1:no_elements;
n=transpose(n);

A=(n-1)*(i*2*pi*d*cos(theta)/l);
X=exp(A);
w=ones(1,no_elements);
r=w*X;

polar(theta,abs(r),'r')
title ('Gain of a Uniform Linear Array')