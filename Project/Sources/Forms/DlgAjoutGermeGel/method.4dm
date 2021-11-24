$evt:=Form event code:C388

If ($evt=On Load:K2:1)
	ARRAY LONGINT:C221($Tb; 0)
	VarNomGermeSchema:=""
	VarNomGermeCampagne:=""
	VarPetitNomWeb:=""
	VarNomTbParticipation:=""
	VarNomTbNbPotsSR:=""
	VarNomTbNbPotsAR:=""
	COPY ARRAY:C226(<>TbOrdreGermeCampagneGEL; $Tb)
	SORT ARRAY:C229($Tb; <)
	VarOrdreNouveauGerme:=((Num:C11($Tb{1})/10)+1)*10
End if 