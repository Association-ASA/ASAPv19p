C_LONGINT:C283($evt)
$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		
		Form:C1466.usedCommand:=New collection:C1472(New object:C1471("command";"Count in progress...";"count";".?."))
		floatWindow_launch 
		
		Form:C1466.startUp:=Storage:C1525.QS_TBX_SHARED_DATA.excutionTime
		Form:C1466.method:=New object:C1471
		Form:C1466.prop:=New collection:C1472
		Form:C1466.fields:=New collection:C1472
		Form:C1466.indexDescription:=New collection:C1472
		Form:C1466.missingForeignIdxDescription:=New collection:C1472
		Form:C1466.getForeignKetClusterErr:=New collection:C1472
		Form:C1466.getUniquenessErr:=New collection:C1472
		Form:C1466.getCompositeIndex:=New collection:C1472
		Form:C1466.method.projectMethods:=0
		Form:C1466.method.methods:=0
		Form:C1466.method.code:=0
		Form:C1466.method.comments:=0
		Form:C1466.method.empties:=0
		Form:C1466.method.total:=0
		Form:C1466.indexes:=0
		Form:C1466.missingForeignIndex:=0
		Form:C1466.missingKeyIndex:=0
		Form:C1466.relations:=0
		Form:C1466.schemas:=0
		Form:C1466.tableDescription:=New collection:C1472
		
		Form:C1466.table:=New object:C1471
		Form:C1466.table.maxFieldsInTable:="-"
		Form:C1466.table.maxField:=0
		
		SET TIMER:C645(1)
		
	: ($evt=On Timer:K2:25)
		SET TIMER:C645(0)
		
		  // Immediate answers
		C_COLLECTION:C1488($data)
		C_OBJECT:C1216($o)
		
		$data:=Storage:C1525.allMethods
		Form:C1466.method.projectMethods:=$data.query("path =:1";"Path project method").length
		Form:C1466.method.methods:=$data.length-Form:C1466.method.projectMethods
		Form:C1466.method.code:=$data.sum("nbLines")
		Form:C1466.method.comments:=$data.sum("nbComment")
		Form:C1466.method.empties:=$data.sum("nbEmpty")
		Form:C1466.method.total:=Form:C1466.method.empties+Form:C1466.method.comments+Form:C1466.method.code
		
		$toExecute:=New collection:C1472
		$toExecute.push(New object:C1471("name";"stats_parseCommand";"level";1))
		$toExecute.push(New object:C1471("name";"stats_countIndexes";"level";2))
		$toExecute.push(New object:C1471("name";"stats_missingForeignIndex";"level";3))
		$toExecute.push(New object:C1471("name";"stats_missingKeyIndex";"level";4))
		$toExecute.push(New object:C1471("name";"stats_relations";"level";5))
		$toExecute.push(New object:C1471("name";"stats_schemas";"level";6))
		$toExecute.push(New object:C1471("name";"stats_parseMethodsAttributes";"level";7))
		  //$toExecute.push(New object("name";"stats_tablesInformation";"level";8))
		  //$toExecute.push(New object("name";"stats_getFieldStat";"level";9))  // could be preemptif
		  //$toExecute.push(New object("name";"stats_getTableStats";"level";10))  // could be preemptif
		  //$toExecute.push(New object("name";"stats_getFieldIndex";"level";11))  // could be preemptif
		  //$toExecute.push(New object("name";"stats_getMissingForeignIndex";"level";12))
		  //$toExecute.push(New object("name";"stats_getForeignKeyClusterErr";"level";13))
		  //$toExecute.push(New object("name";"stats_getUniquenessErr";"level";14))
		  //$toExecute.push(New object("name";"stats_getCompositeIndex";"level";15))
		
		$signal:=New signal:C1641
		signal_setNew ($signal;1)
		
		For each ($o;$toExecute)
			Case of 
				: ($o.level=1)
					  //CALL FORM(Current form window;"stats_method_call";$o.name;$o.level)
					CALL WORKER:C1389("QST_stats_method_"+String:C10($o.level);"stats_method_call";Current form window:C827;$o.name;$o.level;$signal)
				Else 
					CALL WORKER:C1389("QST_stats_method_"+String:C10($o.level);"stats_method_call";Current form window:C827;$o.name;$o.level)
			End case 
		End for each 
		
		  //Form.indexes:=stats_countIndexes   // Quick
		Form:C1466.missingForeignIndex:=stats_missingForeignIndex   // Quick
		  //Form.missingKeyIndex:=stats_missingKeyIndex   // Quick 
		  //Form.relations:=stats_relations 
		  //Form.schemas:=stats_schemas 
		  //Form.prop:=stats_parseMethodsAttributes   // Quick
		
		  //Form.missingForeignIdxDescription:=stats_getMissingForeignIndex 
		Form:C1466.getCompositeIndex:=stats_getCompositeIndex 
		Form:C1466.getUniquenessErr:=stats_getUniquenessErr 
		Form:C1466.getForeignKetClusterErr:=stats_getForeignKeyClusterErr 
		Form:C1466.indexDescription:=stats_getFieldIndex 
		
		Form:C1466.table:=stats_tablesInformation 
		Form:C1466.fields:=stats_getFieldStat 
		Form:C1466.tableDescription:=stats_getTableStats 
		$signal.wait()
		
		$signal:=New signal:C1641
		signal_setNew ($signal;1)
		CALL WORKER:C1389("QST_debug";"floatWindow_save";$signal)
		$signal.wait()
		
		CALL WORKER:C1389("QST_debug";"floatWindow_close")
		
	: ($evt=On Close Box:K2:21)
		CANCEL:C270
		
End case 
