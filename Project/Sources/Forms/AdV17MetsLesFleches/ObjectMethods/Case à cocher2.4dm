$NomFleche:=String:C10(VarImageFleche+1)+"1"+(Num:C11(VarImageVerticale)*"V")
$Pt:=Get pointer:C304("VarC"+$NomFleche)
OBJECT SET ENTERABLE:C238($Pt->;(CaseSaisie=1))
$Pt2:=Get pointer:C304("VarC"+$NomFleche+"V")
OBJECT SET ENTERABLE:C238($Pt2->;(CaseSaisie=1))