function [ HammerFi ] = VectElemTriHammer(X,Y,P,i,h,fullFileName)
%calcule le second membre élémentaire Fi dans l'élément Ei
%       à l'aide des points du schémas de Hammer
% cette fonction fait appel aux fonctions:
%    1) SchemasHammer
%    2) VectElemTriangle(u,v,X,Y,P,i,Q,h)

        r = SchemasHammer() ;   % Appelle du schémas de Hammer 
        Q = readGiDSrcs(fullFileName); %Appelle de la fonction source/puits
        HammerFi = zeros(3,1); % Initialisation de la matrice

    if Q==0
        HammerFi=[0;0;0];
        return;
    end 
    for j=1:3
        Q(i,2)= 10.*TriX_uv(r(j,1),r(j,2),X,P,i).*TriY_uv(r(j,1),r(j,2),Y,P,i);
        HammerFi= HammerFi + VectElemTriangle(r(j,1),r(j,2),X,Y,P,i,Q(i,2),h).*r(j,3);
        % Vecteur de l'élément numéro Ei
    end
end