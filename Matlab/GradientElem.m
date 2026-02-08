function r = GradientElem(X,Y,P,NoTable,fullFileName)
%calcule du gradient suivant (Ox)
%On a: 
% dT/dx = dT/du*du.dx + dT/dv*dv.dx

    %Extraction de la table des noeuds
    %NodeTable = readGiDNodes(fullFileName);
    %NbNodes = size(NodeTable,1);
    
    %Extraction de la table des éléments
    ElemTable = readGiDElems(fullFileName);
    NbElems = size(ElemTable,1);
    
    %Extraction de la fonction de calcul du nombre
    % d'éléments triangulaires et de contour
    [NbTri,~] = CalculNbElems(fullFileName);
 
 %%Calcul des gradients sur chaque élément
   GradElemTable = zeros(NbElems,2);
    for p=1:NbTri
        %Calcul de la somme du gradient en x 
        %Appel de l'inverse du jacobien
        %invJ = [du/dx, du/dy ; dv/dx, dv/dy
        invJ = InvJacobien(X,Y,P,p);
        
        T1 = d_TriN1(); T2 = d_TriN2(); T3 = d_TriN3();
        x1 = [T1(1), T2(1), T3(1)]*[NoTable(ElemTable(p,4),1); NoTable(ElemTable(p,5),1); NoTable(ElemTable(p,6),1)]*invJ(1,1);
        x2 = [T1(2), T2(2), T3(2)]*[NoTable(ElemTable(p,4),1); NoTable(ElemTable(p,5),1); NoTable(ElemTable(p,6),1)]*invJ(2,1);
        
           GradElemTable(p,1) = x1 + x2 ;

            
         %Calcul de la somme du gradient en y 
        %Appel de l'inverse du jacobien
        %invJ = [du/dx, du/dy ; dv/dx, dv/dy
        %invJ = InvJacobien(X,Y,P,p);
        y1 = [T1(1), T2(1), T3(1)]*[NoTable(ElemTable(p,4),1); NoTable(ElemTable(p,5),1); NoTable(ElemTable(p,6),1)]*invJ(1,2);
        y2 = [T1(2), T2(2), T3(2)]*[NoTable(ElemTable(p,4),1); NoTable(ElemTable(p,5),1); NoTable(ElemTable(p,6),1)]*invJ(2,2);
        
           GradElemTable(p,2) = y1 + y2 ;

    end
    r = GradElemTable;
end

