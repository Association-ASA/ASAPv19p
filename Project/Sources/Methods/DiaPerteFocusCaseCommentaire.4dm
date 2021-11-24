//%attributes = {"lang":"fr"}
//Ad2PerteFocusCaseCommentaire
C_TEXT:C284($NV)
C_LONGINT:C283($NT; $NC)
C_POINTER:C301(PtChampCourant; $1)
PtChampCourant:=$1

RESOLVE POINTER:C394(PtChampCourant; $NV; $NT; $NC)
$Salé:=Num:C11(Substring:C12($NV; 5; 1))
$NomFleche:=String:C10($Salé)+"1"
$Pt:=Get pointer:C304("VarC"+$NomFleche)
$PtA:=Get pointer:C304("VarC"+$NomFleche+"A")
$Val:=$Pt->+(Num:C11($PtA->#"")*("£"+$PtA->))
$FinLigneTableau:=TbTb{$Salé}
$Pos1:=Position:C15(" "; $FinLigneTableau)
$FinLigneTableau:=Substring:C12($FinLigneTableau; ($Pos1+1))
$Pos2:=Position:C15(" "; $FinLigneTableau)
$FinLigneTableau:=Substring:C12($FinLigneTableau; ($Pos2+1))
$Pos3:=Position:C15(" "; $FinLigneTableau)
$FinLigneTableau:=Substring:C12($FinLigneTableau; $Pos3)
If (Length:C16($Val)>0)
	TbTb{$Salé}:=Substring:C12(TbTb{$Salé}; 1; ($Pos1+$Pos2+$Pos3))+$Val
Else 
	TbTb{$Salé}:=""
End if 

ZVariableVersBlob(->[Diapositives:40]BlobFleches:21; ->TbTb; ->TbLHT; ->TbTCa)
[Diapositives:40]DiapoCommentaire:26:=(BLOB size:C605([Diapositives:40]BlobFleches:21)>0)
SAVE RECORD:C53([Diapositives:40])