//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 03/04/18, 08:01:45
  // ----------------------------------------------------
  // Méthode : AntichambreClicLBCandidats
  // Description
  // Actualise les données des candidats en fonction
  //  de la sélection dans la LB ListBoxCDFichiers
  //  ou par l'acceptation d'une photo
  // ----------------------------------------------------

C_TEXT:C284($VarValeur)
$Pos:=Position:C15(":Dropbox:";TbCheminFichier{LigneClic})
CDCourant:=<>PermCheDropBox+Substring:C12(TbCheminFichier{LigneClic};($Pos+Length:C16(":Dropbox:")))
If (Test path name:C476(CDCourant)#Est un document:K24:1)
	CDCourant:=TbCheminFichier{LigneClic}
End if 
READ PICTURE FILE:C678(CDCourant;VarImage)
PICTURE PROPERTIES:C457(VarImage;$Largeur;$Hauteur)
$DefStandard:=1871*2835
$DefImage:=$Largeur*$Hauteur
$Rapport:=Round:C94($Largeur/$Hauteur;2)
If ($Rapport<1)
	$Rapport:=Round:C94($Hauteur/$Largeur;2)
End if 
$RapIdeal:=Round:C94(2835/1871;2)
PbTechnique:=(Abs:C99($RapIdeal-$Rapport)>0.1) | ($Largeur*$Hauteur<$DefStandard)
$Couleur:=Num:C11((PbTechnique))*0x00FF0000
$PoidsImage:=Picture size:C356(VarImage)/1000000
$Pict:=DiaImageObsolete (VarImage)
$Compatible:=Num:C11($Pict)*"non "
VarComImage:="Définition : "+String:C10($Largeur)+" x "+String:C10($Hauteur)+<>ZCR
VarComImage:=VarComImage+"Définition minimale : 2835 x 1871"+<>ZCR
VarComImage:=VarComImage+"Poids : "+String:C10($PoidsImage)+" Mo"+<>ZCR
VarComImage:=VarComImage+"Rapport : "+String:C10($Rapport)+" (idéal "+String:C10($RapIdeal)+")"+<>ZCR
VarComImage:=VarComImage+"Compatibilité du CODEC : "+$Compatible+"compatible"
VarCDCompletPhoto:=TbCheminFichier{LigneClic}
OBJECT SET RGB COLORS:C628(VarComImage;$Couleur;0x00FFFFFF)
If (Macintosh command down:C546)
	OBJECT SET VISIBLE:C603(*;"BoutonStockeImage";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"BoutonStockeImage";($DefImage>4000000))
	$Type:="AjoutDia"+(Num:C11(VarPOD=1)*"POD")
	QUERY:C277([DiaData:45];[DiaData:45]XType:5=$Type;*)
	QUERY:C277([DiaData:45]; & [DiaData:45]XTexte:7=CDCourant)
	If (Records in selection:C76([DiaData:45])>0)
		VarDelaiAbattage:=OB Get:C1224([DiaData:45]XObjet:15;"Délai";Est un texte:K8:3)
		VarCommemoratif:=OB Get:C1224([DiaData:45]XObjet:15;"Commémoratifs";Est un texte:K8:3)
		VarCommentaires:=OB Get:C1224([DiaData:45]XObjet:15;"Commentaires";Est un texte:K8:3)
		$VarValeur:=OB Get:C1224([DiaData:45]XObjet:15;"Auteur";Est un texte:K8:3)
		PUMAuteurAC:=Find in array:C230(PUMAuteurAC;$VarValeur)
		$VarValeur:=OB Get:C1224([DiaData:45]XObjet:15;"Espèce";Est un texte:K8:3)
		<>PUMEspèce:=Find in array:C230(<>PUMEspèce;$VarValeur)
		$VarValeur:=OB Get:C1224([DiaData:45]XObjet:15;"Organe";Est un texte:K8:3)
		<>PUMOrgane:=Find in array:C230(<>PUMOrgane;$VarValeur)
		VarNomLésion:=OB Get:C1224([DiaData:45]XObjet:15;"Lésion";Est un texte:K8:3)
	End if 
End if 

If (Macintosh command down:C546)
	OBJECT SET VISIBLE:C603(*;"BoutonStockeImage";True:C214)
	DiaACPhotosSemblables 
Else 
	OBJECT SET VISIBLE:C603(*;"BoutonStockeImage";($DefImage>4000000))
	DiaACPhotosSemblables (True:C214)
End if 