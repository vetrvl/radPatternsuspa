% Figure 3.19 and 3.20: Capacity of different beamforming techniques
% Elisabeth de Carvalho, April 2012


clear all

% number of channel realizations. This number needs to be increased when
% estimating a small probability
It = 10000;

% Number of transmit and receive antennas
M=4;

% SNR range in dB
SNRdBvalues = [-10:2:20];


% Transmit power
P=1;


SNRidx = 0;
for SNRdB=SNRdBvalues
    SNRdB
    SNRidx = SNRidx + 1;
    SNR=10^(SNRdB/10);

    
    for kk=1:It
        
        
        % generate channel realization
        H     = ( randn(M)  + j*randn(M)   ) / sqrt(2);
        Hsimo = ( randn(M,1)+ j*randn(M,1) ) / sqrt(2);
        
        % SVD of channel matrix H
        % singular values if the diagonal of S are in descending order 
        [U S V] = svd(H);
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Capacity for SIMO/MISO
        Csimo(kk) = real(log2(det(1 + Hsimo'*Hsimo*SNR)));
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Capacity for max Eigenmode transmission
        Cmax(kk)  = real(log2(det(1 + S(1,1)^2*SNR)));
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Capacity for Eigenmode tranmission, uniform power distribution
        CeigU1(kk) = log2( 1 + SNR/4*S(1,1)^2 );    % stream 1
        CeigU2(kk) = log2( 1 + SNR/4*S(2,2)^2 );    % stream 2
        CeigU3(kk) = log2( 1 + SNR/4*S(3,3)^2 );    % stream 3
        CeigU4(kk) = log2( 1 + SNR/4*S(4,4)^2 );    % stream 4        
        CeigAll(kk)  = real(log2(det(eye(M) + SNR/M*H*H' )));      % sum over the 4 streams
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        %% Capacity for Eigenmode tranmission, waterfilling power distribution

        %% Waterfilling power allocation for 4 streams
        % Gamma: vector with values of gamma_i, i=1,2,3,4
        Gamma = 1./diag(S).^2/SNR;
        
        % Cut off value assuming all the streams are allocated with power
        gamma0 = (1 + sum(Gamma))/4;
        
        % vector serving to verify if 1/gamma0 is larger than gamma_i
        D = gamma0*ones(4,1) - Gamma ;
        
        % begin by verifying if 1/gamma0 is larger than gamma_i for the
        % waekest stream. If not, no power is allocated.
        if D(4) < 0             % test if power should be allocated to stream 4
            P4      = 0;                                    % no power to stream 4
            gamma0  = (1 + sum(Gamma(1:3)))/3;              % new cut-off value when 3 streams have power
            D       = gamma0*ones(3,1) - Gamma(1:3) ;       % new vector serving to verify if 1/gamma0 is larger than gamma_i
            
            if D(3) < 0         % test if power should be allocated to stream 3
                P3      = 0;                                % no power to stream 3
                gamma0  = (1 + sum(Gamma(1:2)))/2;          % new cut-off value when 2 streams have power
                D       = gamma0*ones(2,1) - Gamma(1:2) ;   % new vector serving to verify if 1/gamma0 is larger than gamma_i
                
                if D(2)<0      % test if power should be allocated to stream 2
                    
                    % power allocated to 1 stream
                    P2 = 0;                         % no power to stream 3
                    P1 = P;                         % all power allocated to stream 1 
                    
                else
                    
                    % power allocated to 2 streams
                    P1 = (gamma0 - Gamma(1));       % power allocated to stream 1
                    P2 = (gamma0 - Gamma(2));       % power allocated to stream 2
                    
                end
                
            else
                
                % power allocated to 3 streams
                P1 = (gamma0 - Gamma(1));      % power allocated to stream 1
                P2 = (gamma0 - Gamma(2));      % power allocated to stream 2
                P3 = (gamma0 - Gamma(3));      % power allocated to stream 3
                
            end
            
        else
            
            % power allocated to 4 streams
            P1 = ( gamma0 - Gamma(1) );     % power allocated to stream 1
            P2 = ( gamma0 - Gamma(2) );     % power allocated to stream 2
            P3 = ( gamma0 - Gamma(3) );     % power allocated to stream 3
            P4 = ( gamma0 - Gamma(4) );     % power allocated to stream 4
            
        end
        
        CeigW1(kk) = log2(1 + P1*SNR*S(1,1)^2);      % capacity, stream 1
        CeigW2(kk) = log2(1 + P2*SNR*S(2,2)^2);      % capacity, stream 2
        CeigW3(kk) = log2(1 + P3*SNR*S(3,3)^2);      % capacity, stream 3
        CeigW4(kk) = log2(1 + P4*SNR*S(4,4)^2);      % capacity, stream 4
        CeigW(kk) = CeigW1(kk) + CeigW2(kk) + CeigW3(kk) + CeigW4(kk);     % capacity, sum over all stream
        
    end
    
    Msimo(SNRidx) = mean(Csimo);
    Mmax(SNRidx)  = mean(Cmax);
    Meig(SNRidx)  = mean(CeigAll);    
    MeigW(SNRidx) = mean(CeigW);
    
    
    MeigU1(SNRidx) = mean(CeigU1);
    MeigU2(SNRidx) = mean(CeigU2);
    MeigU3(SNRidx) = mean(CeigU3);
    MeigU4(SNRidx) = mean(CeigU4);
    
    MeigW1(SNRidx) = mean(CeigW1);
    MeigW2(SNRidx) = mean(CeigW2);
    MeigW3(SNRidx) = mean(CeigW3);
    MeigW4(SNRidx) = mean(CeigW4);
    
end




figure(1)
plot(SNRdBvalues, Msimo,'k:')
hold on
plot(SNRdBvalues, Mmax,'k--')
hold on
plot(SNRdBvalues, Meig,'k')
plot(SNRdBvalues, MeigW,'k-.')
title('Capacity for MIMO schemes with CSIT')
xlabel('Average SNR \rho (dB)')
ylabel('Capacity (bits/transmission)')
grid
hold off

figure(2)
a=plot(SNRdBvalues, MeigW1,'k','linewidth',1.5)
hold on
plot(SNRdBvalues, MeigW2,'k','linewidth',1.5)
hold on
plot(SNRdBvalues, MeigW3,'k','linewidth',1.5)
plot(SNRdBvalues, MeigW4,'k','linewidth',1.5)
b=plot(SNRdBvalues, MeigU1,'k:','linewidth',2)
hold on
plot(SNRdBvalues, MeigU2,'k:','linewidth',2)
hold on
plot(SNRdBvalues, MeigU3,'k:','linewidth',2)
plot(SNRdBvalues, MeigU4,'k:','linewidth',2)
c=plot(SNRdBvalues, Msimo,'k-.','linewidth',1)
hold on
d=plot(SNRdBvalues, Mmax,'k--','linewidth',1)
title('Capacity for MIMO schemes with CSIT')
xlabel('Average SNR \rho (dB)')
ylabel('Capacity (bits/transmission)')
grid
title('Capacity per stream for MIMO schemes with CSIT')
xlabel('Average SNR \rho (dB)')
ylabel('Capacity (bits/transmission)')
legend([a b d c],'Eigenmode Tx with WF','Eigenmode Tx with Uniform Power',...
    'Max Eigenmode Tx', 'MISO/SIMO' )
grid
text(6,4.5,'Stream 1')
text(9,3.7,'Stream 2')
text(12,2.7,'Stream 3')
text(15,1.1,'Stream 4')
grid
hold off