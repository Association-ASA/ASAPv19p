//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
#DECLARE($myObj : Object; $window : Text)

ARRAY LONGINT:C221($TbWindows; 0x0000)

If (Storage:C1525.windows[$window]#Null:C1517)
	WINDOW LIST:C442($TbWindows)
	
	If (Storage:C1525.windows[$window]#0)
		$Win:=Storage:C1525.windows[$window]
	End if 
	
	If (Find in array:C230($TbWindows; $Win)>0)
		HIDE WINDOW:C436($Win)
		SHOW WINDOW:C435($Win)
		
	Else 
		
		If ($window="_webParseForm")
			$Win:=Open form window:C675($window; -500; -500)
			HIDE WINDOW:C436($Win)
		Else 
			$Win:=Open form window:C675($window; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
		End if 
		
		OB_windowNumberToStorage($window; $Win)
		DIALOG:C40($window; *)
		If (Count parameters:C259=3)
			C_TEXT:C284($3)
			CALL FORM:C1391($Win; $3)
		End if 
		
	End if 
	
Else 
	$Win:=Open form window:C675($window; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	OB_windowNumberToStorage($window; $Win)
	If (Count parameters:C259=3)
		C_TEXT:C284($3)
		CALL FORM:C1391($Win; $3)
	End if 
	DIALOG:C40($window; $myObj; *)
End if 