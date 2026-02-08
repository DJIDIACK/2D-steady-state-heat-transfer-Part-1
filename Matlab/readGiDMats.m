function r = readGiDMats(fullFileName)
% Ouvrir le fichier.
fileID = fopen(fullFileName, 'rt');
% Lire la première ligne du fichier.
textLine = fgetl(fileID);
    while ischar(textLine)
      %fprintf('Processing line: "%s"...\n', textLine);
      if contains(textLine, 'MATERIAU')
        ScanMats = sscanf(textLine, '%s %u');  
        NbMats = ScanMats(end);
        if NbMats==0
            disp("Il n'y a aucun matériau de défini dans le fichier de données");
            r=0;
            return;
        end        
        % Lire la ligne suivante qui contient les chiffres dont nous avons besoin.
        textLine = fgetl(fileID);
        MatTable = sym(zeros(NbMats,2));
        for i=1:NbMats
            numbers = sscanf(textLine, '%u %f');
            % Extraire nos éléments du tableau
            MatTable(i,1) = numbers(1);
            MatTable(i,2) = numbers(2);
             % Read the remaining lines of the file.
            textLine = fgetl(fileID);
        end
        % Nous en avons fini avec ce fichier.
        break;
      end
      %Lire les lignes restantes du fichier.
        textLine = fgetl(fileID);
    end
sprintf(" Nombre de matériaux traités: %u",NbMats)
% La lecture de toutes les lignes est terminée, alors fermeons le fichier.
fclose(fileID);
r = MatTable;
end
