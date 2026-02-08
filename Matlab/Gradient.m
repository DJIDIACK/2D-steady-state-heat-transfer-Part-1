function r = Gradient(X,Y,P,NoTable,fullFileName)
%calcule du gradient suivant (Ox)
%On a: 
% dT/dx = dT/du*du.dx + dT/dv*dv.dx

    %Extraction de la table des noeuds
    NodeTable = readGiDNodes(fullFileName);
    NbNodes = size(NodeTable,1);
    
    %Extraction de la table des éléments
    ElemTable = readGiDElems(fullFileName);
    %NbElems = size(ElemTable,1);
    
    %Extraction de la fonction de calcul du nombre
    % d'éléments triangulaires et de contour
    [NbTri,~] = CalculNbElems(fullFileName);
 
   %Calcul des gradients sur chaque élément
   GradElemTable = GradientElem(X,Y,P,NoTable,fullFileName);
    
    %% Calcul du gradient de contribution sur chaque noeud
    
    GradTable = zeros(NbNodes,2);
    occ = zeros(NbNodes,2);
    for p=1:NbTri
        %Calcul de la somme du gradient en x 
        
        GradTable(ElemTable(p,4),1) = GradTable(ElemTable(p,4),1) + GradElemTable(p,1) ;
        occ(ElemTable(p,4),1)=occ(ElemTable(p,4),1)+1;
        GradTable(ElemTable(p,5),1) = GradTable(ElemTable(p,5),1) + GradElemTable(p,1) ;
        occ(ElemTable(p,5),1)=occ(ElemTable(p,5),1)+1;
        GradTable(ElemTable(p,6),1) = GradTable(ElemTable(p,6),1) + GradElemTable(p,1) ;
        occ(ElemTable(p,6),1)=occ(ElemTable(p,6),1)+1;        
            
         %Calcul de la somme du gradient en y 

        GradTable(ElemTable(p,4),2) = GradTable(ElemTable(p,4),2) + GradElemTable(p,2) ;
        occ(ElemTable(p,4),2)=occ(ElemTable(p,4),2)+1;
        GradTable(ElemTable(p,5),2) = GradTable(ElemTable(p,5),2) + GradElemTable(p,2) ;
        occ(ElemTable(p,5),2)=occ(ElemTable(p,5),2)+1;
        GradTable(ElemTable(p,6),2) = GradTable(ElemTable(p,6),2) + GradElemTable(p,2) ;
        occ(ElemTable(p,6),2)=occ(ElemTable(p,6),2)+1;         
                 
    end
    
    for pq=1:NbNodes
        GradTable(pq,1)=GradTable(pq,1)/occ(pq,1);
        GradTable(pq,2)=GradTable(pq,2)/occ(pq,2);
    end
    r = GradTable;
end

