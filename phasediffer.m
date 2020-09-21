% ULA SIN theta

clc
clear

theta=pi/6;
m=1:4;
f=30e9;
lamda=3e8/f;
diff=((m-1).*sin(theta))/lamda
kkk=exp(-1j.*diff)
angle(kkk)
% dist=100+diff;

sum(kkk)

