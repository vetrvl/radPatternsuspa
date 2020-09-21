%%% quantisation tester

clc
clear all
close all
fc=30e9;
kk=0:0.01:2*pi;
B=sin(fc*kk);
kk1=2*pi+.01:0.01:4*pi
C=-sin(kk1);
D=[B C]

plot(D)
adc([-1,1],1,D)