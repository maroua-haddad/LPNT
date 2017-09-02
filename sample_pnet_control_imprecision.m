function [observation]= sample_pnet_control_imprecision(dag,parameters,nodes_size,order,imprecision_degree)
observation=zeros(1,sum(nodes_size));
order1=order;
while ~isempty(order1)
    if nodes_size(order1(1))==size(parameters{order1(1)},2)%parentless node
        observation=sample_parentless_variable (observation,nodes_size,order1(1),parameters{order1(1)});
    else
        observation=sample_conditioned_variable (observation,nodes_size,order1(1),parameters{order1(1)},dag,order);
    end
    order1(1)=[];
end

for i=1:size(dag,1)
    cd=sum(nodes_size(1:i-1))+1;
    obs=observation(cd:cd+nodes_size(i)-1);
    temp=find(obs~=0);
    if size(temp,2)>1
        max_degree = max(obs);
        pos_max_degree=find(obs==max_degree);
        temp(find(temp==pos_max_degree))=[];
        subsets=nchoose(temp);
        n1=size(subsets,1);
        prob=zeros(1,n1);
        for j=1:n1-1
            prob(j)=(imprecision_degree^(size(subsets{j},2)))*((1-imprecision_degree)^(size(subsets{n1},2)-size(subsets{j},2)));
        end
        prob(n1)=imprecision_degree^(size(subsets{n1},2));
        prob(n1+1)=(1-imprecision_degree)^(size(subsets{n1},2));
        subset_sample_value=sample(prob);
        subsets{n1+1}=[];
        obs=zeros(1,nodes_size(i));
        obs(union(subsets{subset_sample_value},pos_max_degree))=1;
        observation(cd:cd+nodes_size(i)-1)=obs;
    end
end

temp=find(observation~=0);
observation(temp')=1;
