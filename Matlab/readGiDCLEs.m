function r = readGiDCLEs(fullFileName)

% Ouvrir le fichier.
fileID = fopen(fullFileName, 'rt');
% Lire la première ligne du fichier.
textLine = fgetl(fileID);
    while ischar(textLine)
      fprintf('Processing line: "%s"...\n', textLine);
      if contains(textLine, 'CLE')
        ScanNbCLEs = sscanf(textLine, '%s %u');  
        NbCLEs = ScanNbCLEs(end);
        if NbCLEs==0
            disp("Aucune CLEs de défini dans le fichier");
            r=0;
            return;
        end
        % Lire la ligne suivante qui contient les chiffres dont nous avons besoin.
        textLine = fgetl(fileID);
        CLETable = zeros(NbCLEs,2);
        for i=1:NbCLEs
            numbers = sscanf(textLine, '%s %u %f');
            % Extraire nos éléments du tableau
            CLETable(i,1) = i;
            CLETable(i,2) = numbers(end-1);
            CLETable(i,3) = numbers(end);
            textLine = fgetl(fileID);
        end
        % Nous en avons fini avec ce fichier.
        break;
      end
      %Lire les lignes restantes du fichier.
        textLine = fgetl(fileID);
    end
sprintf("Nombre de termes CLEs traités: %u (%u éléments)",NbCLEs,NbCLEs)
% La lecture de toutes les lignes est terminée, alors fermeons le fichier.
fclose(fileID);
r = CLETable;
end