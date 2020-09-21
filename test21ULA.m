
clear
clc

for N=[8]
steer_angle =30;
w = 1/N*ones(1,N);
d = 0.5;
n = (-(N-1)/2:(N-1)/2).'; 
theta = pi*(-1:0.001:1);
ele= pi*(-1:0.001:1);
u = cos(theta);
theta_T = steer_angle/180*pi;
vv = exp(1j*2*pi*d*n*u);
% polarplot(theta,vv)
% hold on
ut=cos(theta_T);
W = w.*exp(1j*n*pi*cos(theta_T))';
B = W*vv;
 BA = 10*log10(abs(B).^2);
polarplot(theta,abs(B));
yy=sin(ele);
vv_vert = exp(1j*2*pi*d*n*yy);
Elm= W*vv_vert;
figure
polarplot(ele,abs(Elm));
%%% vertical p[lane

result=B.*Elm;

figure
polarplot(ele,abs(result));

end
figure

 patternCustom(abs(result),zeros(1,2001),ele)
% 
%
% 
% 
% ut=cos(theta_T);
% W = w.*exp(1j*n*pi*cos(theta_T))';
% B = W*vv;
% B = 10*log10(abs(B).^2);
% 
% figure
% polardb(theta,B,-40)