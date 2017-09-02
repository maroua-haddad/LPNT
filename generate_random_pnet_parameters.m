function parameters = generate_random_pnet_parameters(cpt_values,nodes_size)
parameters={size(nodes_size,2)};
for i=1:size(nodes_size,2)
    node_parameters=zeros(1,cpt_values{i}*nodes_size(i));
    j=1;
    while j <= cpt_values{i}
        distribution= generate_distribution(nodes_size(i));
        temp=j:cpt_values{i}:cpt_values{i}*nodes_size(i);
        node_parameters(temp)=distribution;
        j=j+1;
    end
    parameters{i}=node_parameters;
end
