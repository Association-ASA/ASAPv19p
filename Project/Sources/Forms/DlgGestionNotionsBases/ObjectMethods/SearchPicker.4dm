//Searchpicker sample code

Case of 
		
	: (Form event code:C388=Sur chargement:K2:1)
		
		// Init the var itself
		// this can be done anywhere else in your code
		C_TEXT:C284(vSearch)
		
		// the let's customise the SearchPicker (if needed)
		
		C_BOOLEAN:C305($Customise)
		$Customise:=False:C215
		
		C_TEXT:C284($ObjectName)
		$ObjectName:=OBJECT Get name:C1087(Objet courant:K67:2)
		
		// The exemple below shows how to set a label (ex : "name") inside the search zone
		
		If ($Customise)
			
			SearchPicker SET HELP TEXT($ObjectName; "Name")
			
		End if 
		
	: (Form event code:C388=Sur données modifiées:K2:15)
		$test:="@"+vSearch+"@"
		If (PUMListe=1)  // DGAL
			QUERY:C277([DiaMotifSaisieDGAL:42]; [DiaMotifSaisieDGAL:42]TypeListe:8="A"; *)
			QUERY:C277([DiaMotifSaisieDGAL:42];  & [DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1=$test)
		Else   // ENV
			QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=$test)
		End if 
		DiaWebTextesListesLesions(True:C214)
End case 
