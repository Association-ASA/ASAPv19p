//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : cgm
// Date et heure : 07/12/15, 08:09:11
// ----------------------------------------------------
// Méthode : WebAfficheTriplette
// Description
// $1 = rang de la diapositive dans <>TbNumDia
//  donné par $L:=Chercher dans tableau(<>TbNumDia;NumDiapo)
// $2 = langue "A" si anglais français sinon
// Paramètres
// ----------------------------------------------------

$L:=$1
$Langue:=$2
$Espece:=DiaWebTraduitTexte(<>TbEspece{$L}; $Langue)
If ($Espece[[Length:C16($Espece)]]="s") & ($Espece#"Chamois")
	$Espece:=Substring:C12($Espece; 1; Length:C16($Espece)-1)
End if 
$Espece:=Lowercase:C14($Espece)
$lesion:=DiaWebTraduitLesion(<>TbNomLes{$L}; $Langue)
If ($lesion#"")
	$NL:=Uppercase:C13(Substring:C12($lesion; 1; 1))+Substring:C12($lesion; 2)
Else 
	$NL:=$lesion
End if 
Case of 
	: ($Langue="F")
		$t:=$NL+" sur "+Lowercase:C14(DiaWebTraduitTexte(<>TbOrgane{$L}; $Langue))+" chez un "+$Espece
		
	: ($Langue="A")
		$t:=$NL+" on "+Lowercase:C14(DiaWebTraduitTexte(<>TbOrgane{$L}; $Langue))+" in "+$Espece
	Else 
		$t:=$NL+" / "+Lowercase:C14(DiaWebTraduitTexte(<>TbOrgane{$L}; $Langue))+" / "+$Espece
End case 
$0:=$t