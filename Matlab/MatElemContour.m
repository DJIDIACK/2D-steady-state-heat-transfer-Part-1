function [ elemKi ] = MatElemContour(X,Y,P,i,h,hc)
%calcule la matrice élémentaire Ki dans l'élément Ei
% avant l'application des points d'intégration de Gauss
%               Ki
%       |---------------|
%       -1              1
%
syms u
A=int(-h*hc*LindConctour_du(X,Y,P,i)*LinN1(u)^2,u,-1,1);
B=int(-h*hc*LindConctour_du(X,Y,P,i)*LinN1(u)*LinN2(u),u,-1,1);
C=int(-h*hc*LindConctour_du(X,Y,P,i)*LinN2(u)^2,u,-1,1);
elemKi=[A B;B C]; % matrice de l'élément numéro Ei
end