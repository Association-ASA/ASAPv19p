//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_TEXT:C284($1;$0)
C_LONGINT:C283($viLen;$viPos;$viChar;$viDirSymbol)

$viDirSymbol:=Character code:C91(Folder separator:K24:12)
$viLen:=Length:C16($1)
$viPos:=0

For ($viChar;$viLen;1;-1)
	If (Character code:C91($1[[$viChar]])=$viDirSymbol)
		$viPos:=$viChar
		$viChar:=0
	End if 
End for 

If ($viPos>0)
	$0:=Substring:C12($1;1;$viPos)
Else 
	$0:=$1
End if 
