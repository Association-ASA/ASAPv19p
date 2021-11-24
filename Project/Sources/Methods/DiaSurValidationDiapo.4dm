//%attributes = {"publishedWeb":true,"lang":"fr"}
// SurValidationDiapo
If (NouvelleDiapo)
	INSERT IN ARRAY:C227(TbNumDiapoExistantes; Size of array:C274(TbNumDiapoExistantes)+1)
	TbNumDiapoExistantes{Size of array:C274(TbNumDiapoExistantes)}:=[Diapositives:40]NumOrdreDiapos:1
End if 
[Diapositives:40]NPC:14:=ZTableauVersTexte(->ZdDNLR)