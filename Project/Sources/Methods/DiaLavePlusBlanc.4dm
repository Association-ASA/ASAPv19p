//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 04/08/19, 10:47:12
// ----------------------------------------------------
// Méthode : AdLavePlusBlanc
// Description
//  Méthode qui renvoie la chaine proposée
//  sans retour chariot derrière
//  sans les blancs devant derrière 
// et sans ponctuation finale
// ----------------------------------------------------
$Chaine:=$1

$Chaine:=Replace string:C233($Chaine; "  "; " ")
$Chaine:=Replace string:C233($Chaine; ".."; ".")
$Chaine:=Replace string:C233($Chaine; (<>ZGuil*2); <>ZGuil)

If ($Chaine#"")
	// les blancs et les " devant
	$Fini:=False:C215
	Repeat 
		If ($Chaine[[1]]=" ") | ($Chaine[[1]]=<>ZGuil)
			$Chaine:=Substring:C12($Chaine; 2)
		Else 
			$Fini:=True:C214
		End if 
	Until ($Fini)
	
	// les blancs retour charriot et points derrière
	$Fini:=False:C215
	Repeat 
		$L:=Length:C16($Chaine)
		If ($Chaine[[$L]]=" ") | ($Chaine[[$L]]=".") | ($Chaine[[$L]]=<>ZCR) | ($Chaine[[$L]]=<>ZGuil)
			$Chaine:=Substring:C12($Chaine; 1; ($L-1))
		Else 
			$Fini:=True:C214
		End if 
	Until ($Fini)
End if 
If (Length:C16($Chaine)>0)
	$Chaine:=$Chaine+"."
End if 
$0:=$Chaine
