$Evt:=Form event code:C388
Case of 
	: ($Evt=Sur chargement:K2:1)
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
		
		
	: ($Evt=Sur impression corps:K2:18)
		//OBJET FIXER FORMATAGE([Factures]TotalHT;<>PermEnE)
		//OBJET FIXER FORMATAGE([Factures]TotalTVA;<>PermEnE)
		//OBJET FIXER FORMATAGE([Factures]TotalTTC;<>PermEnE)
		//OBJET FIXER FORMATAGE(VarTFF;<>PermEnF)
		
End case 