//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 23/09/21, 18:20:05
  // ----------------------------------------------------
  // Méthode : QuizzMAJPhotosOriginales
  // Description
  // Met l'orientation dans la [DiaData]
  //  de la photo originale
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)

SELECTION TO ARRAY:C260([DiaData:45]XEntier:2;$TbNumPhoto\
;[DiaData:45]XAlpha:14;$TbOriginePhoto)
$FT:=Records in selection:C76([DiaData:45])
ARRAY REAL:C219($TbOrientation;$FT)
For ($Salé;1;$FT)
	$Source:=<>PermCheDossierAsaDiaWeb+"Q"+$TbOriginePhoto{$Salé}+String:C10($TbNumPhoto{$Salé};"00000")+".jpg"
	If (Test path name:C476($Source)=Est un document:K24:1)
		READ PICTURE FILE:C678($Source;$VarImage)
		PICTURE PROPERTIES:C457($VarImage;$Largeur;$Hauteur)
		$TbOrientation{$Salé}:=Num:C11($Largeur>$Hauteur)
	End if 
End for 
ARRAY TO SELECTION:C261($TbOrientation;[DiaData:45]XValeur:4)