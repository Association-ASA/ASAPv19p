$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		If (CaseDevis=1)
			[Factures:15]NumFacture:3:=[Factures:15]NumFacture:3+"D"
		Else 
			$NumFacture:=[Factures:15]NumFacture:3
			$pos:=Position:C15("D";$NumFacture)
			[Factures:15]NumFacture:3:=Substring:C12([Factures:15]NumFacture:3;1;$pos-1)
		End if 
End case 