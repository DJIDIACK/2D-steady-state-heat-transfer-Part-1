function  y = TriN1(u,v)
%calcule la fonction de forme N1 du triangle telle que: 
%
%
P=[1 1 1;0 1 0;0 0 1];
TransP = inv(P);
    y = TransP(1,1) + TransP(1,2)*u + TransP(1,3).*v;
end