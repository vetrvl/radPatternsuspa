%% inphase quad phase plot
clc
clear
f = 1;
c = 3e8;
lambda = c/f;
d=0.2;
t1=0:1e-12:(d/c);
t2=0:1e-12:((d+0.0025)/c);
f1=3e9;
x = exp(1j*2*pi*f1*t1);
y = exp(1j*2*pi*f1*t2);
plot(c*t1,x,'^')
hold on
plot(c*t2,y,'k')
