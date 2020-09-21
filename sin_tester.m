clc;
clear all;
close all;
fc = 3e9;
c = 3e8;
lambda = (c/fc);
count = 1
pt = 10;
dist1 = 0.1:0.001:1
for dist = dist1
x(count) = pt*dist^(-2)*sin(2*pi*(dist/lambda))*lambda.^2;
count = count+1;
end
 dist = dist1;
 x1 = pt.*sin(2*pi*(dist/lambda))*lambda.^2;
% % count = count+1;

plot(dist1,x);
hold on
plot(dist1,x1,'*');