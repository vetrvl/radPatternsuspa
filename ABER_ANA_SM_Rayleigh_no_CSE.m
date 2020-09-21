function ABER_Ana=ABER_ANA_SM_Rayleigh_no_CSE(M,Nt,Nr,SNR_Vector)
%
%Inputs
%MSizeofthesignalconstellationdiagram.
%
%NtNumberoftransmitantennas.
%
%NrNumberofreceiveantennas.
%
%SNR_VectorVectorcontainingthesignal-to-noiseratio(SNR)
%valuestocalculatetheABERover.
%
%Output
%ABER_AnaThecalculatedanalyticalABERofSM.
%
%Usage
%ABER_Ana=ABER_ANA_SM_Rayleigh_no_CSE(M,Nt,Nr,SNR_Vector)
%%GeneratingtheM-QAMsignalconstellationsymbols
%ConstructinganM-QAMmodulator
alphabit=modem.qammod('M',M);
%Generatingsignalconstellationdiagram
SigConsDiag=modulate(alphabit,(0:M-1)).';
%Calculatingaveragepowerofthesignalconstellationdiagram
SigConsDiag_avg=SigConsDiag'*SigConsDiag/M;
%Normalizingthepowerofthesignalconstellationdiagram
SigConsDiag=SigConsDiag/sqrt(SigConsDiag_avg);
%%CalculatingtheanalyticalABER
%CalculatingthespectralefficiencyofSM
eta=log2(Nt)+log2(M);
%PreallocatevariablestostorethecalculatedABER
ABER_Ana=zeros(size(SNR_Vector));
for snr=1:length(SNR_Vector)
    %Calculatingthenoisevariancesigma_n^2
    %Note,E[|Hx|^2]=1isassumed
    sigma_n=(1/10^(SNR_Vector(snr)/10));
    for ell_t=1:Nt
        for ell=1:Nt
            for i_t=1:M
                for i=1:M
                    if ell_t==ell
                        Psi=abs(SigConsDiag(i_t)-SigConsDiag(i))^2;
                        BarGamma_SM=(1/(2*sigma_n))*Psi;
                    else
                        Psi=abs(SigConsDiag(i_t))^2+...
                            abs(SigConsDiag(i))^2;
                        BarGamma_SM=(1/(2*sigma_n))*Psi;
                    end
                    alpha_a=(1/2)*(1-sqrt((BarGamma_SM/2)/...
                        (1+(BarGamma_SM/2))));
                    %CalculatingthePEPfor thisevent
                    PEP=0;
                    for nr=0:(Nr-1)
                        PEP=PEP+nchoosek(Nr-1+nr,nr)*(1-alpha_a)^nr;
                    end
                    PEP=alpha_a^Nr*PEP;
                    %Numberofbitsinerrorfor thisevent
                    bitError=(biterr(ell_t-1,ell-1,log2(Nt))...
                        +biterr(i_t-1,i-1,log2(M)))/eta;
                    %CalculatingtheABER
                    ABER_Ana(snr)=ABER_Ana(snr)+bitError*PEP;
                end
            end
        end
    end
end
ABER_Ana=ABER_Ana/2^eta;