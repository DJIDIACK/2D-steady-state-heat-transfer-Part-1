function [r1,r2] = CalculNbElems(fullFileName)
%Tapez le fichier dans la fenêtre de commande.

% Ouvrir le fichier.
fileID = fopen(fullFileName, 'rt');
% Lire la première ligne du fichier.
textLine = fgetl(fileID);
    while ischar(textLine)
      %fprintf('Processing line: "%s"...\n', textLine);
      if contains(textLine, 'ELEMENT')
            ScanElements = sscanf(textLine, '%s %u');  
            NbElements = ScanElements(end);
            NbTri = 0;
            NbCont = 0;
            % Lire la ligne suivante qui contient les chiffres dont nous avons besoin.
            textLine = fgetl(fileID);
            ElemTable = zeros(NbElements,13);
            for i=1:NbElements
                numbers = sscanf(textLine, '%u %u %u %u %u %u');
                % Extraire nos éléments du tableau
                ElemTable(i,2) = numbers(2);
                if ElemTable(i,2)==0
                    NbCont = NbCont + 1;
                else
                    NbTri = NbTri +1;
                end
                 %Lire les lignes restantes du fichier.
                textLine = fgetl(fileID);
            end
            % Nous en avons fini avec ce fichier.
        break;
      end
      %Lire les lignes restantes du fichier.
        textLine = fgetl(fileID);
    end
% La lecture de toutes les lignes est terminée, alors fermeons le fichier.
fclose(fileID);
r1 = NbTri;
r2 = NbCont;
end