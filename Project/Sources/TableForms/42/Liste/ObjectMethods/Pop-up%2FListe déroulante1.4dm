$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ARRAY TEXT:C222(PUMTypeMotif; 2)
		PUMTypeMotif{1}:="Liste A : Motifs liés à des lésions"
		PUMTypeMotif{2}:="Liste B : Motifs sans lien avec des lésions"
		PUMTypeMotif:=1
		QUERY:C277([DiaMotifSaisieDGAL:42]; [DiaMotifSaisieDGAL:42]TypeListe:8="A")
		ORDER BY:C49([DiaMotifSaisieDGAL:42]; [DiaMotifSaisieDGAL:42]Ordre:10; >)
		DiaFenetreActualiseTitre
		
	: (\
		$evt=\
		Sur clic:K2:4)\
		
		$L:=(Num:C11(PUMTypeMotif=1)*"A")+(Num:C11(PUMTypeMotif=2)*"B")
		If ($L="B")
			ALERT:C41("Désolé, la liste B est en cours de révision")
		Else 
			QUERY:C277([DiaMotifSaisieDGAL:42]; [DiaMotifSaisieDGAL:42]TypeListe:8=$L)
			ORDER BY:C49([DiaMotifSaisieDGAL:42]; [DiaMotifSaisieDGAL:42]Ordre:10; >)
			DiaFenetreActualiseTitre
		End if 
End case 
