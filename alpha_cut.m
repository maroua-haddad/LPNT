function [cut] = alpha_cut(alpha,distribution)
cut=zeros(1,size(distribution,2));
for i=1:size(distribution,2)
    if(distribution(i)>=alpha)
        cut(i)=distribution(i);
    end
end


