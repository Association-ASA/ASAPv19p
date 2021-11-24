ZFini:=True:C214
Case of 
		
	: (VarModifPer & VarModifPar)
		$Prc:=Execute on server:C373("ASAPFabriqueTbLaboratoires";0;*)
		
	: (VarModifPer)
		$Prc:=Execute on server:C373("ASAPFabriqueTbPersonnes";0;*)
		
	: (VarModifPar)
		$Prc:=Execute on server:C373("ASAPFabriqueTbParticipe";0;*)
		
		
End case 