function  y = TriN2(u)
%calcule la fonction de forme N2 du triangle telle que: 
%
%
syms v
P=[1 1 1;0 1 0;0 0 1];
TransP = inv(P);
    y = TransP(2,1) + TransP(2,2)*u + TransP(2,3).*v;
end