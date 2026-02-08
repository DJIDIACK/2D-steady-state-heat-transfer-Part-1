A = [760, 826, 840, 852, 882, 926, 1018];
B = [1.4863e+03, 1.6738e+03, 9.1040e+03, 9.1130e+03, 9.0179e+03, 9.0243e+03,9.2324e+03 ];
plot(A,B,'b-*','LineWidth',2)
grid on
%title('Diagrame de Convergence de la distribution du flux')
xlabel('Nombres éléments')
ylabel('Puissance Requise (W)')