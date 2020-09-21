

% points in ULA

a=[0,0];
b=[1,0];
c=[2,0];
d=[0,5];

plot([a(1) d(1)],[a(2) d(2)])
hold on
plot([b(1) d(1)],[b(2) d(2)],'r')
plot([c(1) d(1)],[c(2) d(2)],'k')
% plot
figure

aa=[0,0,0];
bb=[1,0,0];
cc=[2,0,0];
dd=[5,5,5];
plot3([aa(1) dd(1)],[aa(2) dd(2)],[aa(3) dd(3)])
hold on
plot3([bb(1) dd(1)],[bb(2) dd(2)],[bb(3) dd(3)],'r')
plot3([cc(1) dd(1)],[cc(2) dd(2)],[cc(3) dd(3)],'k')