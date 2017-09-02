%Cette fonction calcule manhattan distance between deux distributions de possibilités 
function [distance] = manhattan_distance(dist1,dist2)
sum=0;
for i=1:size(dist1,2)
    num1=dist1(1,i);
    num2=dist2(1,i);
    sum=sum+abs(num1-num2);
end
distance=sum/size(dist1,2);