clc
clear
close all

theta=pi.*(-1:0.001:1);

a=exp(1j*2*pi*cos(0));
d=0.5;
b=exp(1j*2*pi*cos(theta));
plot(theta,a+b)
figure
polarplot(theta,a+b)