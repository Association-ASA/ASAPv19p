//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 22/04/20, 06:00:28
// ----------------------------------------------------
// Méthode : AntichambreGibierClicDansTb
// Description
// Méthode qui écrit le détail de la photo
//  qu'il affiche
// Paramètre : ligne du tableau
// ----------------------------------------------------

$L:=$1
If ($L>0)
	URLCourante:=TbChemin{$L}
	If (Test path name:C476(URLCourante)=Est un document:K24:1)
		READ PICTURE FILE:C678(TbChemin{$L}; VarImage)
	Else 
		$URL:=Replace string:C233(URLCourante; "IMacASA2017HD:Users:asa:"; "MBPASA2015:Users:ASA15:")
		READ PICTURE FILE:C678($URL; VarImage)
	End if 
	PICTURE PROPERTIES:C457(VarImage; $Largeur; $Hauteur)
	$DefStandard:=1871*2835
	$DefMini:=900*1400
	$DefImage:=$Largeur*$Hauteur
	$Rapport:=Round:C94($Largeur/$Hauteur; 2)
	If ($Rapport<1)
		$Rapport:=Round:C94($Hauteur/$Largeur; 2)
	End if 
	$RapIdeal:=Round:C94(2835/1871; 2)
	Case of 
		: ($Largeur*$Hauteur<$DefMini)
			$Couleur:=0x00FF0000
			
		: ($Largeur*$Hauteur<$DefStandard)
			$Couleur:=0x00F2C473
			
		Else 
			
			$Couleur:=0xFF00
	End case 
	OBJECT SET RGB COLORS:C628(VarValeurTech; $Couleur; $Couleur)
	$PoidsImage:=Picture size:C356(VarImage)/1000000
	$Pict:=DiaImageObsolete(VarImage)
	$Compatible:=Num:C11($Pict)*"non "
	VarComImage:="Définition : "+String:C10($Largeur)+" x "+String:C10($Hauteur)+<>ZCR
	VarComImage:=VarComImage+"Définition minimale : 2835 x 1871"+<>ZCR
	VarComImage:=VarComImage+"Poids : "+String:C10($PoidsImage)+" Mo"+<>ZCR
	VarComImage:=VarComImage+"Rapport : "+String:C10($Rapport)+" (idéal "+String:C10($RapIdeal)+")"+<>ZCR
	VarComImage:=VarComImage+"Compatibilité du CODEC : "+$Compatible+"compatible"
	VarRef:=TbRef{$L}
	QUERY BY ATTRIBUTE:C1331([Diapositives:40]; [Diapositives:40]ObjetDiapo:32; "RefPhotoPrincipaleGibier"; =; TbRef{$L})
	VarNumDiaA:=String:C10([Diapositives:40]NumOrdreDiapos:1)
	VarAuteur:=TbAuteur{$L}
	VarCom:=TbDescription{$L}
	VarTriplette:=Uppercase:C13(TbNomLésion{$L}[[1]])+Lowercase:C14(Substring:C12(TbNomLésion{$L}; 2)+" sur "+TbOrgane{$L}+" de "+TbEspèce{$L})
	VarCDPhotos:=TbChemin{$L}
Else 
	VarComImage:=""
	VarImage:=<>VarImageVide
	VarRef:=""
	VarNumDiaA:=""
	VarAuteur:=""
	VarCom:=""
	VarTriplette:=""
	VarCDPhotos:=""
	LISTBOX SELECT ROW:C912(*; "ListBoxPhotos"; 0; lk supprimer de sélection:K53:3)
End if 