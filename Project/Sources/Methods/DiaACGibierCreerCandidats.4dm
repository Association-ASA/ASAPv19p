//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 22/04/20, 07:07:28
  // ----------------------------------------------------
  // Méthode : AntichambreGibierCreerCandidats
  // Description
  // Méthode qui crée les [XDonnees]
  //  correspondant aux photos du tableau
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT;$L;$L2)
QUERY:C277([DiaData:45];[DiaData:45]XType:5="AjoutDiaG")
$VarNumSérie:=Max:C3([DiaData:45]XValeur:4)+1
  // détermination des n° de série
$FT:=Size of array:C274(TbAuteur)
ARRAY LONGINT:C221($TbNumSérie;$FT)
For ($Salé;1;$FT)
	If (TbLien{$Salé}="")
		$TbNumSérie{$Salé}:=$VarNumSérie
		$VarNumSérie:=$VarNumSérie+1
	Else 
		$TbNumSérie{$Salé}:=-1
	End if 
End for 
$L:=Find in array:C230($TbNumSérie;-1)
While ($L>0)
	$L2:=Find in array:C230(TbRef;TbLien{$L})
	$TbNumSérie{$L}:=$TbNumSérie{$L2}
	$L:=Find in array:C230($TbNumSérie;-1;($L+1))
End while 

READ WRITE:C146([DiaData:45])
For ($Salé;1;$FT)
	QUERY:C277([DiaData:45];[DiaData:45]XType:5="AjoutDiaG";*)
	$NomFichierImage:=ZDocNomFichier (TbChemin{$Salé};0)
	QUERY:C277([DiaData:45]; & [DiaData:45]XNom:1=$NomFichierImage)
	If (Records in selection:C76([DiaData:45])=0)
		CREATE RECORD:C68([DiaData:45])
		[DiaData:45]XType:5:="AjoutDiaG"
	End if 
	OB SET:C1220([DiaData:45]XObjet:15;"Auteur";TbAuteur{$Salé}\
		;"Espèce";TbEspece{$Salé}\
		;"Organe";TbOrgane{$Salé}\
		;"Lésion";TbNomLésion{$Salé}\
		;"Dimensions";TbDimensions{$Salé}\
		;"Ref";TbRef{$Salé}\
		;"Lien";TbLien{$Salé}\
		;"Commentaires";TbDescription{$Salé})
	[DiaData:45]XTexte:7:=TbChemin{$Salé}
	READ PICTURE FILE:C678(TbChemin{$Salé};$VarImage)
	PICTURE PROPERTIES:C457($VarImage;$Largeur;$Hauteur)
	$DefStandard:=1871*2835
	$DefMini:=900*1400
	$DefImage:=$Largeur*$Hauteur
	$Rapport:=Round:C94($Largeur/$Hauteur;2)
	If ($Rapport<1)
		$Rapport:=Round:C94($Hauteur/$Largeur;2)
	End if 
	$RapIdeal:=Round:C94(2835/1871;2)
	Case of 
		: ($Largeur*$Hauteur<$DefMini)
			$Couleur:=0x00FF0000
			
		: ($Largeur*$Hauteur<$DefStandard)
			$Couleur:=0x00F2C473
			
		Else 
			
			$Couleur:=0xFF00
	End case 
	OBJECT SET RGB COLORS:C628(VarValeurTech;$Couleur;$Couleur)
	$PoidsImage:=Picture size:C356($VarImage)/1000000
	$Pict:=DiaImageObsolete (VarImage)
	$Compatible:=Num:C11($Pict)*"non "
	VarComImage:="Définition : "+String:C10($Largeur)+" x "+String:C10($Hauteur)+<>ZCR
	VarComImage:=VarComImage+"Définition minimale : 2835 x 1871"+<>ZCR
	VarComImage:=VarComImage+"Poids : "+String:C10($PoidsImage)+" Mo"+<>ZCR
	VarComImage:=VarComImage+"Rapport : "+String:C10($Rapport)+" (idéal "+String:C10($RapIdeal)+")"+<>ZCR
	VarComImage:=VarComImage+"Compatibilité du CODEC : "+$Compatible+"compatible"
	[DiaData:45]XTexteSup:8:=VarComImage
	[DiaData:45]XAlpha:14:="A traiter"
	[DiaData:45]XEntier:2:=0
	[DiaData:45]XValeur:4:=$TbNumSérie{$Salé}
	[DiaData:45]XNom:1:=$NomFichierImage
	SAVE RECORD:C53([DiaData:45])
	
	
End for 
ALERT:C41("Création achevée")

