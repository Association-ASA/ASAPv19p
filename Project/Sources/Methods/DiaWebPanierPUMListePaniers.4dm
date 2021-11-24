//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 09/12/17, 15:04:02
  // ----------------------------------------------------
  // Méthode : WebPanierPUMListePaniers
  // Description
  // Réaction au changement de proposition 
  // d'un panier choisi dans le PUM
  // Paramètre $1 = message AJAX type "pumpanier7464"  
  //     où 7464 = numéro d'enregistrement [XDonnees] du panier
  // ----------------------------------------------------

$NumEnrPanier:=Num:C11($1)
If ($NumEnrPanier=0)
	$Envoi:="££"
Else 
	GOTO RECORD:C242([DiaData:45];$NumEnrPanier)
	$Envoi:=[DiaData:45]XNom:1+"£"+[DiaData:45]XType:5+"£"+[DiaData:45]XTexteSup:8
End if 
WEB SEND TEXT:C677($Envoi)