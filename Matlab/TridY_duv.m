function y = TridY_duv(Y,P,i)
%calcule de la dérivée de la fonction y du triangle par rapport
% aux deux variables de référence u et v telle que :
%
%
syms u v
y = [diff(TriY_uv(u,v,Y,P,i),u), diff(TriY_uv(u,v,Y,P,i),v)] ;
end
