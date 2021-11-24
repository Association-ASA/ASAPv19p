  //  MF de "DlgPrincipal"

If (Form event code:C388=Sur chargement:K2:1)
	If (DuPrem)  // qui se passe apres avoir démarré le programme
		PermEcran:=1+Num:C11(<>DémarrageFormation)
		DuPrem:=False:C215
		VarDMF:=Num:C11(<>DémarrageFormation)
		RadioF:=Num:C11(<>DémarrageFormation)
		RadioG:=0
		RadioU:=1-RadioF
		PaysGB:=0
		PaysFrance:=1
	End if 
	
	Case of 
		: (PermEcran=1)
			RadioU:=1
			
		: (PermEcran=2)
			RadioF:=1
			
			  //: (PermEcran=3)
			  //RadioG:=1
	End case 
	
	FORM GOTO PAGE:C247(PermEcran)
	OBJECT SET VISIBLE:C603(SpeBouChan;True:C214)
	OBJECT SET VISIBLE:C603(<>ZQuiVala;True:C214)
	OBJECT SET VISIBLE:C603(PermCon;<>PermConcepteur)
	OBJECT SET VISIBLE:C603(*;"cgm@";<>PermConcepteur)
	OBJECT SET VISIBLE:C603(*;"z@";<>Boss)
	
	  // Ad3TraducFabriqueTb 
	
	LangueEnCours:="F"
	PaysFrance:=1
	PaysGB:=0
	
	  // Débuggage
	QUERY:C277([DiaData:45];[DiaData:45]XType:5="debug";*)
	QUERY:C277([DiaData:45]; & [DiaData:45]XNom:1="débuggage")
	If (Records in selection:C76([DiaData:45])=0)
		CREATE RECORD:C68([DiaData:45])
		[DiaData:45]XType:5:="debug"
		[DiaData:45]XNom:1:="débuggage"
		SAVE RECORD:C53([DiaData:45])
	End if 
	If ([DiaData:45]XBool:9)
		OBJECT SET TITLE:C194(*;"BouAsaDiaDebug";"Débuggage arrêté")
	Else 
		OBJECT SET TITLE:C194(*;"BouAsaDiaDebug";"Débuggage lancé")
	End if 
End if 