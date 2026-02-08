function r = TriX_uv(u,v,X,P,i)
%calcule de x en fonction de u telle que :
%   
%   x = <N1 N2 N3>{X(1) X(2) X(3)}
%
%   x = N1*X(1)+N2*X(2)+N3*X(3);              
%         
r = TriN1(u,v)*X(P(i,1))+ TriN2(u)*X(P(i,2)) + TriN3(v)*X(P(i,3));
end