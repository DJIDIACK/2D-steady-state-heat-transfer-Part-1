function y = PRequise(FTable,NTable,NbNodes,h)

[NTableX,IX] = sort(NTable(:,2));
[NTableY,IY] = sort(NTable(:,3));

 FTableX = zeros(NbNodes,1);
for k1=1:NbNodes
    FTableX(k1) = FTable(IY(k1),1);
end

 FTableY = zeros(NbNodes,1);
for k2=1:NbNodes
    FTableY(k2) = FTable(IX(k2),2);
end
 
Ax=0; Ay=0;
for i=1:NbNodes-1
    Ax = Ax + (FTableX(i+1)-FTableX(i))*(NTableY(i+1)+ NTableY(i))*h;
    Ay = Ay + (FTableY(i+1)-FTableY(i))*(NTableX(i+1)+ NTableX(i))*h;
end

A=sqrt(Ax^2+Ay^2);
TableAir = [Ax, Ay, A];

NumNames = {'X','Y-Flux','Y','X-Flux'};
TNum = table(NTableX,FTableY,NTableY,FTableX,'VariableNames',NumNames);
writetable(TNum,'Table.csv')

varNames = {'Ax','Ay','A'};
T = table(Ax, Ay, A,'VariableNames',varNames);
writetable(T,'TableAir.csv')

figure(1); 
hold on
plot( NTableY,FTableX,'r-*');
hold off
grid on

figure(2); 
hold on
plot( NTableX,FTableY,'r-*');
hold off
grid on

y = A;

end