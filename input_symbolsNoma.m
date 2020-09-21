function Noma_superpostion_encode=input_symbolsNoma(nearuser_mod,faruser_mod,alpha)
%faruser_mod= bpsk / qpsk
%nearuser_mod= bpsk / qpsk
%alpha= powerallocation factor between 0 to 1
%alpha=0.4;
ps=1;%*db2pow(-SNRtx(ii));
P_nearuser=alpha*ps;
P_faruser=(1-alpha)*ps;
allpossible_symbolsQPSK=[1+1j,1-1j,-1+1j,-1-1j];
allpossible_symbolsBPSK=[-1,1];
if nearuser_mod == "QPSK"
    if faruser_mod == "QPSK"
        
        allPossible_noma_symbols=zeros(4,4);
        for symb1constr=1:4
            for symb2constr=1:4
                allPossible_noma_symbols(symb1constr,symb2constr)=sqrt(P_faruser)*allpossible_symbolsQPSK(symb1constr)...
                    +sqrt(P_nearuser)*allpossible_symbolsQPSK(symb2constr);
            end
        end
        
    elseif faruser_mod == "BPSK"
        allPossible_noma_symbols=zeros(2,4);
        for symb1constr=1:2
            for symb2constr=1:4
                allPossible_noma_symbols(symb1constr,symb2constr)=sqrt(P_faruser)*allpossible_symbolsBPSK(symb1constr)...
                    +sqrt(P_nearuser)*allpossible_symbolsQPSK(symb2constr);
            end
        end
        
    end
elseif nearuser_mod == "BPSK"
    if faruser_mod == "BPSK"
        allPossible_noma_symbols=zeros(2,2);
        for symb1constr=1:2
            for symb2constr=1:2
                allPossible_noma_symbols(symb1constr,symb2constr)=sqrt(P_faruser)*allpossible_symbolsBPSK(symb1constr)...
                    +sqrt(P_nearuser)*allpossible_symbolsBPSK(symb2constr);
            end
        end
        
    end
    
end
Noma_superpostion_encode=reshape(allPossible_noma_symbols',1,[]);
%     scatterplot(Noma_superpostion_encode)