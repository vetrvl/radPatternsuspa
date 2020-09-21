%%emil bjornson beamformer

clc
clear
close all

f=3e8;
c=3e8;
lambda=c/f;
Ei=1;
b=lambda/5;
a=b;
r=10;
theta_r= pi.*(0:0.01:0.5);
theta_s=theta_r;
theta_i=theta_r;
term1=(pi.*b./lambda).*((sin(theta_s)-(sin(theta_i))));
S_IRS=((a*b/lambda)^2).*(((Ei^2).*cos(theta_i).^2)./r^2).*(sin(term1)./(term1)).^2;