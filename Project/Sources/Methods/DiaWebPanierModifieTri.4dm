//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/12/17, 08:03:56
  // ----------------------------------------------------
  // Méthode : WebPanierModifieTri
  // Description
  // Méthode qui reçoit le tri après réarrangement 
  //  des photos par le visiteur Web dans le panier
  // Paramètre : $1 = message AJAX de type "photopanier307041_7464£...photopanier101452_7464£ 
  // ----------------------------------------------------

C_LONGINT:C283($Pos;$Pos2)

$Mess:=$1
$Pos:=Position:C15("£";$Mess)
If ($Pos>0)
	$Pos2:=Position:C15("_";$Mess)
	$NumEnrA:=Substring:C12($Mess;($Pos2+1))  //7464£...photopanier101452_7464£
	$Pos2:=Position:C15("£";$NumEnrA)
	$NumEnr:=Num:C11(Substring:C12($NumEnrA;1;($Pos2-1)))
	$Xtexte:=""
	While ($Pos>0)
		$Diapo:=Substring:C12($Mess;1;($Pos-1))  // photopanier307041_7464
		$Xtexte:=$Xtexte+Substring:C12($Mess;12;5)+<>ZCR
		$Mess:=Substring:C12($Mess;($Pos+1))
		$Pos:=Position:C15("£";$Mess)
	End while 
	READ WRITE:C146([DiaData:45])
	GOTO RECORD:C242([DiaData:45];$NumEnr)
	[DiaData:45]XTexte:7:=$Xtexte
	SAVE RECORD:C53([DiaData:45])
	ZAmnistiePartielle (->[DiaData:45])
End if 