function y = InvJacobien(X,Y,P,i)
%calcule de l'inverse du Jacobien
% Ceci a pour objectif de déterminer la dérivée des fonctions u et v
% par rapport à x et y
% 
% J = [dx/du, dy/du ; dx/dv, dy/dv]
J = Jacobien(X,Y,P,i);
y = inv(J);
% y = [du/dx, du/dy ; dv/dx, dv/dy]
end