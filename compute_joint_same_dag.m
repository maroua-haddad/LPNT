function [joint_dis1,joint_dis2] = compute_joint_same_dag(pnet1,pnet2)
sets={};
for i=1:size(pnet1.nodes_size,2)
    sets{i}=[1:pnet1.nodes_size(i)];
end
res=allcomb(sets{:});
joint_dis1=ones(1,prod(pnet1.nodes_size));
joint_dis2=ones(1,prod(pnet1.nodes_size));
for i=1:size(res,1);
    comb=res(i,:);
    for j=1:size(comb,2);
        cpt1=pnet1.parameters{j};
        cpt2=pnet2.parameters{j};
        if pnet1.nodes_size(j)==size(cpt1,2)%parentless node
            j_d=cpt1(comb(j));
            joint_dis1(i)=joint_dis1(i)*j_d;
            j_d=cpt2(comb(j));
            joint_dis2(i)=joint_dis2(i)*j_d;
        else
            r=find(pnet1.dag(:,j)==1)'; %list of parents
            parents = intersect(pnet1.order,r,'stable');
            comb_node=zeros(1,size(parents,2)+1);
            comb_node(1)=comb(j);
            for w=1:size(parents,2)
                comb_node(w+1)=comb(parents(w));
            end
            sets={};
            sets{1}=1:pnet1.nodes_size(j);
            for w=1:size(parents,2)
                temp=1:pnet1.nodes_size(parents(w));
                sets{end+1}=temp;
            end
            res_node=allcomb(sets{:});
            temp=find(ismember(res_node,comb_node,'rows'));
            
            j_d=cpt1(temp);
            joint_dis1(i)=joint_dis1(i)*j_d;
            j_d=cpt2(temp);
            joint_dis2(i)=joint_dis2(i)*j_d;
        end
    end
end

