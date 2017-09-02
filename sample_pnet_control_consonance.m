function [observation]= sample_pnet_control_consonance(dag,parameters,nodes_size,order,consonance_degree)
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
temp=find(observation~=0);
observation(temp')=1;

if consonance_degree~=-1
    for i=1:size(dag,1)
        cd=sum(nodes_size(1:i-1))+1;
        subsets=nchoose(find(observation(cd:cd+nodes_size(i)-1)~=0));
        n1=size(subsets,1);
        prob=zeros(1,n1);
        if n1>1
            prob(1:n1-1)=(1-consonance_degree)/(n1-1);
            prob(end)=consonance_degree;
            subset_sample_value=sample(prob);
            obs=zeros(1,nodes_size(i));
            obs(subsets{subset_sample_value})=1;
            observation(cd:cd+nodes_size(i)-1)=obs;
        end
    end
else
    for i=1:size(dag,1)
        cd=sum(nodes_size(1:i-1))+1;
        subsets=find(observation(cd:cd+nodes_size(i)-1)~=0);
        n1=size(subsets,2);
        prob=zeros(1,n1);
        if n1>1
            prob(1:n1)=1/(n1);
            subset_sample_value=sample(prob);
            obs=zeros(1,nodes_size(i));
            obs(subsets(subset_sample_value))=1;
            observation(cd:cd+nodes_size(i)-1)=obs;
        end
    end
end

