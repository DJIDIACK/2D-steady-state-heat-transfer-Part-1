function r = readGiDElems(fullFileName)

%Requête des éléments triangulaires et de contour
[NbTri,NbCont] = CalculNbElems(fullFileName);

% Ouvrir le fichier.
fileID = fopen(fullFileName, 'rt');
% Lire la première ligne du fichier.
textLine = fgetl(fileID);
    while ischar(textLine)
      %fprintf('Processing line: "%s"...\n', textLine);
      if contains(textLine, 'ELEMENT')
            ScanElements = sscanf(textLine, '%s %u');  
            NbElements = ScanElements(end);
            if NbElements==0
                disp("Il n'y a aucun élément de défini dans le fichier de données");
                r=0;
                return;
            end
            % Lire la ligne suivante qui contient les chiffres dont nous avons besoin.
            textLine = fgetl(fileID);
            ElemTable = zeros(NbElements,13);
            for i=1:NbTri
                numbers = sscanf(textLine, '%u %u %u %u %u %u');
                % Extract triangulaire element.
                ElemTable(i,1) = numbers(1);
                ElemTable(i,2) = numbers(2);
                ElemTable(i,3) = numbers(3);
                ElemTable(i,4) = numbers(4);
                ElemTable(i,5) = numbers(5);
                ElemTable(i,6) = numbers(6);
                 % Read the remaining lines of the file.
                textLine = fgetl(fileID);
            end
            for i=NbTri+1:NbTri+NbCont
                numbers = sscanf(textLine, '%u %u %u %u %u');
                % Extract contour element.
                ElemTable(i,1) = numbers(1);
                ElemTable(i,2) = numbers(2);
                ElemTable(i,3) = numbers(3);
                ElemTable(i,4) = numbers(4);
                ElemTable(i,5) = numbers(5);
                 % Read the remaining lines of the file.
                textLine = fgetl(fileID);
            end
            % Nous en avons fini avec ce fichier.
        break;
      end
      %Lire les lignes restantes du fichier.
        textLine = fgetl(fileID);
    end
sprintf(" Nombre d'éléments traités: %u",NbElements)
% La lecture de toutes les lignes est terminée, alors fermeons le fichier.
fclose(fileID);

 
CLNTable = readGiDCLNs(fullFileName);
%Assignation des conditions limites naturelles dans la table des éléments
    for i=1: size(CLNTable,1) 
            NumCLN = CLNTable(i,1);
        if ElemTable(NbTri+i,1) == NumCLN
            ElemTable(NbTri+i,7) = 1;
        end 
    end
 
SrcTable = readGiDSrcs(fullFileName);
%Assignation de la charge dans la table des éléments
    if size(SrcTable,1)~=1
        for i=1: size(SrcTable,1)
             ElemTable(i,8) = 1;   
        end
    end
        

%Assignation des numéros d'équations dans la table des éléments
Loc=[];
NodeTable = readGiDNodes(fullFileName);
NbNodes = size(NodeTable,1);
    for k = 1:NbElements
            for i = 1:NbNodes
                    if ElemTable(k,4)==NodeTable(i,1)
                        NoEq1=NodeTable(i,5);
                    end
                    if ElemTable(k,5)==NodeTable(i,1)
                        NoEq2=NodeTable(i,5);
                    end
                    if ElemTable(k,6)==NodeTable(i,1)
                        NoEq3=NodeTable(i,5);
                    elseif ElemTable(k,6)==0
                        NoEq3=0;
                    end
            end
            Loc = [Loc; [NoEq1, NoEq2, NoEq3]] ;
    end

    for k = 1:NbElements
           ElemTable(k,9) = Loc(k,1);
           ElemTable(k,10) = Loc(k,2); 
           ElemTable(k,11) = Loc(k,3); 
    end
r = ElemTable;
end