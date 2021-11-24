//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 31/03/16, 07:29:05
  // ----------------------------------------------------
  // Méthode : Ad3ExtraitComFleches
  // Description
  // Ecrit dans le PP les commentaires des photos
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)
ALL RECORDS:C47([Diapositives:40])
ORDER BY:C49([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1;>)
$FT:=Records in selection:C76([Diapositives:40])
$T:=""
For ($Fumé;1;$FT)
	ZBlobVersVariable (->[Diapositives:40]BlobFleches:21;->TbTb;->TbLHT;->TbTCa)
	For ($Salé;1;4)
		$VarLigne:=TbTb{$Salé}
		If ($VarLigne#"")
			$Pos:=Position:C15(" ";$VarLigne)
			$VarLigne:=Substring:C12($VarLigne;($Pos+1))
			$Pos:=Position:C15(" ";$VarLigne)
			$VarLigne:=Substring:C12($VarLigne;($Pos+1))
			$Pos:=Position:C15(" ";$VarLigne)
			$VarLigne:=Replace string:C233(Substring:C12($VarLigne;($Pos+1));<>ZCR;"£")
			$VarComFr:=Replace string:C233([Diapositives:40]Commentaires:7;<>ZCR;"£")
			$VarComFr:=Replace string:C233($VarComFr;Char:C90(10);"£")
			
			$T:=$T+String:C10([Diapositives:40]NumOrdreDiapos:1)+<>ZTab+String:C10($Salé)+<>ZTab+$VarLigne+<>ZTab+$VarComFr+<>ZTab+Replace string:C233([Diapositives:40]CommentaireA:28;<>ZCR;"£")+<>ZCR
		End if 
		
	End for 
	NEXT RECORD:C51([Diapositives:40])
End for 
  // FIXER TEXTE DANS CONTENEUR($T)