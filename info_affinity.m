%cette fonction calcule information affinity entre deux distributions de
%possibilit�s attention a corriger
function [aff] = info_affinity(dist1,dist2)
k=1;
l=1;
for i=1:size(dist1,2)
dist(1,i)=min(dist1(1,i),dist2(1,i));
end
aff= 1-((k* manhattan_distance(dist1,dist2))+(l*inconsistency(dist)))/(k+l);