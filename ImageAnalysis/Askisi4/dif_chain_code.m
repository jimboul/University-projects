function dif=dif_chain_code(cc)   
    [~,N]=size(cc);                                 
    dif = zeros(N-1);
    for i=1:N-1                                      
        dif(i)=mod((cc(i+1)-cc(i)),4);     
    end                                                   
    dif(N)=mod((cc(1)-cc(end)),4);      
end                                                       