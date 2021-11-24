//%attributes = {"publishedWeb":true,"lang":"fr"}
// DecrypteLeBlob
C_LONGINT:C283($Salé; $FT)
ZBlobVersVariable(->[Diapositives:40]BlobFleches:21; ->TbTb; ->TbLHT; ->TbTCa)

$FT:=Size of array:C274(TbTb)

For ($Salé; 1; 4)  // les 4  lignes concernent la lesion
	If (TbTb{$Salé}#"")
		VarUneFleche:=True:C214
	End if 
	If (TbLHT{$Salé}#"")
		VarUnLienHypertexte:=True:C214
	End if 
End for 