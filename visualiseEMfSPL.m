% pathloss visualisation

clc
clear
close all
PT=10;
Gt=5;
Gr=5;
dist=0:0.0001:0.1;
h=(randn+1j*randn)./sqrt(2);
PR=(PT*Gt*Gr)./(4*pi*dist.^2);
% semilogy(dist,PR)
t=0:0.01:1;
% figure
freq=30e9;
for ii=1:length(PR)
Siner(ii)=PR(ii).*exp(1j*2*pi.*(dist(ii)/3e8).*freq);
% plot(dist,Siner(ii,:))
% hold on
end
semilogy(dist,real(Siner))
hold on
semilogy(dist,imag(Siner))

