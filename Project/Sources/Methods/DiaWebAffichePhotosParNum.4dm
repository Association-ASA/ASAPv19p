//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 03/12/18, 14:22:22
  // ----------------------------------------------------
  // Méthode : WebAffichePhotosParNum
  // Description
  // Revoie un message AJAX qui affiche la liste des images en liste
  // correspondant àux n° de diapos entrés
  // Paramètre  $1 = message AJAX entrant
  // ----------------------------------------------------

C_LONGINT:C283(FT;$Salé;$FT)
$Mess:=$1
$Langue:="F"
$NumPhotos:=Substring:C12($Mess;20)  // on enlève l'appel affichephotosparnum
ARRAY TEXT:C222($TbNumDiaR;0)
ZTexteVersTableau ($NumPhotos;->$TbNumDiaR;" ")
$FT:=Size of array:C274($TbNumDiaR)
ARRAY LONGINT:C221(TbNumDiaR;0)
For ($Salé;1;$FT)
	If (Find in array:C230(<>TbDiaposNumOrdreDiapos;Num:C11($TbNumDiaR{$Salé}))>0)
		If (Num:C11($TbNumDiaR{$Salé})#0)
			APPEND TO ARRAY:C911(TbNumDiaR;Num:C11($TbNumDiaR{$Salé}))
		End if 
	End if 
End for 
$FT:=Size of array:C274(TbNumDiaR)

Case of 
	: ($FT=0)
		$Critere:="Désolé, aucun numéro de photo valide n'a été saisi...."
		
	: ($FT=1)
		$Critere:="<br />Affichage de la photo n°"+String:C10(TbNumDiaR{1})+".<br /><br />"
		
	Else 
		$Critere:="<br />Affichage des "+String:C10($FT)+" photos par les n° valides suivants : "+ZTableauVersTexte (->TbNumDiaR;", ")+".<br /><br />"
End case 
VarPlusieursNomsMotifs:=False:C215
$Rep:=$Critere+"£"+DiaWebFabriqueListePhotos ($Langue)

WEB SEND TEXT:C677($Rep)
  // FIXER TEXTE DANS CONTENEUR($Rep)