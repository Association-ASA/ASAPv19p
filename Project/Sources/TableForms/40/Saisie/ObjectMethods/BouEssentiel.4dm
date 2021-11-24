FORM GOTO PAGE:C247(2)
JAiGrandit:=False:C215
If (PageImage=2)
	$CDNomImage:=Get 4D folder:C485(Dossier base:K5:14)+"dossier Photos"+Séparateur dossier:K24:12+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
	READ PICTURE FILE:C678($CDNomImage;VarImage)
	OBJECT GET COORDINATES:C663(VarImage;PG;PH;PD;PB)
	QUERY:C277([DiaData:45];[DiaData:45]XNom:1=String:C10([Diapositives:40]NumOrdreDiapos:1);*)
	QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="NPC")
	ARRAY TEXT:C222(TbNumDiaNPC;0)
	If (Records in selection:C76([DiaData:45])>0)
		ZTexteVersTableau ([DiaData:45]XTexteSup:8;->TbNumDiaNPC)
	End if 
	LISTBOX SELECT ROW:C912(*;"ListBoxPhotosNPC";0;lk supprimer de sélection:K53:3)
	VarImageNPC:=[DiaData:45]XImage:6
	  //Sinon 
	  //OBJET LIRE COORDONNÉES(VarImage2;PG;PH;PD;PB)
End if 