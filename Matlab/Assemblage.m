function [Ke,Fe] = Assemblage(X,Y,P,h,NbTri,NbCont,DDLsL,fullFileName)

% Assemblage des matrices élémentaires "Gausski" dans la matrice globale K
% Assemblage des seconds membres élémentaires "GaussFi" dans le second
% membre global F
% cette fonction fait appel aux fonctions:
%    1) MatElemTriangle(X,Y,P,i,h,K)
%    2) MatElemContour(X,Y,P,i,h,hc)
%    3) VectElemTriHammer(X,Y,P,i,h,fullFileName)
%    4) VectElemContour(X,Y,P,i,h,hc,Tair)
    
    %Extraction de la table des CLEs
    CLETable = readGiDCLEs(fullFileName);

    %Extraction de la table des noeuds
    NodeTable = readGiDNodes(fullFileName);
    
    %Extraction de la table des éléments
    ElemTable = readGiDElems(fullFileName);
    
    %Extraction de la table des matériaux
    MatsTable = readGiDMats(fullFileName);
    
    %Extraction de la table des CLN
    CLNTable = readGiDCLNs(fullFileName);
    
    Ke = zeros(DDLsL);
    Fe = zeros(DDLsL,1);
    
for k=1:NbTri   % boucle sur les éléments triangulaires
        %Requête de la conductivité thermique
        K = MatsTable(ElemTable(k,2),2);
    
        KTri = MatElemTriangle(X,Y,P,k,h,K);  % matrice de l'élément numéro k
        FTri = VectElemTriHammer(X,Y,P,k,h,fullFileName);
        NbDDLs = size(VectElemTriHammer(X,Y,P,k,h,fullFileName));
        %Boucle sur les DDLs ligne des éléments triangulaires
        for i= 1:NbDDLs
            %Récupération du DDL
            LocDDLsLine = [ElemTable(k,9),ElemTable(k,10),ElemTable(k,11)];
            %Test si libre
                if (LocDDLsLine(i) > 0) 
                    %Libre: boucle sur les DDLs colonne
                    for j= 1:NbDDLs
                        %Récupération du DDL
                        LocDDLsCol = [ElemTable(k,9),ElemTable(k,10),ElemTable(k,11)];
                        %Test si libre
                        if (LocDDLsCol(j) > 0) 
                            %Libre donc on ajoute
                            Ke(LocDDLsLine(i),LocDDLsCol(j)) = Ke(LocDDLsLine(i),LocDDLsCol(j)) + KTri(i,j);
                        else
                            %Imposé: contribution de la CL au second membre
                            for p=1:size(NodeTable(),1)
                                if NodeTable(p,5)==LocDDLsCol(j)
                                    ValCLE = CLETable(NodeTable(p,4),3);
                            Fe(LocDDLsLine(i)) = Fe(LocDDLsLine(i)) - KTri(i,j)*ValCLE;
                                end
                            end
                        end 
                    end 
                    %Ajout au second membre avec transport de l'autre côt du = (avec un signe)
                    Fe(LocDDLsLine(i)) = Fe(LocDDLsLine(i)) + FTri(i);
                end 
        end 
        k
end
    
for k=NbTri+1:NbTri+NbCont   % boucle sur les éléments de contour
        %Requête du coefficient de convection
        hc = CLNTable(k-NbTri,2);
        
        %Requête de la température de l'air
        Tair = CLNTable(k-NbTri,3);
    
        KCont = MatElemContour(X,Y,P,k,h,hc);  % matrice de l'élément numéro k
        FCont = VectElemContour(X,Y,P,k,h,hc,Tair); % vecteur de l'élément numéro k
        NbDDLs = size(VectElemContour(X,Y,P,k,h,hc,Tair),1);
        
        %Boucle sur les DDLs ligne des éléments triangulaires
        for i= 1:NbDDLs
            %Récupération du DDL
            LocDDLsLine = [ElemTable(k,9),ElemTable(k,10)];
            %Test si libre
                if (LocDDLsLine(i) > 0) 
                    %Libre: boucle sur les DDLs colonne
                    for j= 1:NbDDLs
                        %Récupération du DDL
                        LocDDLsCol = [ElemTable(k,9),ElemTable(k,10)];
                        %Test si libre
                        if (LocDDLsCol(j) > 0) 
                            %Libre donc on ajoute
                            Ke(LocDDLsLine(i),LocDDLsCol(j)) = Ke(LocDDLsLine(i),LocDDLsCol(j)) + KCont(i,j);
                        else
                            %Imposé: contribution de la CL au second membre
                            for p=1:size(NodeTable(),1)
                                if NodeTable(p,5)==LocDDLsCol(j)
                                    ValCLE = CLETable(NodeTable(p,4),3);
                            Fe(LocDDLsLine(i)) = Fe(LocDDLsLine(i)) - KCont(i,j)*ValCLE;
                                end
                            end
                        end 
                    end 
                    %Ajout au second membre avec transport de l'autre côt du = (avec un signe)
                    Fe(LocDDLsLine(i)) = Fe(LocDDLsLine(i)) - FCont(i);
                end 
        end
        
end   
end