C_LONGINT:C283($L;VarNumSérie;$FT)
Case of 
	: (PUMAuteurAC<1)
		ALERT:C41("Merci de préciser l'auteur")
		
	: (<>PUMEspèce<1)
		ALERT:C41("Merci de préciser l'espèce")
		
	: (<>PUMOrgane<1)
		ALERT:C41("Merci de préciser l'organe")
		
	: (VarNomLésion="")
		ALERT:C41("Merci de préciser la lésion")
		
	Else 
		$FT:=Size of array:C274(TbNomFichier)
		READ WRITE:C146([DiaData:45])
		$Type:="AjoutDia"+(Num:C11(VarPOD=1)*"POD")+(Num:C11(PUMAuteurAC{PUMAuteurAC}="PRINTZ")*"G")
		QUERY:C277([DiaData:45];[DiaData:45]XType:5=$Type;*)
		QUERY:C277([DiaData:45]; & [DiaData:45]XTexte:7=CDCourant)
		If (Records in selection:C76([DiaData:45])=0)
			CREATE RECORD:C68([DiaData:45])
			[DiaData:45]XType:5:=$Type
		End if 
		OB SET:C1220([DiaData:45]XObjet:15;"Auteur";PUMAuteurAC{PUMAuteurAC}\
			;"Espèce";<>PUMEspèce{<>PUMEspèce}\
			;"Organe";<>PUMOrgane{<>PUMOrgane}\
			;"Lésion";VarNomLésion\
			;"Délai";VarDelaiAbattage\
			;"Commémoratifs";VarCommemoratif\
			;"Commentaires";VarCommentaires)
		[DiaData:45]XBool:9:=PbTechnique
		[DiaData:45]XTexte:7:=CDCourant
		[DiaData:45]XTexteSup:8:=VarComImage
		[DiaData:45]XAlpha:14:="A traiter"
		[DiaData:45]XEntier:2:=Size of array:C274(TbImagesAsaDia)
		[DiaData:45]XValeur:4:=VarNumSérie
		ARRAY TEXT:C222($TbCD;0)
		ZTexteVersTableau (CDCourant;->$TbCD;":")
		[DiaData:45]XNom:1:=$TbCD{Size of array:C274($TbCD)}
		SAVE RECORD:C53([DiaData:45])
		ZAmnistiePartielle (->[DiaData:45])
		QUERY:C277([DiaData:45];[DiaData:45]XType:5="AjoutDia")
		SELECTION TO ARRAY:C260([DiaData:45]XTexte:7;TbCheminsDiaFaites)
		TbCouleurAC{LigneClic}:=0x00FFAAAA
		$LigneClic:=LigneClic+1
		If ($LigneClic<=Size of array:C274(TbNomFichier))
			LigneClic:=$LigneClic
			LISTBOX SELECT ROW:C912(*;"ListBoxCDFichiers";LigneClic)
			DiaACClicLBCandidats 
		End if 
End case 