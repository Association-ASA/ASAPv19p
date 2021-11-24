CONFIRM:C162("Êtes-vous sûr de vouloir supprimer le règlement de la facture n°"+[Factures:15]NumFacture:3+" ?")
If (ok=1)
	READ WRITE:C146([Ventes:16])
	READ WRITE:C146([Factures:15])
	[Factures:15]Regle:12:=False:C215
	SAVE RECORD:C53([Factures:15])
	RELATE MANY:C262([Factures:15]NumFacture:3)
	$FT:=Records in selection:C76([Ventes:16])
	For ($Salé; 1; $FT)
		[Ventes:16]DateReglement:12:=!00-00-00!
		[Ventes:16]NumCheque:11:=""
		[Ventes:16]Banque:10:=""
		SAVE RECORD:C53([Ventes:16])
		NEXT RECORD:C51([Ventes:16])
	End for 
End if 
OBJECT SET VISIBLE:C603(*; "regle@"; False:C215)
