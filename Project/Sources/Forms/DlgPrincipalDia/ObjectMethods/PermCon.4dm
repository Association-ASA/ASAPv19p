$evt:=Form event code:C388
Case of 
	: ($Evt=Sur chargement:K2:1)
		<>PermConcepteur:=(Current user:C182="Concepteur")
		PermCon:=Num:C11(<>Boss)
		<>PermLecteur:=<>PermConcepteur
		
		
	: ($Evt=Sur clic:K2:4)
		ZXCarLaProc:="ChangeConcepteur "
		CANCEL:C270
		//ZZZDéplombe 
		
End case 
