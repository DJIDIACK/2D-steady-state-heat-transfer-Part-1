function xp = TriY_uv(u,v,Y,P,i)
%calcule de x en fonction de u telle que :
%   
%   x = <N1 N2 N3>{Y(1) Y(2) Y(3)}
%
%   x = N1*Y(1)+N2*Y(2)+N3*Y(3);              
%         
xp = TriN1(u,v)*Y(P(i,1))+ TriN2(u)*Y(P(i,2)) + TriN3(v)*Y(P(i,3));
end