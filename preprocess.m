function [u_mat,u,nb_obs] = preprocess_borgelt(file,size_node)

fid = fopen(file,'r');
mat = importdata(file,',');
nb_obs=size(mat,1);

if (nb_obs > 5000)
    mat0= mat(1:5000,:);
    [u_mat I J]=unique(mat0,'rows','first');
    u=sum(repmat(J,1,size(u_mat,1))==repmat((1:size(u_mat,1)),size(mat0,1),1));
    [k l]=sort(I);
    u_mat=mat0(k,:);
    u=u(l);
    
    mat1= mat(5001:end,:);
    [u_mat1 I J]=unique(mat1,'rows','first');
    u1=sum(repmat(J,1,size(u_mat1,1))==repmat((1:size(u_mat1,1)),size(mat1,1),1));
    [k l]=sort(I);
    u_mat1=mat1(k,:);
    u1=u1(l);
    
    u=[u u1];
    u_mat=[u_mat; u_mat1];
else
    [u_mat I J]=unique(mat,'rows','first');
    u=sum(repmat(J,1,size(u_mat,1))==repmat((1:size(u_mat,1)),size(mat,1),1));
    [k l]=sort(I);
    u_mat=mat(k,:);
    u=u(l);
end
%     s=size(u,2);
%     for i=1:s
%         [intersect_tuple,indix]=closure_under_tuple_intersection(u_mat(i,:),u_mat(1:s,:),size_node,i+1);
%         for j=1:size(indix,2);
%             if intersect_tuple(j,:)== u_mat(i,:)
%                 u(i)=u(i)+u(indix(j));
%             else
%                 u_mat=[u_mat; intersect_tuple(j,:)];
%                 u=[u u(indix(j))];
%             end
%         end
%     end
%     
    
    
fclose(fid);
