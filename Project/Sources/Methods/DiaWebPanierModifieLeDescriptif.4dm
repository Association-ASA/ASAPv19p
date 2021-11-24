//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 26/08/18, 07:57:13
// ----------------------------------------------------
// Méthode : WebPanierModifieDescriptif
// Description
// Modification de la [XDonnees] du panier
//
// Paramètre $1 de type "paniermodif"+numenr+'£'+nompanier+'£'+initiales+'£'+companier;  si Modification
// Paramètre $1 de type "paniertuer"+numenr si Suppression

// ----------------------------------------------------

$Mess:=$1
$Modif:=(Count parameters:C259=1)
If ($Modif)
	$Pos:=Position:C15("£"; $Mess)
	
	$NumEnrPanierN:=Num:C11(Substring:C12($Mess; 1; ($Pos-1)))
	$Mess:=Substring:C12($Mess; ($Pos+1))
	$Pos:=Position:C15("£"; $Mess)
	$NomPanier:=Substring:C12($Mess; 1; ($Pos-1))
	$Mess:=Substring:C12($Mess; ($Pos+1))
	$Pos:=Position:C15("£"; $Mess)
	$Initiales:=Substring:C12($Mess; 1; ($Pos-1))
	$Descriptif:=Substring:C12($Mess; ($Pos+1))
	
Else 
	$NumEnrPanierN:=Num:C11($Mess)
End if 
READ WRITE:C146([DiaData:45])
GOTO RECORD:C242([DiaData:45]; $NumEnrPanierN)
If ($Modif)
	[DiaData:45]XNom:1:=$NomPanier
	[DiaData:45]XType:5:=$Initiales
	[DiaData:45]XTexteSup:8:=$Descriptif
Else 
	[DiaData:45]XBool:9:=True:C214
End if 
SAVE RECORD:C53([DiaData:45])
ZAmnistiePartielle(->[DiaData:45])
WEB SEND TEXT:C677("OK")