function joint_dis = compute_joint(pnet)
sets={};
for i=1:size(pnet.nodes_size,2)
    sets{i}=[1:pnet.nodes_size(i)];
end
res=allcomb(sets{:});
joint_dis=ones(1,prod(pnet.nodes_size));
for i=1:size(res,1);
    comb=res(i,:);
    for j=1:size(comb,2);
        cpt=pnet.parameters{j};
        if pnet.nodes_size(j)==size(cpt,2)%parentless node
            j_d=cpt(comb(j));
            joint_dis(i)=joint_dis(i)*j_d;
        else
            r=find(pnet.dag(:,j)==1)'; %list of parents
            parents = intersect(pnet.order,r,'stable');
            comb_node=zeros(1,size(parents,2)+1);
            comb_node(1)=comb(j);
            for w=1:size(parents,2)
                comb_node(w+1)=comb(parents(w));
            end
            sets={};
            sets{1}=1:pnet.nodes_size(j);
            for w=1:size(parents,2)
                temp=1:pnet.nodes_size(parents(w));
                sets{end+1}=temp;
            end
            res_node=allcomb(sets{:});
            temp=find(ismember(res_node,comb_node,'rows'));
            
            j_d=cpt(temp);
            joint_dis(i)=joint_dis(i)*j_d;
        end
    end
end
