function r = readGiDCLNs(fullFileName)

% Ouvrir le fichier.
fileID = fopen(fullFileName, 'rt');
% Lire la première ligne du fichier.
textLine = fgetl(fileID);
    while ischar(textLine)
      %fprintf('Processing line: "%s"...\n', textLine);
      if contains(textLine, 'CONVECTION')
        ScanNbCLNs = sscanf(textLine, '%s %u');  
        NbCLNs = ScanNbCLNs(end);
        if NbCLNs==0
            disp("Aucune CLNs de défini dans le fichier");
            r=0;
            return;
        end
        % Lire la ligne suivante qui contient les chiffres dont nous avons besoin.
        textLine = fgetl(fileID);
        CLNTable = zeros(NbCLNs,3);
        for i=1:NbCLNs
            numbers = sscanf(textLine, '%s %u %f %f');
             % Extraire nos éléments du tableau
            CLNTable(i,1) = numbers(end-2);
            CLNTable(i,2) = numbers(end-1);
            CLNTable(i,3) = numbers(end);
            textLine = fgetl(fileID);
        end
        % Nous en avons fini avec ce fichier.
        break;
      end
      %Lire les lignes restantes du fichier.
        textLine = fgetl(fileID);
    end
sprintf(" Nombre de CLNs traitées: %u (%u éléments)",NbCLNs,NbCLNs)
% La lecture de toutes les lignes est terminée, alors fermeons le fichier.
fclose(fileID);
r = CLNTable;
end
