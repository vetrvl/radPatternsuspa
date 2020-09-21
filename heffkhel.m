%%% NU BER for LOS

% generating H matrix
% USPA array response
clear
close all
clc

f=30e9;
c=3e8;
lambda=c/f;
d=lambda/2;
theta_az=0;
theta_el=pi/6;
K=4;
count=1;
for x=0:sqrt(K)-1
    for y=0:sqrt(K)-1
        heffK(count)=exp(1j*2*pi*(d/lambda).*(x.*sin(theta_az).*sin(theta_el)+y.*cos(theta_el)));
        distt(count)=(d/lambda).*(x.*sin(theta_az).*sin(theta_el)+y.*cos(theta_el));
        count=count+1;
    end
end
distt;
heffK
angle(heffK)
% norm(H_overal)
% rank(H_overal)
% %%%%% end of H_overall
% Phi=exp(-1i*angle(heffK))
% sum(heffK.*Phi)
% [x, y, z]=sph2cart(theta_az,theta_el,1)
