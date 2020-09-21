%%% generating H matrix

%% USPA array response
clear
close all
clc

f=30e9;
c=3e8;
lambda=c/f;
d=lambda/2;
cou=1;
%  theta_azii=0:0.1:pi/6;
% theta_elee=0:0.1:pi/6;

% theta_azii=[pi/50:pi/50:pi];
% theta_elee=[pi/50:pi/50:2*pi];

% [theta_az,theta_el]=meshgrid(theta_azii,theta_elee);

theta_az=0;
theta_el=pi/4;

K=4;
count=1;
for x=0:sqrt(K)-1
    for y=0:sqrt(K)-1
        heffK(count)=exp(1j*2*pi*(d/lambda).*(x.*sin(theta_az).*sin(theta_el)+y.*cos(theta_el)));
        count=count+1;
    end
end
N=4;
count1=1;
for x=0:sqrt(N)-1
    for y=0:sqrt(N)-1
        heffN(count1)=exp(1j*2*pi*(d/lambda).*(x.*sin(theta_az).*sin(theta_el)+y.*cos(theta_el)));
        count1=count1+1;
    end
end
totmatrix=heffK.*heffN'
precodingmatrix=totmatrix';

codedchannel= totmatrix*precodingmatrix