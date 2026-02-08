function r = readGiDNodes(fullFileName)

% Ouvrir le fichier.
fileID = fopen(fullFileName, 'rt');
% Lire la première ligne du fichier.
textLine = fgetl(fileID);
    while ischar(textLine)
      fprintf('Processing line: "%s"...\n', textLine);    
            if contains(textLine, 'NOEUD') 
                ScanNbNodes = sscanf(textLine, '%s %u');  
                NbNodes = ScanNbNodes(end);
                if NbNodes==0
                    disp("Il n'y a aucun noeud de défini dans le fichier de données");
                    r=0;
                    return;
                end
                % Lire la ligne suivante qui contient les chiffres dont nous avons besoin.
                textLine = fgetl(fileID);
                NodeTable = zeros(NbNodes,11);
                    for i=1:NbNodes
                        numbers = sscanf(textLine, '%u %f %f');
                        % Extraire nos éléments du tableau
                        NodeTable(i,1) = numbers(1);
                        NodeTable(i,2)  = numbers(2);
                        NodeTable(i,3)  = numbers(3);
                        textLine = fgetl(fileID);
                    end
                    % Nous en avons fini avec ce fichier.
                    break;
            end
            %Lire les lignes restantes du fichier.
            textLine = fgetl(fileID);
    end
sprintf(" Nombre de noeuds traités: %u",NbNodes)
% La lecture de toutes les lignes est terminée, alors fermeons le fichier.
 fclose(fileID);

%Assignation des conditions limites essentielles dans la table des noeuds
CLETable = readGiDCLEs(fullFileName);
NbCLE = size(CLETable,1);
    for i=1: NbCLE 
        NumNode = CLETable(i,2);
        id = CLETable(i,1);
        for j=1:NbNodes
            if NodeTable(j,1)==NumNode
                NodeTable(j,4)=id;
            end
        end

    end 
    
  %Récupération du nombre de DDLs total
NbDDLs = size(NodeTable,1);

%Initialisation du nombre de DDLs libres
NbDDLsF = 0;

%Initialisation du nombre de DDLs imposés
NbDDLsP = 0;

%Boucle sur les noeuds et assignation des numéros -
for i=1: NbDDLs 
    if NodeTable(i,4) ~= 0
        NbDDLsP = NbDDLsP + 1;
        NodeTable(i,5) = -NbDDLsP;
    end 
end 

%Vérification que les CLEs ont bien été asignées
if NbDDLsP == 0
disp('Erreur: Les CLEs n''ont pas été assignées\n')
end 

%Boucle sur les noeuds et assignation des numéros +
for i=1: NbDDLs 
    if NodeTable(i,4) == 0 
        NbDDLsF = NbDDLsF + 1;
        NodeTable(i,5) = NbDDLsF;
    end 
end 
  r = NodeTable;
end

