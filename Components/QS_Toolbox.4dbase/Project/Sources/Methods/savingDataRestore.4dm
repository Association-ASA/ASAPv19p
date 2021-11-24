//%attributes = {"invisible":true}
#DECLARE($options : Object; $blob : Blob)

If (BLOB size:C605($blob)>0)
	var $lastUpdate : Text
	var $commands; $data : Collection
	var $savedDate : Date
	var $calleesCallers : Boolean
	var $index; $SharedData : Object
	
	$data:=New collection:C1472
	$commands:=New collection:C1472
	$index:=New object:C1471
	$calleesCallers:=False:C215
	
	$vlOffset:=0
	
	BLOB TO VARIABLE:C533($blob; $lastUpdate; $vlOffset)
	BLOB TO VARIABLE:C533($blob; $data; $vlOffset)  // The shared collection become a single collection
	BLOB TO VARIABLE:C533($blob; $commands; $vlOffset)  // The shared collection become a single collection
	BLOB TO VARIABLE:C533($blob; $calleesCallers; $vlOffset)  // The shared collection become a single collection
	BLOB TO VARIABLE:C533($blob; $index; $vlOffset)  // The shared collection become a single collection
	
	$SharedData:=Storage:C1525.QS_TBX_SHARED_DATA
	
	Use (Storage:C1525)
		Storage:C1525.allMethods:=New shared collection:C1527
		Use (Storage:C1525.allMethods)
			OB_CopyToSharedCollection($data; Storage:C1525.allMethods)
		End use 
		
		Storage:C1525.commands4d:=New shared collection:C1527
		Use (Storage:C1525.commands4d)
			OB_CopyToSharedCollection($commands; Storage:C1525.commands4d)
		End use 
		
		Storage:C1525.index:=New shared object:C1526
		Use (Storage:C1525.index)
			OB_CopyToSharedObject($index; Storage:C1525.index)
		End use 
		
		Use ($SharedData)
			$SharedData.calleesCallersDone:=Bool:C1537($calleesCallers)
		End use 
	End use 
	
Else 
	$lastUpdate:="Never executed"
End if 
STO_textToStorage("update"; $options.lastUpdate)
