function [U] = CalculSolution(X,Y,P,h,NbTri,NbCont,DDLsL,fullFileName)
% fonction traite le calcul des solutions sur un toute la longueur du 

[Ke,Fe] = Assemblage(X,Y,P,h,NbTri,NbCont,DDLsL,fullFileName);
 
% Résolution 
U=linsolve(Ke,Fe);
end

