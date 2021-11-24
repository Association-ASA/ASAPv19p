C_LONGINT:C283($C; $L)
LISTBOX GET CELL POSITION:C971(*; "Lb_Tableaux"; $C; $L)
If ($L=0)
	ALERT:C41("Merci de désigner la facture dont vous souhaitez générer un avoir")
Else 
	GOTO RECORD:C242([Factures:15]; TbNumEnr{$L})
	QUERY:C277([Ventes:16]; [Ventes:16]NumFacture:2=[Factures:15]NumFacture:3)
	Case of 
		: ([Factures:15]NumFacture:3="@A")
			ALERT:C41("La facture est déjà un avoir ...")
			
		: ([Factures:15]NumFacture:3="@D")
			ALERT:C41("Vous avez désigné un devis ...")
			
			//([Factures]NumFacture#"@x")
			
		Else 
			If (Records in selection:C76([Factures:15])=1)
				If ([Factures:15]Regle:12=True:C214)
					ALERT:C41("Vous ne pouvez pas créer un AVOIR d'une facture déjà réglée")
				Else 
					READ WRITE:C146([Ventes:16])
					READ WRITE:C146([Factures:15])
					ARRAY LONGINT:C221($TbNumEnrVentes; 0)
					LONGINT ARRAY FROM SELECTION:C647([Ventes:16]; $TbNumEnrVentes)
					$FT:=Size of array:C274($TbNumEnrVentes)
					For ($Salé; 1; $FT)
						GOTO RECORD:C242([Ventes:16]; $TbNumEnrVentes{$Salé})
						DUPLICATE RECORD:C225([Ventes:16])
						[Ventes:16]NumFacture:2:=[Ventes:16]NumFacture:2+"A"
						[Ventes:16]PrixTotalHT:7:=-[Ventes:16]PrixTotalHT:7
						//[Ventes]PrixTTC:=-[Ventes]PrixTTC
						[Ventes:16]PrixUHT:5:=-[Ventes:16]PrixUHT:5
						SAVE RECORD:C53([Ventes:16])
					End for 
					SAVE RECORD:C53([Factures:15])
					DUPLICATE RECORD:C225([Factures:15])
					[Factures:15]NumFacture:3:=[Factures:15]NumFacture:3+"A"
					[Factures:15]TotalHT:8:=-[Factures:15]TotalHT:8
					[Factures:15]TotalTTC:10:=-[Factures:15]TotalTTC:10
					[Factures:15]TotalTVA:9:=-[Factures:15]TotalTVA:9
					[Factures:15]Avoir:17:=True:C214
					SAVE RECORD:C53([Factures:15])
					
					GOTO RECORD:C242([Factures:15]; TbNumEnr{$L})
					[Factures:15]Avoir:17:=True:C214
					SAVE RECORD:C53([Factures:15])
					
					ALERT:C41("L'avoir a été créé avec succès")
				End if 
			End if 
	End case 
End if 
ALL RECORDS:C47([Factures:15])
QUERY:C277([Factures:15]; [Factures:15]NumFacture:3=<>ZPERMMILLE+"@")
ASAPFabriqueTbFactures
