function [r1,r2,r3] = DDLsNodeTable(fullFileName)
sprintf('Numérotation des DDLs en cours...\')

%Appel de la fonction Table
NodeTable = readGiDNodes(fullFileName);

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

sprintf(" Nombre de DDLs libres: %d ",NbDDLsF)
sprintf(" Nombre de DDLs imposées: %d " ,NbDDLsP)
sprintf(" Nombre de DDLs total: %d ",NbDDLs)

r1 = NbDDLs;
r2 = NbDDLsF;
r3 = NbDDLsP;
end
