//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 22/11/21, 18:08:55
// ----------------------------------------------------
// Méthode : ASAPImprimeFactureLigne
// Description
// Imprime la facture courante
//  lignes par lignes
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)

PRINT SETTINGS:C106
If (OK=1)
	OPEN PRINTING JOB:C995
	GET PRINTABLE AREA:C703($HauteurMax)
	$HauteurRestante:=$HauteurMax
	ContexteImpression:=""
	
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
	$H:=Print form:C5([Factures:15]; "FactureLigne"; 0; 303)
	$HauteurRestante:=$HauteurRestante-$H
	$FT:=Size of array:C274(TbPrestation)
	For ($Salé; 1; $FT)
		ChampIntitule:=TbPrestation{$Salé}
		ChampQte:=TbQuantite{$Salé}
		ChampTVA:=TbTauxTVA{$Salé}
		ChampPrixUHT:=TbPrixUHT{$Salé}
		ChampTotal:=TbPrixTTC{$Salé}
		ContexteImpression:="Ventes"
		$H:=Print form:C5([Factures:15]; "FactureLigne")
		$HauteurRestante:=$HauteurRestante-$H
	End for 
	$HauteurBlanc:=$HauteurRestante-(827-491)
	$H:=Print form:C5([Factures:15]; "FactureLigne"; 2000; 2000+$HauteurBlanc)
	$HauteurRestante:=$HauteurRestante-$H
	$H:=Print form:C5([Factures:15]; "FactureLigne"; 491; 827)
	$HauteurRestante:=$HauteurRestante-$H
	
	CLOSE PRINTING JOB:C996
End if 