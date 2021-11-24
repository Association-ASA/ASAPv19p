//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_LONGINT:C283($1;$minor)  // indice of R version required

$versionR:=Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DVersionR)
$host:=Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_hostInProjectMode)
$minor:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DMineur

$0:=False:C215
  //If (($versionR) & (Not($host))) | (($versionR & $host) & (Num($minor)>=$1))
If ($versionR & $host) & (Num:C11($minor)>=$1)
	$0:=True:C214
End if 