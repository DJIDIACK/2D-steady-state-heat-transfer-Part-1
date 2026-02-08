function y = TridX_duv(X,P,i)
%calcule de la dérivée de la fonction x du triangle par rapport
% aux deux variables de référence u et v telle que :
%
%
syms u v
y = [diff(TriX_uv(u,v,X,P,i),u), diff(TriX_uv(u,v,X,P,i),v)] ;
end
