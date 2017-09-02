%transforme le tuples des indices en 0 et 1 
%size_node pour définir la taille du tuple résultant et le nombre de
%valeurs par attribut
%t le tuple à traiter
function tuple= tranform_tuple_indix(t,nodes_size)
tuple=zeros(1,sum(nodes_size)); %on initialise le tuple en 0
%on met 1 pour chaque indice contenu dans le tuple
for i=1:size(nodes_size,2)
    if t(1,i)~=0
        tuple(sum(nodes_size(1:i-1))+t(1,i))=1;
    end
end
