%% NU BER LOS MISO Holographic Beamformer Case

clc
clear
close all

SNR_range=-35:5:10;
nearuser_mod='BPSK';M_near=2;
faruser_mod='BPSK';M_far=2;

alpha=0.4; %power allocation factor

bpcu=log2(M_far)+log2(M_near);                      % bits per channel use (SE)

bits_total=10000*bpcu;               % total number of bits (increase this number of higher SNR)

% bits_total=bpcu*2;
decodedNU=zeros(1,bits_total);
M=M_far * M_near;
% ris_state="BLIND";

Gt=db2pow(25)
Gr=db2pow(5)
P_bs=db2pow(10)
freq_oper=30e9;
lambda=3e8./freq_oper;
a=lambda/5;
b=a;

betaconst= sqrt((P_bs.*Gt.*Gr/(4.*pi)^2).*((a.*b)./(K.*di)).^2)

for K=[16 32 64] %2N
    for lll=1:length(SNR_range)
        lll
        bit_seq=randi(2,1,bits_total)-1;
        sigma=sqrt((1)/(2*(10^(SNR_range(lll)/10)))); % SNR=Es/NP (Es=1)  noise samples ~ CN(0,NP)  NP: noise power = 2*sigma^2
        
        % ss=qammod(0:M-1,M,'Gray');         % Gray-encoded signal constellation
        ss=input_symbolsNoma(nearuser_mod,faruser_mod,alpha);
        % ss=ss./sqrt(mean(abs(ss).^2));     % normalization
        
        ssfar=[-1 1];
        if M_far==4
            ssfar=[-1-1j -1+1j 1-1j 1+1j];
        end
        kk=1;
        for iteration=1:bits_total/bpcu
            
            bits=bit_seq(kk:kk+bpcu-1);
            
            
            if M_far==4
                bitsfar(iteration,:)=bit_seq(kk+2:kk+bpcu-1);
            else
                bitsfar(iteration)=bit_seq(kk);
            end
            % Bin2Dec & Symbols
            
            dec=sum(bits(1:log2(M)).*[2.^(log2(M)-1:-1:0)])+1;
            x=ss(dec);
            
            
            decFU=sum(bitsfar(1))+1;
            xfar=ssfar(decFU);
            
            
            
            % Received Signal
            
            n1=(sigma).*(randn + 1i*randn);
            n2=sqrt(0.5)*(sigma).*(randn + 1i*randn);
            
            
            rnear = K * x + n1;
            rfar = K * x + n2;
            
            % Maximum Likelihood Detector
            
            metrics1=zeros(1,M);
            ss1=metrics1;
            
            
            count=1;
            for count1=1:M
                
                metrics1(count)=norm(rnear - K*ss(count1))^2;
                
                ss1(count)=count1;
                
                
                count=count+1;
                
            end
            counta=1;
            for count2=1:M_far
                metrics2(counta)=norm(rfar - K*ssfar(count2))^2;
                ss2(counta)=count2;
                counta=counta+1;
            end
            
            
            
            [a1,a2]=min(metrics1);
            [aa1,aa2]=min(metrics2);
            % a1 % should be close to zero at high SNR
            
            
            % Dec2Bin
            dec1=zeros(1,log2(M));
            for pp=1:log2(M)
                dec1(pp)=mod(floor((ss1(a2)-1)/(2^(log2(M)-pp))),2);
            end
            for pp1=1:log2(M_far)
                dec2(pp1)=mod(floor((ss2(aa2)-1)/(2^(log2(M_far)-pp1))),2);
            end
            %                 dec1
            %                 dec2
            %                  bit_seq
            %                  xfar
            decodedNU(kk:kk+log2(M)-1)=dec1;
            decodedFU(kk:kk+log2(M_far)-1)=dec2;
            %                 decodedFU(kk)=dec2;
            kk=kk+log2(M_far)+log2(M_near);
            
        end
        
        if M_far==4
            decodesclev=decodedFU(1:end);
        elseif M_far==2
            decodesclev=decodedFU(1:3:end);
        end
        %  [decodedFU(1), decodedFU(end)]
        
        bit_errorsNU=sum(xor(bit_seq,decodedNU));
        %             bit_errorsFU=sum(xor(bitsfar,decodesclev));
        BERNU(lll)=bit_errorsNU/(bits_total);
        %             BERFU(lll)=bit_errorsFU/(bits_total/3);
        
    end
%     if strcmp(ris_state,"BLIND")==1
%         stringidentif=strcat(num2str(K/2),"RIS OFF NU Simu");
%         stringidentif1=strcat(num2str(K/2),"RIS OFF FU Simu");
%     else
        stringidentif=strcat("NU BER Simu ","RIS N = ",num2str(K/2));
        stringidentif1=strcat("FU BER Simu","RIS N = ",num2str(K/2));
%     end
    % hold on
    
    semilogy(SNR_range,BERNU,'*-','DisplayName',stringidentif)%
    grid on
    hold on
    %         semilogy(SNR,BERFU,'--','DisplayName',stringidentif1)
end
legend show