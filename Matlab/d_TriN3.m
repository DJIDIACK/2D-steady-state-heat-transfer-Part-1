function [y] = d_TriN3()
%calcule de la dérivée de la fonction de forme N1 du traingle par rapport
% aux deux variables de référence u et v telle que :
%
%
syms u v
y = [diff(TriN3(v),u), diff(TriN3(v),v)] ;
end