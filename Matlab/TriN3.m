function  y = TriN3(v)
%calcule la fonction de forme N3 du triangle telle que: 
%
%
syms u
P=[1 1 1;0 1 0;0 0 1];
TransP = inv(P);
    y = TransP(3,1) + TransP(3,2)*u + TransP(3,3).*v;
end