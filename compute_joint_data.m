function joint_dis_data = compute_joint_data(file, nodes_size)
[certainset, frequency,nb_obs] = preprocess(file,nodes_size);
sets={};
for i=size(nodes_size,2):-1:1
    temp=[1:nodes_size(i)];
    sets{end+1}=temp;
end
N = numel(sets);
v = cell(N,1);
[v{:}] = ndgrid(sets{:});
res = reshape(cat(N+1,v{:}),[],N);
for i=1:size(res,2)/2
    TEMP=res(:,i);
    res(:,i)=res(:,size(res,2)-i+1);
    res(:,size(res,2)-i+1)=TEMP;
end
joint_dis_data=ones(1,prod(nodes_size));
for i=1:size(res,1)
    tuple=tranform_tuple_indix(res(i,:),nodes_size);
    joint_dis_data(i)=maxprojection(certainset,frequency, tuple)/nb_obs;
end
joint_dis_data=joint_dis_data./max(joint_dis_data);
