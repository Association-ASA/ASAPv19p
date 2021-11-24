//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_COLLECTION:C1488($result;$1)
C_OBJECT:C1216($line)
C_TEXT:C284($export)
ARRAY TEXT:C222($tabPropertyNames;0x0000)

$result:=New collection:C1472
$result:=$1.copy()

If ($result.length>0)
	
	OB GET PROPERTY NAMES:C1232($result[0];$tabPropertyNames)
	$size:=Size of array:C274($tabPropertyNames)
	
	$export:=""
	
	For ($a;1;$Size)
		$export:=$export+$tabPropertyNames{$a}+Choose:C955($a#$Size;Char:C90(Tab:K15:37);Char:C90(Carriage return:K15:38))
	End for 
	
	$sep:=Char:C90(Tab:K15:37)
	For each ($line;$result)
		For ($a;1;$size)
			If ($a=$size)
				$sep:=Char:C90(Carriage return:K15:38)
			Else 
				$sep:=Char:C90(Tab:K15:37)
			End if 
			$vType:=Value type:C1509($line[$tabPropertyNames{$a}])
			If ($vType=Is boolean:K8:9) | ($vType=Is longint:K8:6) | ($vType=Is date:K8:7) | ($vType=Is real:K8:4) | ($vType=Is text:K8:3) | ($vType=Is time:K8:8)
				$export:=$export+String:C10($line[$tabPropertyNames{$a}])+$sep
			Else 
				$export:=$export+""+$sep
			End if 
		End for 
	End for each 
	
	SET TEXT TO PASTEBOARD:C523($export)
End if 
