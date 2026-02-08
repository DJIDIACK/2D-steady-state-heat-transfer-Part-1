function y = Jacobien(X,Y,P,i)
%calcule le Jacobien du triangle par rapport
% aux deux variables de référence u et v telle que :
%
%
Jx = TridX_duv(X,P,i);
Jy = TridY_duv(Y,P,i);
y = [Jx(1), Jx(2) ; Jy(1), Jy(2)] ;
end