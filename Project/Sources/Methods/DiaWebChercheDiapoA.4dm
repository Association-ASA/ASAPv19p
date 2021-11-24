//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 24/07/16, 16:14:03
  // ----------------------------------------------------
  // Méthode : WebChercheDiapoA
  // Description
  //  Nom de la lésion  organe, espèce and description of the photo
  //
  // Paramètres
  // ----------------------------------------------------

$Message:=$1  // type find + chaine
QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1<80000)
SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1;<>TbNumGenDia;[Diapositives:40]NomLesion:4;<>TbNomLesionDia;[Diapositives:40]Espece:3;<>TbEspeceDia;[Diapositives:40]Organe:2;<>TbOrganeDia)
LONGINT ARRAY FROM SELECTION:C647([Diapositives:40];<>TbNumEnrDia)
If (Length:C16($Message)=4)  // rien dans le champ de recherche -> tout afficher
	ALL RECORDS:C47([Diapositives:40])
Else 
	  //Ad3TraducFabriqueTb
	$Critère:="@"+Substring:C12($1;5)+"@"
	ARRAY LONGINT:C221(TbNumDiaN;0)
	QUERY:C277([Diapositives:40];[Diapositives:40]CommentaireA:28=$Critère)  //description of the photo
	LONGINT ARRAY FROM SELECTION:C647([Diapositives:40];TbNumDiaN)
	DiaWebSearchInDiapo (-><>TbNomLesionDia;$Critère)  // Nom de la lésion
	DiaWebSearchInDiapo (-><>TbEspeceDia;$Critère)  // espèce
	DiaWebSearchInDiapo (-><>TbOrganeDia;$Critère)  //organe
	CREATE SELECTION FROM ARRAY:C640([Diapositives:40];TbNumDiaN)
End if 
LangueEnCours:="A"
$THTML:=DiaWebCreationHTMLListeDiapos ("A";True:C214)
WEB SEND TEXT:C677($THTML)