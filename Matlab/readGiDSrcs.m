function r = readGiDSrcs(fullFileName)

% Ouvrir le fichier.
fileID = fopen(fullFileName, 'rt');
% Lire la première ligne du fichier.
textLine = fgetl(fileID);
    while ischar(textLine)
      %fprintf('Processing line: "%s"...\n', textLine);
      if contains(textLine, 'SOURCE/PUIT')
        ScanNbSrcs = sscanf(textLine, '%s %u');  
        NbSrcs = ScanNbSrcs(end);
        if NbSrcs==0
           r=0;
           return;
        end
        % Lire la ligne suivante qui contient les chiffres dont nous avons besoin.
        textLine = fgetl(fileID);
         SrcTable = zeros(NbSrcs,2);
        %En cas si tu veux intégrer les termes de Q mais le code sera lent.
        %SrcTable = sym(zeros(NbSrcs,2));
        for i=1:NbSrcs
            numbers = sscanf(textLine, '%*s %u %*s');
            charQ = 1;
            %En cas si tu veux intégrer les termes de Q mais le code sera lent.
            %charQ = str2sym(char(sscanf(textLine, '%*s %*u %s')).');
            % Extraire nos éléments du tableau
            SrcTable(i,1) = numbers;
            SrcTable(i,2) = charQ;
            textLine = fgetl(fileID);
        end
        % Nous en avons fini avec ce fichier.
        break;
      end
      %Lire les lignes restantes du fichier.
        textLine = fgetl(fileID);
    end
sprintf(" Nombre de Sources traitées: %d (%d noeuds)",NbSrcs,NbSrcs)
% La lecture de toutes les lignes est terminée, alors fermeons le fichier.
fclose(fileID);
r = SrcTable;
end