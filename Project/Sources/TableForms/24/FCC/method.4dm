$Evt:=Form event code:C388
Case of 
	: ($Evt=On Load:K2:1)
		// Initialisation de toutes les variables 
		CacAppelTel:=[RetoursFiches:24]Appel:4
		
		//CacASA
		//CacADILVA
		//CaCReclamation
		//CaCTechnique
		//CaCStat
		//CaCInformatique
		//CaCQualite
		//CaCAdministratif
		//VarNumFiche
		//VarNomClient
		//VarNumLabo
		//VarNumFTNC
		//VarDescription
		//VarNumCIL
		//VarDateRetour
		//VarCreateurFiche
		
		
	: ($Evt=On Printing Detail:K2:18)
		//OBJET FIXER FORMATAGE([Factures]TotalHT;<>PermEnE)
		//OBJET FIXER FORMATAGE([Factures]TotalTVA;<>PermEnE)
		//OBJET FIXER FORMATAGE([Factures]TotalTTC;<>PermEnE)
		//OBJET FIXER FORMATAGE(VarTFF;<>PermEnF)
		
End case 