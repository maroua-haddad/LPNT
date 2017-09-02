function [pnet,Execution_time] = learn_parameters(file, pnet)
%Si = compute_imprecision_degree_dataset(file, pnet.nodes_size);
Si=ones(1,size(pnet.nodes_size,2));
t0=cputime;
[certainset, frequency,nb_obs] = preprocess(file,pnet.nodes_size);
for i=1:size(pnet.dag,2)
    correction=0;
    r=find(pnet.dag(:,i)==1)';
    sets={1,size(r,2)+1};
    [parents] = intersect(pnet.order,r,'stable');
    sets{1}=1:pnet.nodes_size(i);
    for j=1:size(parents,2)
        temp=1:pnet.nodes_size(parents(j));
        sets{j+1}=temp;
    end
    res=allcomb(sets{:});
    N_res=size(res,1);
    cpt=zeros(1,N_res);
    if  isempty(r)
        for j=1:pnet.nodes_size(i)
            tuple=zeros(1,size(pnet.nodes_size,2));
            tuple(i)=res(j,1);
            tuple1=tranform_tuple_indix(tuple,pnet.nodes_size);
            nb1= maxprojection(certainset,frequency, tuple1);
            cpt(j)=nb1;
            cpt=cpt/nb_obs;
        end
        cpt=cpt.*Si(i);
        pnet.parameters{i}= cpt./max(cpt);
    else
        for j=1:N_res
            tuple=zeros(1,size(pnet.nodes_size,2));
            for k=1:size(r,2)
                temp=find(parents==r(k));
                value=res(j,temp+1);
                tuple(r(k))=value;
            end
            tuple(i)=res(j,1);
            tuple1=tranform_tuple_indix(tuple,pnet.nodes_size);
            nb1= maxprojection(certainset,frequency, tuple1);
            cpt(j)=nb1;
        end
            cpt=cpt/nb_obs;
        j=1;
        while j <= size(cpt,2)/pnet.nodes_size(i)
            temp=j:size(cpt,2)/pnet.nodes_size(i):size(cpt,2);
            cpt(temp)=  cpt(temp)./max(cpt(temp));
            cpt(temp)=  cpt(temp).*Si(i);
            cpt(temp)=  cpt(temp)./max(cpt(temp));
            j=j+1;
        end
        pnet.parameters{i}=cpt;
    end
end
Execution_time=num2str(cputime -t0);
end

