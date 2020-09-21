clc
clear
close
d=0:0.001:1;
f=3e9;
c=3e8;
lambda=c/f;
theta=deg2rad(0);
AA=exp(1j*((d./lambda)+theta));
plot(d,imag(AA),'b')
hold on
count=1;
theta11=deg2rad(0:10:360);
for theta1=theta11
CC=exp(1j*d./lambda+theta1));
DD=AA+CC;
cc(count)=max(imag(DD));
count=count+1;
end
figure
polarplot(theta11,cc)

% plot(d,imag(DD),'^')

