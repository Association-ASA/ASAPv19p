//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 07/12/17, 14:39:08
  // ----------------------------------------------------
  // Méthode : WebPanierAjouteDia
  // Description
  // Traitement du message ajax d'une demande d'ajout d'une photo 
  //    à un panier
  // Paramètres : $1 = message  type "paniercegeheme@wanadoo.fr£307041£mp£cgm£oh le beau mp"
  // ----------------------------------------------------
C_LONGINT:C283($Pos)

$Mess:=$1
$Langue:=$Mess[[7]]
  // Extraction du login
$Mess:=Substring:C12($Mess;8)  // "cegeheme@wanadoo.fr£307041£mp£cgm£oh le beau mp"
$Pos:=Position:C15("£";$Mess)
$login:=Substring:C12($Mess;1;($Pos-1))  // "cegeheme@wanadoo.fr"
$Mess:=Substring:C12($Mess;($Pos+1))  //  "307041£mp£cgm£oh le beau mp"
  // Extraction du n° de la diapo à ajouter
$Pos:=Position:C15("£";$Mess)
$NumDiapoA:=Substring:C12($Mess;1;($Pos-1))  //  "307041"
$Mess:=Substring:C12($Mess;($Pos+1))  //  "mp£cgm£oh le beau mp"

  //Extraction du nom du panier
$Pos:=Position:C15("£";$Mess)
$NomPanier:=Substring:C12($Mess;1;($Pos-1))  // "mp"
$Mess:=Substring:C12($Mess;($Pos+1))  //  "cgm£oh le beau mp"

  //Extraction des initiales
$Pos:=Position:C15("£";$Mess)
$Initiales:=Substring:C12($Mess;1;($Pos-1))  //  "cgm"

  // Extraction du descriptif du panier
$Descriptif:=Substring:C12($Mess;($Pos+1))  //  "oh le beau mp"

READ WRITE:C146([DiaData:45])
QUERY:C277([DiaData:45];[DiaData:45]XAlpha:14=$login;*)
QUERY:C277([DiaData:45]; & [DiaData:45]XType:5=$Initiales;*)
QUERY:C277([DiaData:45]; & [DiaData:45]XNom:1=$NomPanier)
If (Records in selection:C76([DiaData:45])=0)
	CREATE RECORD:C68([DiaData:45])
	[DiaData:45]XNom:1:=$NomPanier
	[DiaData:45]XAlpha:14:=$login
	[DiaData:45]XType:5:=$Initiales
	[DiaData:45]XTexteSup:8:=$Descriptif
	[DiaData:45]XEntier:2:=1951  // pour pouvoir voir tous les paniers!
	[DiaData:45]XDate:3:=Current date:C33
	[DiaData:45]XHeure:13:=Current time:C178
End if 
If ($NomPanier#"")
	[DiaData:45]XTexte:7:=[DiaData:45]XTexte:7+$NumDiapoA+<>ZCR
	SAVE RECORD:C53([DiaData:45])
End if 
ZAmnistiePartielle (->[DiaData:45])
If ($NomPanier="")
	$Envoi:=DiaWebTraduitTexte ("Précisez le nom du panier";$Langue)
Else 
	$Envoi:=DiaWebTraduitTexte ("La photographie a été ajoutée au panier";$Langue)
	$Envoi:=Replace string:C233($Envoi;"30704";$NumDiapoA)
	$Envoi:=Replace string:C233($Envoi;(<>ZGuil*2);(<>ZGuil+$NomPanier+<>ZGuil))
End if 
WEB SEND TEXT:C677($Envoi)
