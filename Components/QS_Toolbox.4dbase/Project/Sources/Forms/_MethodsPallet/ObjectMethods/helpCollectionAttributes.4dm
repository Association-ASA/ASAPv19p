C_COLLECTION:C1488($col)
C_LONGINT:C283($referenceLigne)

$col:=New collection:C1472("path";"name";"code";"lastUpdate";"Complexity";"isThread")
$referenceLigne:=Pop up menu:C542($col.join(";"))
If ($referenceLigne>0)
	Form:C1466.txtQuery:=Form:C1466.txtQuery+" "+$col[$referenceLigne-1]+"='"
	GOTO OBJECT:C206(*;"TxtQuery")
End if 