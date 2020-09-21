%% matrix tester
clc
clear

K=4; N=4;
H=ones(N,K); Xsup= diag(ones(1,K));
Phi_Beam=ones(K,1);
g=ones(1,N); Phi_RIS=ones(1,N);
hhh=randn(2,2)+1j*randn(2,2);

ll=hhh.*hhh';

%% 