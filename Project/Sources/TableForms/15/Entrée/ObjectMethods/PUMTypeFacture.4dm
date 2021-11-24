C_OBJECT:C1216($ent)

If (Form event code:C388=Sur données modifiées:K2:15)
	
	Case of 
			// $entSel:=ds.CampagneParticipations.query("Arguments.CodeRaemaLié ==:1";"@")
			// A mettre en place pour le calcul du prochain numéro de facture
			
			
		: (PUMTypeFacture=1)  // Cotisation individuelle
			$Test:=<>ZPermMille+"/C@"
			
		: (PUMTypeFacture=2)  // RAEMA poudre
			$Test:=<>ZPermMille+"/RT@"
			
			//$L:=Chercher dans tableau(TbNumFactureEnCours;(<>ZPermMille+"/RT@"))
			//$Index:=Num(Sous chaîne(TbNumFactureEnCours{$L};5))+1
			//[Factures]NumFacture:=<>ZPermMille+"/RT"+Chaîne($Index;"0000")
			
			
		: (PUMTypeFacture=3)  // RAEMA gel
			$Test:=<>ZPermMille+"/RC@"
			
		: (PUMTypeFacture=4)  // Autres
			$Test:=<>ZPermMille+"/X@"
			
		Else 
			ALERT:C41("Merci de désigner un type de facture")
	End case 
	$ent:=ds:C1482.Factures.query("NumFacture = :1"; $Test).orderBy("NumFacture desc")
	If ($ent.length>0)
		$ProchNumFacture:=Num:C11(Substring:C12($ent[0].NumFacture; 4))+1
	Else 
		$ProchNumFacture:=1
	End if 
	[Factures:15]NumFacture:3:=Substring:C12($test; 1; (Length:C16($test)-1))+String:C10($ProchNumFacture; "0000")
	
	
	If (CaseDevis=1)
		[Factures:15]NumFacture:3:=[Factures:15]NumFacture:3+"D"
	End if 
End if 
