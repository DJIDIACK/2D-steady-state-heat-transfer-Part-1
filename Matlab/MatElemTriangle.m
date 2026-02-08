function [ elemKi ] = MatElemTriangle(X,Y,P,i,h,K)
%calcule la matrice élémentaire Ki dans l'élément Ei
% avant l'application des points d'intégration de Gauss
%               Ki
%       |---------------|
%       -1              1
%

InvJ= InvJacobien(X,Y,P,i);
B = [-InvJ(1,1)-InvJ(2,1), InvJ(1,1), InvJ(2,1) ; -InvJ(1,2)-InvJ(2,2), InvJ(1,2), InvJ(2,2)];
C = B';
J = Jacobien(X,Y,P,i);
DetJ = det(J);
Ki = [K,0;0,K];

elemKi=-0.5*h*DetJ*C*Ki*B; % matrice de l'élément numéro Ei
end