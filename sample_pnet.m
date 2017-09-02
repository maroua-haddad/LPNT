function [observation]= sample_pnet (dag,parameters,nodes_size,order)
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