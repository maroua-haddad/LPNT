function [dag] = generate_random_pnet_structure(nodes_number,max_parents)
dag = mk_rnd_dag(nodes_number);
for i=1:size(dag)
    if size(find(dag(:,i)==1),1)> max_parents
        A=find(dag(:,i)==1)';
        index = randperm(numel(A));
        A = A(index);
        dag(A(max_parents+1:end),i)=0;
    end
end

