//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 23/07/16, 16:49:11
  // ----------------------------------------------------
  // Méthode : WebChercheLesionA
  // Description
  // Version anglaise de la recherche
  //  va chercher dans les tableaux et non pas dans les champs
  // Paramètres
  // ----------------------------------------------------

$Message:=$1
ALL RECORDS:C47([DiaLesions:44])
SELECTION TO ARRAY:C260([DiaLesions:44]NumLesion:18;<>TbNumLesGen;[DiaLesions:44]NomLesion:1;$TbNomLesion)
LONGINT ARRAY FROM SELECTION:C647([DiaLesions:44];<>TbNumEnrLes)
If (Length:C16($Message)=7)  // rien dans le champ de recherche -> tout afficher
	ALL RECORDS:C47([DiaLesions:44])
Else 
	  // Ad3TraducFabriqueTb
	$Critère:="@"+Substring:C12($1;8)+"@"
	ARRAY LONGINT:C221(TbNumLesN;0)
	DiaWebSearchInLesion (-><>TbNLE;$Critère)
	DiaWebSearchInLesion (-><>TbDME;$Critère)
	DiaWebSearchInLesion (-><>TbFRE;$Critère)
	CREATE SELECTION FROM ARRAY:C640([DiaLesions:44];TbNumLesN)
	  //CHERCHER([Lesions];[Lesions]NomLesion=$Critère;*)
	  //CHERCHER([Lesions]; | [Lesions]DescriptionTypeMacro=$Critère;*)
	  //CHERCHER([Lesions]; | [Lesions]FicheReflexe=$Critère)
End if 
$THTML:=DiaWebCreationHTMLListeLesions ("A";True:C214)
WEB SEND TEXT:C677($THTML)