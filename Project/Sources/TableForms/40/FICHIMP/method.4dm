$evt:=Form event code:C388
Case of 
	: ($evt=Sur impression corps:K2:18)
		$CDNomImage:=<>PermCheDossierAsaDiaWeb+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
		READ PICTURE FILE:C678($CDNomImage;Image)
		VarTriplette:=DiaAfficheTripletteSlash 
		QUERY:C277([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1=[Diapositives:40]MotifSaisieDGAL:23)
		VarReg:="Règlement (CE) n° 854/2004 du 29 avril 2004 "+[DiaMotifSaisieDGAL:42]IntituleRegCECourt:2
End case 