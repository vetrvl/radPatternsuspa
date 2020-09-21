
clc
clear 
close all
f=30e9;
c=3e8;
lambda=c/f;
d=lambda/2;

theta_az=0:0.1:pi/6
theta_el=0:0.1:pi/6

theta0=[pi/50:pi/50:pi];
phi0=[pi/50:pi/50:2*pi];

K=8;


for x=0:sqrt(K)-1
    for y=0:sqrt(K)-1
        heffK(count)=exp(1j*2*pi*(d/lambda).*(x.*sin(theta_az).*sin(theta_el)+y.*cos(theta_el)));
        count=count+1;
    end
end