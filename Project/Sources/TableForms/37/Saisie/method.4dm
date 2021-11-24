$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		LIST TO ARRAY:C288("Espèce";PUMEspèce)
		LIST TO ARRAY:C288("Organe";PUMOrgane)
		QUERY:C277([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]TypeListe:8="A")
		SELECTION TO ARRAY:C260([DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1;PUMSDGAL)
End case 