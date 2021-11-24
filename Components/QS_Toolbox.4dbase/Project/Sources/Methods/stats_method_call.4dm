//%attributes = {"invisible":true,"preemptive":"capable"}
C_LONGINT:C283($1;$3)
C_TEXT:C284($2)

Case of 
	: ($3=1) | ($3=7) | ($3>=9)
		C_COLLECTION:C1488($temp)
		$temp:=New collection:C1472
		EXECUTE METHOD:C1007($2;$temp)
		
		CALL FORM:C1391($1;"stats_method";$temp;$3)
		
	: ($3=8)
		C_OBJECT:C1216($myObj)
		$myObj:=New object:C1471
		EXECUTE METHOD:C1007($2;$myObj)
		CALL FORM:C1391($1;"stats_method";$myObj;$3)
	Else 
		C_LONGINT:C283($result)
		$result:=0
		EXECUTE METHOD:C1007($2;$result)
		CALL FORM:C1391($1;"stats_method";$result;$3)
		
End case 

If (Count parameters:C259=4)
	C_OBJECT:C1216($4)
	signal_addResult ($4;Current method name:C684)
Else 
	KILL WORKER:C1390
End if 
