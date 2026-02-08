function [y] = d_TriN1()
%calcule de la dérivée de la fonction de forme N1 du traingle par rapport
% aux deux variables de référence u et v telle que :
%
%
syms u v
y = [diff(TriN1(u,v),u), diff(TriN1(u,v),v)] ;
end