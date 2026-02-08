function [X, Y, P] = Maillage(fullFileName)
%----------------------------
%Génére un maillage de type
% X la table des coordonnées
% P la table de connectivité moyennant les indices
%----------------------------
    NodeTable = readGiDNodes(fullFileName);
    ElemTable = readGiDElems(fullFileName);
    
X = NodeTable(:,2);
Y = NodeTable(:,3);

P = [ElemTable(:,4),ElemTable(:,5),ElemTable(:,6)];
end