function [Execution_time]= sampling(pnet,nsamples,num,max_values,version,repertoire)

%repertoire = 'D:\Mes fichiers\mes études\thèse\LPNT\sampling\exp1\';
t0=cputime;
name = strcat('Dataset',num2str(num));
nbvar = size(pnet.dag,1);
sep='_';
file_net_txt=[repertoire strcat(name,sep,num2str(nbvar),sep,num2str(max_values),sep,num2str(nsamples),sep,'version',num2str(version),'.txt')];
file_net_csv=[repertoire strcat(name,sep,num2str(nbvar),sep,num2str(max_values),sep,num2str(nsamples),sep,'version',num2str(version),'.csv')];
fid_txt = fopen(file_net_txt,'w');
%fid_txt = fopen('myFile.txt','w');
fid_csv = fopen(file_net_csv,'w');
for i=1:nsamples
    ob= sample_pnet (pnet.dag,pnet.parameters,pnet.nodes_size,pnet.order);
    dlmwrite(file_net_txt,ob,'-append','delimiter',',');
    %dlmwrite('myFile.txt',ob,'-append','delimiter',',');
    j=1;
    str='';
    while j<=size(pnet.nodes_size,2)
        cd= sum(pnet.nodes_size(1:j-1))+1;
        cf= cd + pnet.nodes_size(j)-1;
        temp=find(ob(cd:cf)==1);
        str=strcat(str,'{',num2str(temp),'},');
        j=j+1;
    end
    fprintf(fid_csv,'%s \n', str);
end
disp('Imprecise data have been created');
Execution_time=num2str(cputime -t0);
fclose all;

