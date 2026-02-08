function r = Flux(X,Y,P,NoTable,fullFileName)

    %Extraction de la table des noeuds
    NodeTable = readGiDNodes(fullFileName);
    NbNodes = size(NodeTable,1);
    
    %Extraction de la table des éléments
    ElemTable = readGiDElems(fullFileName);
    %NbElems = size(ElemTable,1);
    
    %Extraction de la fonction de calcul du nombre
    % d'éléments triangulaires et de contour
    [NbTri,~] = CalculNbElems(fullFileName);
    
    %Extraction de la table des matériaux
    MatsTable = readGiDMats(fullFileName);

    %Requête de la table des gradients
    %GradTable = Matrice(NbNodes,2)
    %GradTable(X-Gradient,Y-Gradient)
    GradElemTable = GradientElem(X,Y,P,NoTable,fullFileName);
     
 for k=1:NbTri   % boucle sur les nodes 
        %Requête de la conductivité thermique
        K = MatsTable(ElemTable(k,2),2);
        %Requête de la conductivité thermique
        FluxElemTable = -K*GradElemTable;
 end
     %% Calcul du gradient de contribution sur chaque noeud
    
    FluxTable = zeros(NbNodes,2);
    occ = zeros(NbNodes,2);
    for p=1:NbTri
        %Calcul de la somme du gradient en x 
        
        FluxTable(ElemTable(p,4),1) = FluxTable(ElemTable(p,4),1) + FluxElemTable(p,1) ;
        occ(ElemTable(p,4),1)=occ(ElemTable(p,4),1)+1;
        FluxTable(ElemTable(p,5),1) = FluxTable(ElemTable(p,5),1) + FluxElemTable(p,1) ;
        occ(ElemTable(p,5),1)=occ(ElemTable(p,5),1)+1;
        FluxTable(ElemTable(p,6),1) = FluxTable(ElemTable(p,6),1) + FluxElemTable(p,1) ;
        occ(ElemTable(p,6),1)=occ(ElemTable(p,6),1)+1;        
            
         %Calcul de la somme du gradient en y 

        FluxTable(ElemTable(p,4),2) = FluxTable(ElemTable(p,4),2) + FluxElemTable(p,2) ;
        occ(ElemTable(p,4),2)=occ(ElemTable(p,4),2)+1;
        FluxTable(ElemTable(p,5),2) = FluxTable(ElemTable(p,5),2) + FluxElemTable(p,2) ;
        occ(ElemTable(p,5),2)=occ(ElemTable(p,5),2)+1;
        FluxTable(ElemTable(p,6),2) = FluxTable(ElemTable(p,6),2) + FluxElemTable(p,2) ;
        occ(ElemTable(p,6),2)=occ(ElemTable(p,6),2)+1;         
                 
    end
    
    for pq=1:NbNodes
        FluxTable(pq,1)=FluxTable(pq,1)/occ(pq,1);
        FluxTable(pq,2)=FluxTable(pq,2)/occ(pq,2);
    end
    r = FluxTable;
end