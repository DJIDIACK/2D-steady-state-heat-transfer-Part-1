function  y = LinN1(u)
%calcule la fonction de forme N1 du contour telle que: 
%     N1(-1)=1 et N1(1)=0
%               N1
%       |---------------|
%       -1              1
% N1(x)=a*x+b et ab=[a;b]
ab=[-1 1;1 1]\[1;0];
    y = ab(1).*u + ab(2);
end