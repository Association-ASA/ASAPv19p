//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_COLLECTION:C1488($1; $methodsToUpdate)
$methodsToUpdate:=$1

C_OBJECT:C1216($param; $ent; $2)
$param:=$2

For each ($ent; $methodsToUpdate)
	Use ($ent)
		
		If ($param.att1#2)
			$ent.attributes.invisible:=($param.att1=1)
		End if 
		
		If ($param.att2#2)
			$ent.attributes.publishedWeb:=($param.att2=1)
		End if 
		
		If ($param.att3#2)
			$ent.attributes.publishedSoap:=($param.att3=1)
		End if 
		
		If ($param.att4#2)
			$ent.attributes.publishedWsdl:=($param.att4=1)
		End if 
		
		If ($param.att5#2)
			$ent.attributes.shared:=($param.att5=1)
		End if 
		
		If ($param.att6#2)
			$ent.attributes.publishedSql:=($param.att6=1)
		End if 
		
		If ($param.att7#2)
			$ent.attributes.executedOnServer:=($param.att7=1)
		End if 
	End use 
End for each 

CALL WORKER:C1389("QST_job"; "MM_saveMethodsAttributes"; $methodsToUpdate)
$methodsToUpdate:=$methodsToUpdate