%% https://www.youtube.com/watch?v=nT7z6MxdEQE&t=2237s 

% An Introduction to 3D Beamforming
M=8;
N=8;
theta_azii=[-pi/2:pi/100:pi/2];
theta_elee=[-pi/4:pi/100:pi/4];

theta_aziis=deg2rad(45)*ones(1,length(theta_azii));
theta_elees=deg2rad(0.1)*ones(1,length(theta_elee))


[theta,psi]=meshgrid(theta_azii,theta_elee);
[thetas,psis]=meshgrid(theta_aziis,theta_elees);
f=3e8;
c=3e8;
lambda=c/f;

dx=lambda/2;
dy=dx;

u=sin(theta).*cos(psi);
v=sin(theta).*sin(psi);
us=sin(thetas).*cos(psis);
vs=sin(thetas).*sin(psis);

PSI_X=2*pi.*(dx./(lambda)).*(u-us);
PSI_Y=2*pi.*(dy./(lambda)).*(v-vs);

S_x=sin(M.*PSI_X./2)./(sin(PSI_X./2))/M;
S_y=sin(N.*PSI_Y./2)./(sin(PSI_Y./2))/N;

surf(S_x.*S_y,theta,psi)
% figure
% polarplot3d(theta,psi,S_x)

