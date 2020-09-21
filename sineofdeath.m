
clc
clear all
close all
t=0:0.1:60;
plot(t,sind(238.*t),'k-')
hold on
plot(t,sind(211.*t),'y')
plot(t,sind(231.*t),'g')
grid on