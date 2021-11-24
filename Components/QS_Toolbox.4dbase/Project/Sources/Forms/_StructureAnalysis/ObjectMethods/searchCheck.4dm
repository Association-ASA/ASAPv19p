C_COLLECTION:C1488($col)
$col:=New collection:C1472

$col.push("Start/Stop Record Events")
$col.push("-")
$col.push("Update deprecated commands")

$referenceLigne:=Pop up menu:C542($col.join(";"))

Case of 
		
	: ($referenceLigne=1)
		TOOLS_RecordEvents 
		
	: ($referenceLigne=3)
		TOOLS_ReadOnly ("SUPPORT_CorrectDeprecated")
		
End case 