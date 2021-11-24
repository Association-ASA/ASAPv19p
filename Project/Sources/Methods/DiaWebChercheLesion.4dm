//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 18/07/16, 08:21:48
// ----------------------------------------------------
// Méthode : WebChercheLesion
// Description
//  AJAX qui pemet d'afficher la liste des lésions
// répondant au critère entré
// Paramètre
// $1 = message de type "cherche"
//        + initiale de la langue
//        +  les lettres entrées dans le champ de recherche
// ----------------------------------------------------
$Message:=$1
$Langue:=$Message[[8]]
ALL RECORDS:C47([DiaLesions:44])
If (Length:C16($Message)>8)  // quelque chose dans le champ de recherche sinon tout afficher
	$Critère:="@"+Substring:C12($Message; 9)+"@"
	If ($Langue="F")
		QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=$Critère; *)
		QUERY:C277([DiaLesions:44];  | [DiaLesions:44]DescriptionTypeMacro:4=$Critère; *)
		QUERY:C277([DiaLesions:44];  | [DiaLesions:44]FicheReflexe:12=$Critère)
	Else 
		ARRAY LONGINT:C221(TbNumLesN; 0)  // initialisation du tableau des n° d'enregistrement à collecter
		$PtTb:=Get pointer:C304("<>TbNL"+$Langue)
		DiaWebSearchInLesion($PtTb; $Critère)
		$PtTb:=Get pointer:C304("<>TbDM"+$Langue)
		DiaWebSearchInLesion($PtTb; $Critère)
		$PtTb:=Get pointer:C304("<>TbFR"+$Langue)
		DiaWebSearchInLesion($PtTb; $Critère)
		CREATE SELECTION FROM ARRAY:C640([DiaLesions:44]; TbNumLesN)
	End if 
End if 

$THTML:=DiaWebCreationHTMLListeLesions($Langue; True:C214)  // Création de la liste restreinte
If (False:C215)
	$SurUnTotal:=DiaWebTraduitTexte("lésions sur un total"; $Langue)
	$SurUnTotal:=Replace string:C233($SurUnTotal; "<p>"; String:C10(Records in selection:C76([DiaLesions:44])))
	$SurUnTotal:=Replace string:C233($SurUnTotal; "<n>"; String:C10(Records in table:C83([DiaLesions:44])))
Else 
	$SurUnTotal:=String:C10(Records in selection:C76([DiaLesions:44]))
End if 
$Instruction:=DiaWebTraduitTexte("Cliquer sur l'icône du détail lésion"; $Langue)

$THTML:=$SurUnTotal+"£"+$Instruction+"£"+$THTML
// FIXER TEXTE DANS CONTENEUR($THTML)
WEB SEND TEXT:C677($THTML)