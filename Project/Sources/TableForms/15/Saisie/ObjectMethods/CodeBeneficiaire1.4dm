$evt:=Form event code:C388

Case of 
	: ($evt=Sur données modifiées:K2:15)
		
		If (VarLaboratoire=True:C214)
			$UUIDLabo:=ASAPTrouveUUIDLaboParNumero(Num:C11(CodeBeneficiaire))
			$L:=Find in array:C230(<>TbPerUUID; $UUIDLabo)
			VarAdresseFacture:=""
			If (<>TbPerAdrFacAd1{$L}#"")
				VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrFacAd1{$L}+<>ZCR
			End if 
			If (<>TbPerAdrFacAd2{$L}#"")
				VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrFacAd2{$L}+<>ZCR
			End if 
			If (<>TbPerAdrFacAd3{$L}#"")
				VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrFacAd3{$L}+<>ZCR
			End if 
			If (<>TbPerAdrFacCP{$L}#"")
				VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrFacCP{$L}+" "+<>TbPerAdrFacVille{$L}
			End if 
			If (<>TbPerAdrFacPays{$L}#"")
				VarAdresseFacture:=VarAdresseFacture+<>ZCR+<>TbPerAdrFacPays{$L}
			End if 
			
			If (VarAdresseFacture="")
				ALERT:C41("L'adresse de facturation n'a pas été rempli pour ce laboratoire. Merci de compléter la fiche avant de créer la facture.")
			End if 
		Else 
			$L:=Find in array:C230(<>TbPerNumPersonne; Num:C11(CodeBeneficiaire))
			$UUIDAdh:=<>TbPerUUID{$L}
			QUERY:C277([Personnes:12]; [Personnes:12]UUID:1=$UUIDAdh)
			$Civilité:=OB Get:C1224([Personnes:12]Arguments:7; "Civilités"; Est un texte:K8:3)
			$PrénomAdh:=OB Get:C1224([Personnes:12]Arguments:7; "Prénom"; Est un texte:K8:3)
			VarAdresseFacture:=$Civilité+" "+$PrénomAdh+" "+<>TbPerNomLong{$L}+<>ZCR
			If (<>TbPerAdrPerAd1{$L}#"")
				VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrPerAd1{$L}+<>ZCR
			End if 
			If (<>TbPerAdrPerAd2{$L}#"")
				VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrPerAd2{$L}+<>ZCR
			End if 
			If (<>TbPerAdrPerAd3{$L}#"")
				VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrPerAd3{$L}+<>ZCR
			End if 
			If (<>TbPerAdrPerCP{$L}#"")
				VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrPerCP{$L}+" "+<>TbPerAdrPerVille{$L}
			End if 
			If (<>TbPerAdrPerPays{$L}#"")
				VarAdresseFacture:=VarAdresseFacture+<>ZCR+<>TbPerAdrPerPays{$L}
			End if 
			//VarAdresseFacture:=$Civilité+" "+$PrénomAdh+" "+<>TbPerAdrPerAd1{$L}+<>ZCR+<>TbPerAdrPerAd2{$L}+<>ZCR+<>TbPerAdrPerAd3{$L}+<>ZCR+<>TbPerAdrPerCP{$L}+" "+<>TbPerAdrPerVille{$L}+<>ZCR+<>TbPerAdrPerPays{$L}
			If (<>TbPerAdrPerAd1{$L}="")
				VarAdresseFacture:=$Civilité+" "+$PrénomAdh+<>ZCR
				If (<>TbPerAdrProAd1{$L}#"")
					VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrProAd1{$L}+<>ZCR
				End if 
				If (<>TbPerAdrProAd2{$L}#"")
					VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrProAd2{$L}+<>ZCR
				End if 
				If (<>TbPerAdrProAd3{$L}#"")
					VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrProAd3{$L}+<>ZCR
				End if 
				If (<>TbPerAdrProCP{$L}#"")
					VarAdresseFacture:=VarAdresseFacture+<>TbPerAdrProCP{$L}+" "+<>TbPerAdrProVille{$L}
				End if 
				If (<>TbPerAdrProPays{$L}#"")
					VarAdresseFacture:=VarAdresseFacture+<>ZCR+<>TbPerAdrProPays{$L}
				End if 
				//VarAdresseFacture:=$Civilité+" "+$PrénomAdh+" "+<>TbPerAdrProAd1{$L}+<>ZCR+<>TbPerAdrProAd2{$L}+<>ZCR+<>TbPerAdrProAd3{$L}+<>ZCR+<>TbPerAdrProCP{$L}+" "+<>TbPerAdrProVille{$L}+<>ZCR+<>TbPerAdrProPays{$L}
			End if 
		End if 
		[Personnes:12]UUID:1:=CodeBeneficiaire
End case 