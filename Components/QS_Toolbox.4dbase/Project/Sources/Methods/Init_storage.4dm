//%attributes = {"invisible":true,"preemptive":"capable"}

Use (Storage:C1525)
	Storage:C1525.QS_TBX_SHARED_DATA:=New shared object:C1526
	Storage:C1525.text:=New shared object:C1526
	Storage:C1525.windows:=New shared object:C1526
	Storage:C1525.commands4d:=New shared collection:C1527
	Storage:C1525.symbols_variable:=New shared collection:C1527
	Storage:C1525.allMethods:=New shared collection:C1527
	Storage:C1525.plugIn:=New shared collection:C1527
	Storage:C1525.componantsMethods:=New shared collection:C1527
	Storage:C1525.constants:=New shared collection:C1527
	Storage:C1525.objectType:=New shared collection:C1527
	Storage:C1525.structureTable:=New shared collection:C1527
	Storage:C1525.systemKeywords:=New shared collection:C1527
	Storage:C1525.debug:=New shared collection:C1527
	Storage:C1525.getCallChain:=New shared collection:C1527
	Storage:C1525.bdAnalysis:=New shared collection:C1527
End use 

If (Count parameters:C259=1)
	var $1 : Object
	signal_addResult($1; Current method name:C684)
End if 