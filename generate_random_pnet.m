function [pnet] = generate_random_pnet(nodes_number,max_parents,max_values)
pnet.dag = generate_random_pnet_structure(nodes_number,max_parents);
pnet.nodes_size = randi([2 max_values],1,nodes_number);
cpt_values={size(pnet.nodes_size,2)};
for i=1:size(pnet.nodes_size,2)
    %nombre des combinaisons de parents d'une variable donnée
    cpt_value= max(prod(pnet.nodes_size((find(pnet.dag(:,i)==1))')),1);
    cpt_values{i}=cpt_value;
end

pnet.parameters = generate_random_pnet_parameters(cpt_values,pnet.nodes_size);
pnet.order = graphtopoorder(sparse(pnet.dag));
