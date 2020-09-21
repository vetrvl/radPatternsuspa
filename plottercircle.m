x=0;
y=10;
r=10;



th = 0:pi/500:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
plot(xunit, yunit);

lambda=0.0100;
xxx=0:lambda/2:2*lambda
yyy=zeros(1,length(xxx))

hold on
plot(xxx,yyy,"*")
plot(xxx,-(lambda/2).*ones(1,length(xxx)),'^')
grid on