function  y = LinN2(u)
%calcule la fonction de forme N2 du contour telle que: 
%     N2(-1)=0 et N2(1)=1
%               N2
%       |---------------|
%       -1              1
% N2(x)=a*x+b et ab=[a;b]
ab=[-1 1;1 1]\[0;1];
    y = ab(1).*u + ab(2);
end