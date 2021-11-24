//%attributes = {"invisible":true,"preemptive":"capable"}
// ----------------------------------------------------
// $typeToAdd : variant
// $step : longInt
// ----------------------------------------------------
// Méthode : WKR_setCollToDiamond
// Description
//
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 22/05/20, 14:48:48
// Paramètres

#DECLARE($typeToAdd : Variant; $step : Integer)

var $method : Object
var $coll; $pos : Collection

// To secure the call
ON ERR CALL:C155("Base_NoError")

Case of 
	: (Value type:C1509($typeToAdd)=Is collection:K8:32)
		
		$coll:=$typeToAdd
		
		Case of 
			: ($step=1)
				QS_TBX_allMethods.combine($coll)
				
			: ($step=2)  // 4
				QS_TBX_allMethods.clear()
				QS_TBX_allMethods.combine($coll)
				
			: ($step=3)  //2
				QS_TBX_debug.combine($coll)
				
			: ($step=4)  //3
				QS_TBX_debug:=$coll.copy()
				
			: ($step=5)
				QS_TBX_symbol.combine($coll)
				
			: ($step=6)
				QS_TBX_symbol:=$coll.copy()
				
		End case 
		
		// ****************************
		
	: (Value type:C1509($typeToAdd)=Is object:K8:27)
		
		$method:=$typeToAdd
		Case of 
			: ($step=1)  // Parse code
				QS_TBX_parseCode.push($step)
				
			: ($step=5)
				$pos:=QS_TBX_allMethods.indices("name =:1"; $method.name)
				If ($pos.length>0)
					QS_TBX_allMethods[$pos[0]]:=$method
				End if 
		End case 
		
		// ****************************
		
	: (Value type:C1509($typeToAdd)=Is text:K8:3)
		
		Case of 
			: ($step=0)
				var QS_TBX_allMethods; QS_TBX_debug; QS_TBX_symbol; QS_TBX_parseCode : Collection
				QS_TBX_allMethods:=New collection:C1472
				QS_TBX_debug:=New collection:C1472
				QS_TBX_symbol:=New collection:C1472
				QS_TBX_parseCode:=New collection:C1472
				CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "(1) - Collection variables defined")
				
			: ($step=1)
				CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "(5) - Analysis data saving: Start")
				$index:=New object:C1471
				For each ($method; QS_TBX_allMethods)
					$index[$method.name]:=$method
				End for each 
				
				Use (Storage:C1525)
					Storage:C1525.allMethods:=New shared collection:C1527
					Storage:C1525.index:=New shared object:C1526
					Use (Storage:C1525.allMethods)
						OB_CopyToSharedCollection(QS_TBX_allMethods; Storage:C1525.allMethods)
					End use 
					Use (Storage:C1525.index)
						OB_CopyToSharedObject($index; Storage:C1525.index)
					End use 
				End use 
				
				CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "(5) - Analysis data saving: End")
				CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "(6) - Second analysis part: Start")
				CALL WORKER:C1389("QST_rebuildLH"; "COMMANDS_LH_create"; False:C215)  // not PREEMPTIVE with LIST commands
				CALL WORKER:C1389("QST_commandsUsed"; "COMMANDS_used"; False:C215)  // Update <>QST_allMethods
				CALL WORKER:C1389("QST_create4Djs"; "VCS_create4Djs")
				QS_TBX_allMethods.clear()
				
			: ($step=2)
				Use (Storage:C1525)
					Storage:C1525.debug:=New shared collection:C1527
					Use (Storage:C1525.debug)
						OB_CopyToSharedCollection(QS_TBX_debug; Storage:C1525.debug)
					End use 
				End use 
				QS_TBX_debug.clear()
				
			: ($step=3)
				
				Use (Storage:C1525)
					Storage:C1525.symbols_variable:=New shared collection:C1527
					Use (Storage:C1525.symbols_variable)
						OB_CopyToSharedCollection(QS_TBX_symbol; Storage:C1525.symbols_variable)
					End use 
				End use 
				QS_TBX_symbol.clear()
				
		End case 
		
End case 

If (Count parameters:C259=3)
	var $3 : Object
	$3.trigger()
End if 
