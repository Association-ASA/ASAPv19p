//%attributes = {"publishedWeb":true}
  // ZMAJInitPopUp 6.0 du 12/8/98
  //Appelée par ZDémarre

ARRAY TEXT:C222(PUMHOrganes;0)
LIST TO ARRAY:C288("OrganesH";PUMHOrganes)

ARRAY TEXT:C222(PUMEcole;5)
PUMEcole{1}:="ENVA"
PUMEcole{2}:="ENVL"
PUMEcole{3}:="ENVN"
PUMEcole{4}:="ENVT"
PUMEcole{5}:="INFOMA"

ARRAY TEXT:C222(PUMAction;3)  // tableau des orientations des diapos
PUMAction{1}:="Orientation"
PUMAction{2}:="Diagnose"
PUMAction{3}:="Lésion"

ARRAY TEXT:C222(PUMOrientation;6)  // tableau des orientations des diapos
PUMOrientation{1}:="Tête"
PUMOrientation{2}:="Queue"
PUMOrientation{3}:="Gauche"
PUMOrientation{4}:="Droite"
PUMOrientation{5}:="Haut"
PUMOrientation{6}:="Bas"

ALL RECORDS:C47([DiaLesions:44])
SELECTION TO ARRAY:C260([DiaLesions:44]NomLesion:1;TbNomLésions)
SORT ARRAY:C229(TbNomLésions;>)
  // Méthode dans laquelle sont définies les tableaux ,
  // les menus locaux et les listes déroulantes utilisées dans la base
LIST TO ARRAY:C288("Espèce";PUMEspèce)
LIST TO ARRAY:C288("Organe";PUMOrgane)
LIST TO ARRAY:C288("TypeProduction";PUMTP)
LIST TO ARRAY:C288("JustificationConduite";PUMJC)
LIST TO ARRAY:C288("Auteur";PUMAuteur)
LIST TO ARRAY:C288("Origine";PUMOrigine)
LIST TO ARRAY:C288("Fréquence";PUMFr)

  //  gestion des ensembles
ARRAY TEXT:C222(ZTbEnsNom;0)  //  tableau des noms des ensembles
ARRAY DATE:C224(ZTbEnsDate;0)
ARRAY TEXT:C222(ZTbEnsQVL;0)  //  tableau des noms des auteurs
ARRAY REAL:C219(ZTbEnsNbre;0)
ARRAY LONGINT:C221(ZTbEnsNumEnr;0)


  //  gestion des pop-up de ListeNB
  // Initialisation des Pop Up menus
  //utilisés dans les petits formats
  // Odieusement piquée à JM Collu de Montauban
ARRAY TEXT:C222(ZSuppress;2)
ZSuppress{1}:="Supprimer toute la selection"
ZSuppress{2}:="Supprimer la fiche désignée"
ARRAY TEXT:C222(ZDestroy;2)  // permet des traitements sur les suppressions
ZDestroy{2}:="Supprimer toute la selection"
ZDestroy{1}:="Supprimer la fiche désignée"
ARRAY TEXT:C222(ZEnsemb;5)
ZEnsemb{1}:="Appeler ensemble"
ZEnsemb{2}:="Enregistrer ensemble"
ZEnsemb{3}:="Supprimer ensemble "
ZEnsemb{4}:="Calcul sur ensemble"
ZEnsemb{5}:="Reprendre sélection"
ARRAY TEXT:C222(ZSelection;5)
ZSelection{1}:="Ajouter à Sélection"
ZSelection{2}:="Enlever à Sélection"
ZSelection{3}:="Trier la sélection"
ZSelection{4}:="Virer les noires"
ZSelection{5}:="Reprendre Sélection"
ARRAY TEXT:C222(ZRechercheR;4)
ZRechercheR{1}:="Recherches standard"
ZRechercheR{3}:="Tout voir"
ZRechercheR{2}:="Sélection sur liste"
ZRechercheR{4}:="Reprendre sélection"
ARRAY TEXT:C222(ZImpression;3)
ZImpression{1}:="Imprimer la selection"
ZImpression{2}:="Etats sur la sélection"
ZImpression{3}:="Graphes"
ARRAY TEXT:C222(ZRechListe;4)
ZRechListe{1}:="Recherches standard"
ZRechListe{3}:="Tout voir"
ZRechListe{2}:="Recherche par l'exemple"
ZRechListe{4}:="Reprendre sélection"
ARRAY TEXT:C222(ZSelListe;4)
ZSelListe{1}:="Ajouter à Sélection"
ZSelListe{2}:="Enlever à Sélection"
ZSelListe{3}:="Trier la sélection"
ZSelListe{4}:="Reprendre Sélection"
ARRAY TEXT:C222(ZPopV4;7)
ZPopV4{5}:="Ajouter à Sélection"
ZPopV4{6}:="Enlever à Sélection"
ZPopV4{4}:="Trier la sélection"
ZPopV4{7}:="Reprendre Sélection"
ZPopV4{3}:="Recherches standard"
ZPopV4{2}:="Calcul sur ensemble"
ZPopV4{1}:="Appeler un ensemble"
ZPopV4:=1
