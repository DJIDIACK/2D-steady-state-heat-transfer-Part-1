function [ elemFi ] = VectElemContour(X,Y,P,i,h,hc,Tair)
%calcule le second membre élémentaire Fi dans l'élément Ei
% avant l'application des points d'intégration de Gauss
%               Fi
%       |---------------|
%       -1              1
syms u
A = int(h*hc*Tair*LinN1(u)*LindConctour_du(X,Y,P,i),u,-1,1);
B = int(h*hc*Tair*LinN2(u)*LindConctour_du(X,Y,P,i),u,-1,1);
elemFi = [A ; B]; % Vecteur de l'élément numéro Ei
end