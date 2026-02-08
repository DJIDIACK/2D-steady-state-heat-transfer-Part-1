function y = LindConctour_du(X,Y,P,i)
%calcule de la dérivée de la fonction x telle que :
% dx/du=a(1) ou b(1) et a=[a1;a2] , b=[b1;b2]
y = sqrt(LindX_du(X,P,i)^2 + LindY_du(Y,P,i)^2);
end