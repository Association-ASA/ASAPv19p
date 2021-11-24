//%attributes = {"invisible":true,"shared":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_COLLECTION:C1488($coll; $argus)
C_OBJECT:C1216($cc; $commands; $path)
ARRAY OBJECT:C1221($obj; 0x0000)
C_TEXT:C284($theme; $argument; $command)
C_LONGINT:C283($plugNum; $command_id)

$coll:=New collection:C1472
$path:=Folder:C1567(fk database folder:K87:14; *).folder("Plugins")

If ($path.isFolder=True:C214)
	C_COLLECTION:C1488($allFolders)
	$allFolders:=$path.folders()
	
	For each ($plugin; $allFolders)
		$plugName:=$plugin.fullName
		$resource:=PLUGIN_getResource($plugin)
		$commands:=PLUGIN_getCommands($resource)
		
		CLEAR VARIABLE:C89($obj)
		OB GET ARRAY:C1229($commands; "commands"; $obj)
		
		If (Size of array:C274($obj)>0)
			
			$plugName:=$commands.name
			$plugNum:=$commands.id
			
			For ($i; 1; Size of array:C274($obj))
				
				$cc:=$obj{$i}
				$theme:=$cc.theme
				$command:=$cc.command
				$command_id:=$cc.command_id
				$argus:=$cc.arguments
				$argument:=$argus.extract("argument_type").join(";")
				
				If ($theme="n/a")
					Case of 
						: ($plugNum=15000)
							If (Position:C15("_"; $command)>0)
								$theme:=Substring:C12($command; 1; Position:C15("_"; $command)-1)
							Else 
								$theme:=$plugName
							End if 
					End case 
				End if 
				
				$coll.push(New shared object:C1526("pluginName"; $plugName; "pluginNum"; $plugNum; "id"; \
					$command_id; "theme"; $theme; "name"; $command; "token"; ":P"+String:C10($plugNum)+":"+String:C10($command_id); "syntax"; $argument))
				
			End for 
		End if 
	End for each 
End if 

$coll:=$coll.distinct().orderBy("pluginName asc, name asc")  // .distinct() returns a single collection

Use (Storage:C1525)
	Use (Storage:C1525.plugIn)
		OB_CopyToSharedCollection($coll; Storage:C1525.plugIn)
	End use 
End use 

If (Count parameters:C259=1)
	C_OBJECT:C1216($1)
	signal_addResult($1; Current method name:C684)
End if 