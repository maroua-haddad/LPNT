function [observation]= sample_parentless_variable (observation,nodes_size,node,parameters)
sample_value = sample_variable(parameters);
cd= sum(nodes_size(1:node-1))+1;
observation(1,cd:cd+nodes_size(node)-1)= sample_value;