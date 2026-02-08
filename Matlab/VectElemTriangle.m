function [ elemFi ] = VectElemTriangle(u,v,X,Y,P,i,Q,h)
%calcule le second membre élémentaire Fi dans l'élément Ei
% avant l'application des points d'intégration de Gauss
%               Fi
%       |---------------|
%       -1              1
J = Jacobien(X,Y,P,i);
DetJ = det(J);
elemFi = [h*DetJ*TriN1(u,v)*Q ; h*DetJ*TriN2(u)*Q ; h*DetJ*TriN3(v)*Q]; % Vecteur de l'élément numéro Ei
end