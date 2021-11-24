//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 06/04/18, 05:36:49
// ----------------------------------------------------
// Méthode : ZLBGèreListeOrda
// Description
//  Reprend le m^eme principe que ZGèreListeLB
//. mais met tous les paramètres  dans un objet
// Paramètre : $1 = Objet contenant les paramètres de la fonction
// Contenu de l'objet : 
//"Champ significatif" "Chemin logo" "Entrée" "Fiche" "Sortie" {"Gestion ensemble" "Méthode lapin" "Sur destruction"}    
// ----------------------------------------------------

#DECLARE($Objet : Object)

// Allons chercher les réglages des noms d'ET de l'utilisateur
//If ($Objet.gestionFixe=False)
//QUERY([XData]; [XData]XType="NomChampAfficheLB"; *)
//QUERY([XData];  & [XData]XNom="Nom des ET des ListBox pour "+<>ZQuiCode; *)
//QUERY([XData];  & [XData]XAlpha=<>ZQuiCode)
//ObTitreET:=OB Copy([XData]XObjet)
//End if 


// ZPtChamp:=OB Get($Objet; "Champ significatif")
// ZNumTable:=Table(ZPtChamp)
//ZPtTable:=Table(ZNumTable)
//ZNomChaDis:=Field name(ZPtChamp)
//ZNomTable:=Table name(ZPtTable)
//ZTypEns:=String(Table(ZPtTable))  // identifie par le numéro de fichier les ensembles crées
//VarCDLogo:=OB Get($Objet; "Chemin logo")

//ZNomListeXData:="LB "+ZNomTable+(Num(Not(<>ZToutNeuf))*<>ZQuiCode)
$Objet.ZNomListeXData:="LB "+$Objet.table+(Num:C11(Not:C34(<>ZToutNeuf))*<>ZQuiCode)

// Formulaire de saisie
If (OB Get:C1224($Objet; "Saisie"; Is text:K8:3)="")  // Teste l'existence de la propriété ET son contenu
	//If (OB Is defined($Objet; "Saisie")) // Teste l'existence de la propriété et non son contenu
	$Objet.Saisie:="Entrée"
End if 

// formulaire d'impression d'un enregistrement
If (OB Get:C1224($Objet; "Fiche"; Is text:K8:3)="")
	$Objet.Fiche:="Entrée"
End if 

// formulaire sortie
If (OB Get:C1224($Objet; "Sortie"; Is text:K8:3)="")
	$Objet.Sortie:="Liste"
End if 


//ZAvantProc:=OB Get($Objet; "Avant"; Is text)  // Méthode à effectuer sur chargement
//ZApresProc:=OB Get($Objet; "Après"; Is text)  // Méthode à effectuer sur validation
//ZBoumProc:=OB Get($Objet; "Sur destruction"; Is text)  // Méthode à effectuer avant destruction
//ZPtChampClefs:=OB Get($Objet; "Champ clefs"; Is pointer)  // Champ descriptif de l'enregistrement de [XUtilisateurs]

//// Gestion des méthodes lapin
//ARRAY TEXT(TbMethodeLapin; 0)
//$MethodeLapin:=OB Get($Objet; "Méthode lapin"; Is text)
//If ($MethodeLapin#"")
//$Pos:=Position(";"; $MethodeLapin)
//If ($pos>0)
//Repeat 
//APPEND TO ARRAY(TbMethodeLapin; Substring($MethodeLapin; 1; ($Pos-1)))
//$MethodeLapin:=Substring($MethodeLapin; ($Pos+1))
//$Pos:=Position(";"; $MethodeLapin)
//Until ($Pos=0)
//End if 
//APPEND TO ARRAY(TbMethodeLapin; $MethodeLapin)
//End if 

// gestion de la visibilité de la gestion des ensembles 
//ZGereEnsemble:=OB Get($Objet; "Gestion ensemble"; Is boolean)

// gestion des droits
$zptTable:=Table:C252(ds:C1482[$Objet.table].getInfo().tableNumber)
ZMAJPrivilèges($zptTable)

//If (ZModif)
//READ WRITE($zptTable->)
//Else 
//READ ONLY($zptTable->)
//End if 

//If ($Objet.es.length=0)  //autant ne pas afficher une liste vide
//$Objet.es:=ds[$Objet.table].all()
//End if 

//ZNomEnsembleAvant:="Ceusses avant table "+ZNomTable
//CREATE SET(ZPtTable->; ZNomEnsembleAvant)  //  crée l'ensemble des résultats de recherche

//ZAjoutEnr:=False  //  initialise le booléen d'ajout

//FORM SET INPUT(ZPtTable->; ZNomForEntrée)

$GestionTableau:=OB Get:C1224($Objet; "Gestion tableaux"; Is boolean:K8:9)
If ($Objet.gestionFixe)
	$Dialogue:=$Objet.Dialogue
Else 
	$Dialogue:="LBSelectionOrda"
End if 

//ZNomListe:=(Num($GestionTableau)*"LB_Tableaux")+(Num(Not($GestionTableau))*"LB_Selection")
// ZSensDuTri:=OB Get($Objet; "Sens du tri"; Is text)
//ZFenetreOuvertureStandard
//ZFenetreActualiseTitre

$win:=Open form window:C675($Dialogue; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
DIALOG:C40($Dialogue; $Objet)  // le format d'accueil doit être un formulaire projet

CLOSE WINDOW:C154
//ZAmnistiePartielle(ZPtTable)

//ZFini:=False

