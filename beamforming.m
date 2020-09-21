% www.pudn.com > beamform.rar > URAbeampattern.m, change:2012-10-22,size:1324b

 
 

 
%URA-beampattern 
clear all 
clc 
N=128; 
M=128;%��Ԫ���� 
f=30e9;%�ź�Ƶ�� 
% for f = [3e9 30e9]
c=3e8; 
lambda=c/f; 
d=0.5*lambda; 
theta=-pi/2:0.02:pi/2; 
phi=0:0.05:2*pi; 
phi0=pi/6; 
theta0=pi/3;      %Ԥ���趨�ķ��� 
k = 1; 
p = zeros(3,M*N); 
for iii = -(N-1)/2 : (N-1)/2 
    for jjj = -(M-1)/2 : (M-1)/2 
        p(:,k) = [iii*d,jjj*d,0]'; 
        k = k+1; 
    end 
end    
% % figure(1); 
% plot3(p(1,:),p(2,:),p(3,:),'ko');hold on; 
% xlabel('\it x','Fontsize',14); 
% ylabel('\it y','Fontsize',14); 
% zlabel('\it z','Fontsize',14); 
k0=-2*pi/lambda*[sin(phi0)*cos(theta0),sin(phi0)*sin(theta0),cos(phi0)].'; 
w0=exp(-1i*k0.'*p); 
 
for ii=1:length(theta) 
    for jj=1:length(phi) 
        k=-2*pi/lambda*[sin(theta(ii))*cos(phi(jj)),sin(theta(ii))*sin(phi(jj)),cos(theta(ii))].'; 
        v=exp(-1i*k.'*p); 
  b(ii,jj)=w0*v'; 
    end 
end 
 
figure; 
B=20*log10(abs(b)/max(max(abs(b)))); 
ux = sin(theta.')*cos(phi); 
uy = sin(theta.')*sin(phi); 
B = max(B,-60); 
mesh(ux,uy,B); 
xlabel('\it u_x','Fontsize',18,'fontname','times new roman'); 
ylabel('\it u_y','Fontsize',18,'fontname','times new roman'); 
zlabel('Beampattern/dB','Fontsize',18,'fontname','times new roman'); 
zlim([-60,0]); 
caxis([-60,0]) 
set(gcf,'color','white') 
set(gca,'linewidth',2,'fontsize',18,'fontname','times new roman') 
set(gca,'ztick',-60:10:0) 

% end