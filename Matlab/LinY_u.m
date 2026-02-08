function x = LinY_u(u,Y,P,i)
%calcule de x en fonction de u telle que :
%   
%   x = <N1 N2>{X(1) X(2)}
%
%   x = N1*X(1)+N2*X(2);              
%         
x = LinN1(u)*Y(P(i,1))+ LinN2(u)*Y(P(i,2));
end