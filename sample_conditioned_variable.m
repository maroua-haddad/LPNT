function observation = sample_conditioned_variable (observation,nodes_size,node,parameters,dag,order)
r=find(dag(:,node)==1); %list of parents
[parents] = intersect(order,r','stable');
distribution= dispatching_parameters (observation,parameters,nodes_size, node, parents);
sample_value = sample_variable(distribution);
cd= sum(nodes_size(1:node-1))+1;
observation(1,cd:cd+nodes_size(node)-1)= sample_value;
end

