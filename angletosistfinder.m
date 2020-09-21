%%% generating H matrix
%% USPA array response
clear
close all
clc

f=30e9;
c=3e8;
lambda=c/f;
d=lambda/2;
theta_az=0;
theta_el=pi/6;
K=16;
count=1;
for x=0:sqrt(K)-1
    for y=0:sqrt(K)-1
        heffK(count)=exp(1j*2*pi*(d/lambda).*(x.*sin(theta_az).*sin(theta_el)+y.*cos(theta_el)));
        count=count+1;
    end
end

angle(heffK)

t=0:0.01:4*pi;
plot(sin(t));
hold on
y=sin(t+2.7207);
plot(y,'r');
