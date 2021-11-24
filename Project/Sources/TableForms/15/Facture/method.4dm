$Evt:=Form event code:C388
Case of 
	: ($Evt=Sur chargement:K2:1)
		
		// LIEN RETOUR([Factures]NumFacture)
		$L:=Find in array:C230(<>TbPerUUID; [Factures:15]UUIDPersonne:2)
		$MontantFactureAvoir:=(Num:C11([Factures:15]TotalTTC:10<0)*(-[Factures:15]TotalTTC:10))+(Num:C11([Factures:15]TotalTTC:10>=0)*[Factures:15]TotalTTC:10)
		If ($MontantFactureAvoir>0)
			VarETLF:="Soit la somme de "+ZfEtl($MontantFactureAvoir)+" en votre aimable réglement."
		Else 
			VarETLF:=""
		End if 
		VarTVAIntra:=("N° TVA intracommunautaire : "+<>TbPANumTVAIntraCom{$L})*Num:C11(<>TbPANumTVAIntraCom{$L}#"")
		VarNumClient:=<>TbPerNumPersonne{$L}
		If ([Factures:15]NumFacture:3="@d")
			VarTypeFac:="DEVIS"
		Else 
			If ([Factures:15]NumFacture:3="@a")
				VarTypeFac:="AVOIR de la facture "+Substring:C12([Factures:15]NumFacture:3; 1; (Length:C16([Factures:15]NumFacture:3)-1))
			Else 
				VarTypeFac:="FACTURE"
			End if 
		End if 
		$Et:=((<>TbPerAdrLivPays{$l}#"france") & (<>TbPerAdrLivPays{$l}#""))
		
		Case of 
			: ([Factures:15]UUIDPersonne:2="42E03CB27DF345C093185A574043C5DF")
				VarRetenueSource:="La retenue à la source est à la charge d’UNIMER"
				
			: ([Factures:15]UUIDPersonne:2="CB79D7B3545F402E99495483F77BAADD")
				VarRetenueSource:="La retenue à la source est à la charge de Casalab Food Analysis"
				
			: ([Factures:15]UUIDPersonne:2="DF1A1C24494F435F81343697B1692963")
				VarRetenueSource:="La taxe retenue à la source, n'est pas à la charge du prestataire mais à la charge du client : LC2A."+<>ZCR+"Lieu d'exécution de la prestation : Maroc."
				
			: ([Factures:15]UUIDPersonne:2="520E3A39FEF44596BEBF1A8D9E70E839")
				VarRetenueSource:="Toute impôt et taxes dus au Maroc sont à la charge de la Ste IMPELAB."+<>ZCR+"Lieu d’exécution de la prestation de service France"+<>ZCR+"La somme due ne tient pas compte d'éventuels frais bancaires qui restent entièrement à la charge de : IMPELAB."
				
			: ($Et)
				VarRetenueSource:="La somme due ne tient pas compte d'éventuels frais bancaires qui restent entièrement à la charge de : "+<>TbPerAdrFacAd1{$L}
				
			Else 
				VarRetenueSource:=""
		End case 
		// OBJET FIXER VISIBLE(*;"Etran@";$Et)
		
	: ($Evt=Sur impression corps:K2:18)
		//OBJET FIXER FORMATAGE([Factures]TotalHT;<>PermEnE)
		//OBJET FIXER FORMATAGE([Factures]TotalTVA;<>PermEnE)
		//OBJET FIXER FORMATAGE([Factures]TotalTTC;<>PermEnE)
		//OBJET FIXER FORMATAGE(VarTFF;<>PermEnF)
		
End case 