function [y] = d_TriN2()
%calcule de la dérivée de la fonction de forme N2 du traingle par rapport
% aux deux variables de référence u et v telle que :
%
%
syms u v
y = [diff(TriN2(u),u), diff(TriN2(u),v)] ;
end