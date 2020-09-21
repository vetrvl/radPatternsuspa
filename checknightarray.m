clc
clear all
close all
N=100;M=100;
lambda=0.5;
dx=1
dy=1
theta=pi.*(-1:0.01:1)
phi=pi.*(-1:0.01:1)
for ii=1:length(theta)
    for jj=1:length(phi)        
        psx=(2.*pi./lambda).*dx.*(sin(theta(ii)).*cos(phi(jj)));
        psy=(2.*pi./lambda).*dy.*(sin(theta(ii)).*sin(phi(jj)));
        AFx = 1/N.*sin(N/2.*psx)./sin(1/2.*psx);
        AFy = 1/M.*sin(M/2.*psy)./sin(1/2.*psy);        
        Arr(ii,jj)=abs(AFx.*AFy);
    end
end
patternCustom(Arr,theta,phi)
% size(x)
size(theta)

psx=(2.*pi./lambda).*dx.*(sin(theta).*cos(phi));
psy=(2.*pi./lambda).*dy.*(sin(theta).*sin(phi));
AFx = 1/N.*sin(N/2.*psx)./sin(1/2.*psx);
AFy = 1/M.*sin(M/2.*psy)./sin(1/2.*psy);

Arr=abs(AFx.*AFy)./max(max(abs(AFx.*AFy)))
%
% polar(theta,Arr)