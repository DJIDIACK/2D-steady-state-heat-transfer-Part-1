clear all;
close all;
clc;

%Lecture de l'épaisseur
% Type file to command window.
fullFileName = 'pFile.dat';
type(fullFileName)  % OPTIONAL!

% Ouvrir le fichier.
fileID = fopen(fullFileName, 'rt');
% Lire la première ligne du fichier.
textLine = fgetl(fileID);
    while ischar(textLine)
            if contains(textLine, 'EPAISSEUR')
                ScanEpaisseur = sscanf(textLine, '%s %f');  
                ValEpaisseur = ScanEpaisseur(end);
            end 
            %Lire les lignes restantes du fichier.
            textLine = fgetl(fileID);
    end
sprintf(" L'épaisseur trouvé est de : %u",ValEpaisseur)
% La lecture de toutes les lignes est terminée, alors fermeons le fichier.
fclose(fileID); 


    %Lecture des conditions aux limites naturelles
    CLNTable = readGiDCLNs(fullFileName);

    %Lecture de la table des matériaux
    MatsTable = readGiDMats(fullFileName);

    %Requête du nombre de DDLs total
    [NbDDLs,DDLsL,~] = DDLsNodeTable(fullFileName);


    %Extraction de la table des CLEs
    CLETable = readGiDCLEs(fullFileName);

    %Extraction de la table des noeuds
    NodeTable = readGiDNodes(fullFileName);
    NbNodes = size(NodeTable,1);
    
    %Extraction de la table des éléments
    ElemTable = readGiDElems(fullFileName);
    NbElems = size(ElemTable,1);
    
    %Extraction de la fonction de calcul du nombre
    % d'éléments triangulaires et de contour
    [NbTri,NbCont] = CalculNbElems(fullFileName);

    %Requête de l'épaisseur
    h = ValEpaisseur;
   
    %Requête du mailage
    [X, Y, P] = Maillage(fullFileName);


[U] = CalculSolution(X,Y,P,h,NbTri,NbCont,DDLsL,fullFileName);


%Extraction de la solution
    for i=1:NbDDLs
        %Récupération du no d'équation
        EqnNb = NodeTable(i,5);
        if EqnNb > 0 
        NodeTable(i,6) = U(EqnNb);
        else
        NodeTable(i,6) = CLETable(NodeTable(i,4),3);
        end 
    end
   
%Requête de la tabe des gradients
GradTable = Gradient(X,Y,P,NodeTable(:,6),fullFileName);

%Requête de la table des flux
FluxTable = Flux(X,Y,P,NodeTable(:,6),fullFileName);

%PRequise(FluxTable,NodeTable,NbNodes,h)

 
addpath(genpath('.'))

FileName = 'TP4-Exemple';
NumNode = NodeTable(:,1);
Temperature = NodeTable(:,6);
Gradient = GradTable;
Flux = FluxTable;
lFile = GiDOpen(FileName);
GiDPrintScalar(lFile,'Temperature','Thermique 2D stationnaire',1.0,NumNode,Temperature);
GiDPrintVector(lFile,'Gradient','Thermique 2D stationnaire',1.0,NumNode,Gradient);
GiDPrintVector(lFile,'Flux','Thermique 2D stationnaire',1.0,NumNode,Flux);
GiDClose(lFile);

