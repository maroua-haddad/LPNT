function [distribution]= generate_distribution(variable_values)
distribution = rand(1,variable_values);
%random_vector=randperm(variable_values);
%distribution(1,random_vector(1,1))=1;
temp=find(distribution==max(distribution));
distribution(temp)=1;
distribution=distribution/max(distribution);
