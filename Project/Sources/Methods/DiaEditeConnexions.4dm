//%attributes = {"lang":"fr"}
C_LONGINT:C283($Salé; $FT)
$Rapport:=""
$Gibier:=Num:C11(PUMTypeAsaDia=2)*"gibier "
$AnDernierA:=String:C10(Year of:C25(Current date:C33)-1)
$AnCourantA:=String:C10(Year of:C25(Current date:C33))
$Sup:=Num:C11(Month of:C24(Current date:C33)#12)*(String:C10(Year of:C25(Current date:C33)-1)+" -")
VarDateJour:="Statistiques d'AsaDia en "+$Sup+" 20"+<>ZPermMille+" au "+String:C10(DerDate; 3)
$Rapport:=$Rapport+"Fréquentation Web par mois"+<>ZCR
$Rapport:=$Rapport+"Qui ?"
For ($Salé; 1; 12)
	$AnAffiche:=(Num:C11($Salé>Month of:C24(Current date:C33))*$AnDernierA)+(Num:C11($Salé<=Month of:C24(Current date:C33))*$AnCourantA)
	$Rapport:=$Rapport+<>ZTab+<>ZTbNomDuMois{$Salé}+" "+$AnAffiche
End for 
$Rapport:=$Rapport+<>ZCR
$FT:=Size of array:C274(TbVisiteur)
For ($Salé; 1; $FT)
	$Rapport:=$Rapport+TbVisiteur{$Salé}+<>ZTab+String:C10(TbNbJanvier{$Salé})+<>ZTab+String:C10(TbNbFevrier{$Salé})+<>ZTab+String:C10(TbNbMars{$Salé})+<>ZTab
	$Rapport:=$Rapport+String:C10(TbNbAvril{$Salé})+<>ZTab+String:C10(TbNbMai{$Salé})+<>ZTab+String:C10(TbNbJuin{$Salé})
	$Rapport:=$Rapport+<>ZTab+String:C10(TbNbJuillet{$Salé})+<>ZTab+String:C10(TbNbAout{$Salé})+<>ZTab+String:C10(TbNbSeptembre{$Salé})+<>ZTab
	$Rapport:=$Rapport+String:C10(TbNbOctobre{$Salé})+<>ZTab+String:C10(TbNbNovembre{$Salé})+<>ZTab+String:C10(TbNbDécembre{$Salé})
	$Rapport:=$Rapport+<>ZCR
End for 


$Rapport:=$Rapport+<>ZCR2+"Classement des photos visionnées en pleine page par les abattoirs"+<>ZCR
$FT:=Size of array:C274(TbTTNumPhotoN)
For ($Salé; 1; $FT)
	$Rapport:=$Rapport+String:C10(TbTTNumPhotoN{$Salé})+<>ZTab+TbTTTriplette{$Salé}+<>ZTab+String:C10(TbTTOccurence{$Salé})+<>ZCR
End for 

$Rapport:=$Rapport+<>ZCR2+"Liste des visiteurs d'AsaDia"+<>ZCR
$FT:=Size of array:C274(TbLoginOcc)
For ($Salé; 1; $FT)
	$Rapport:=$Rapport+TbLoginMail{$Salé}+<>ZTab+String:C10(TbLoginOcc{$Salé})+<>ZCR
End for 

$Rapport:=$Rapport+<>ZCR2+"Liste des photographie jamais vues"+<>ZCR
$FT:=Size of array:C274(TbJVNumPhotoN)
For ($Salé; 1; $FT)
	$Rapport:=$Rapport+String:C10(TbJVNumPhotoN{$Salé})+<>ZCR
End for 
$0:=""
If (Count parameters:C259=0)
	SET TEXT TO PASTEBOARD:C523($Rapport)
Else 
	$0:=$Rapport
End if 