If (Form event code:C388=Sur chargement:K2:1)
	C_LONGINT:C283(CaCGibier)
	ALL RECORDS:C47([DiaLesions:44])
	SELECTION TO ARRAY:C260([DiaLesions:44]NomLesion:1;PUMLésions)
	SORT ARRAY:C229(PUMLésions;>)
	$Test:=Substring:C12([DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1;1;3)+"@"
	PUMLésions:=Find in array:C230(PUMLésions;$Test)
	VarLMdSDGAL:=[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1
	If ([DiaMotifSaisieDGAL:42]IntituleRegCECourt:2="")
		$Pos:=Position:C15(<>ZCR;[DiaMotifSaisieDGAL:42]RefRegEuropeenne:5)
		$Ligne:=Substring:C12([DiaMotifSaisieDGAL:42]RefRegEuropeenne:5;1;($Pos-1))
		[DiaMotifSaisieDGAL:42]IntituleRegCECourt:2:=Substring:C12($Ligne;54)
	End if 
	CaCGibier:=0
End if 

If (Form event code:C388=Sur validation:K2:3)
	  //Testons si on a changé l'intiulé du motif de saisie
	If (VarLMdSDGAL#[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1)
		  // Il faut le changer partout
		READ WRITE:C146(*)
		$Test:="@"+VarLMdSDGAL+"@"
		QUERY:C277([DiaLesions:44];[DiaLesions:44]MotifSaisieDGAL:15=$Test)
		APPLY TO SELECTION:C70([DiaLesions:44];[DiaLesions:44]MotifSaisieDGAL:15:=Replace string:C233([DiaLesions:44]MotifSaisieDGAL:15;VarLMdSDGAL;[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1))
		QUERY:C277([Diapositives:40];[Diapositives:40]MotifSaisieDGAL:23=VarLMdSDGAL)
		APPLY TO SELECTION:C70([Diapositives:40];[Diapositives:40]MotifSaisieDGAL:23:=[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1)
	End if 
End if 

