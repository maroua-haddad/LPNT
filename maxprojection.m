function[maxproj_m]= maxprojection(certainset,frequency, tuple)
maxproj_m= 0;
for i=1:size(certainset,1)
    X=find(certainset(i,:)==1);
    Y=find(tuple==1);
    if ismember(Y,X)
        maxproj_m=[maxproj_m frequency(i)];
    end
end
maxproj_m=sum(maxproj_m);
