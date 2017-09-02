function info_aff = mean_info_aff(pnet1,pnet2)
nodes_size=pnet1.nodes_size;
N=size(nodes_size,2);
info_aff=0;
for i=1:N
    aff=0;
    cpt1=pnet1.parameters{i};
    cpt2=pnet2.parameters{i};
    ns=pnet1.nodes_size(i);
    cpt_value= size(pnet1.parameters{i},2)/ns;
    j=1;
    while j <= cpt_value
        temp=j:cpt_value:cpt_value*ns;
        aff=aff+info_affinity(cpt1(temp),cpt2(temp));
        j=j+1;
    end
    
    info_aff=info_aff+ (aff/cpt_value);
%info_aff=info_aff+info_affinity(cpt1,cpt2);
end
info_aff=info_aff/N;
