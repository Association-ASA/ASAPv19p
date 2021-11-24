//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 11/08/16, 05:33:18
// ----------------------------------------------------
// Méthode : WebChercheMotif
// Description
//  AJAX qui pemet d'afficher la liste des motifs
// répondant au critère entré
// Paramètre
// $1 = message de type "motifcherche"
// +les lettres entrées dans le champ de recherche
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT)
C_OBJECT:C1216($Objet)
$Message:=$1
$Objet:=JSON Parse:C1218(Substring:C12($Message; 13))
$Critère:="@"+OB Get:C1224($Objet; "nom"; Est un texte:K8:3)+"@"
// $Critère:="@"+Sous chaîne($Message;13)+"@"
If (Length:C16($Message)>12)  // quelque chose dans le champ de recherche -> filtrage
	CREATE SET:C116([DiaMotifSaisieDGAL:42]; "Lesions")
	QUERY:C277([DiaMotifSaisieDGAL:42]; [DiaMotifSaisieDGAL:42]RefRegEuropeenne:5=$Critère; *)
	QUERY:C277([DiaMotifSaisieDGAL:42];  | [DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1=$Critère; *)
	QUERY:C277([DiaMotifSaisieDGAL:42];  | [DiaMotifSaisieDGAL:42]InformationEleveurs:11=$Critère; *)
	// test sur les lésions
	QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=$Critère; *)
	QUERY:C277([DiaLesions:44];  | [DiaLesions:44]DescriptionTypeMacro:4=$Critère; *)
	QUERY:C277([DiaLesions:44];  | [DiaLesions:44]FicheReflexe:12=$Critère)
	SELECTION TO ARRAY:C260([DiaLesions:44]NomLesion:1; $TbNomLesion)
	$FT:=Size of array:C274($TbNomLesion)
	For ($Salé; 1; $FT)
		QUERY:C277([DiaMotifSaisieDGAL:42];  | [DiaMotifSaisieDGAL:42]LesionsLiees:12=$TbNomLesion{$Salé}; *)
	End for 
End if 
If (OB Get:C1224($Objet; "typevisiteur"; Est un texte:K8:3)#"")
	QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1>80000)
	SELECTION TO ARRAY:C260([Diapositives:40]MotifSaisieDGAL:23; $TbMotifs)
	QUERY WITH ARRAY:C644([DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1; $TbMotifs)
End if 
QUERY:C277([DiaMotifSaisieDGAL:42];  & [DiaMotifSaisieDGAL:42]TypeListe:8="a")
$FTA:=String:C10(Records in selection:C76([DiaMotifSaisieDGAL:42]))
$THTML:=$FTA+"£"+DiaWebCreationHTMLListeMotifs
// FIXER TEXTE DANS CONTENEUR($THTML)
WEB SEND TEXT:C677($THTML)