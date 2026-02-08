function y = LindY_du(Y,P,i)
%calcule de la dérivée de la fonction x telle que :
% dx/du=a(1) ou b(1) et a=[a1;a2] , b=[b1;b2]
a=[-1 1;1 1]\[1;0];
b=[-1 1;1 1]\[0;1];
y = a(1)*Y(P(i,1))+b(1)*Y(P(i,2));
end
