Class constructor
	
	
	
Function extractionProp($es : Object; $prop : Text)->$result : Collection
	// Extrait les propriétés de $dataClass[$champ] de toutes les entités
	// ex: XData.XObjet
	
	var $c : Collection
	var $e : Variant
	
	$result:=New collection:C1472
	
	For each ($e; $es)
		If ($e[$prop]#Null:C1517)
			$ob:=$e[$prop]
			$c:=OB Keys:C1719($ob)
			For each ($t; $c)
				$result.push($t)
			End for each 
			
		End if 
	End for each 
	
	$result:=$result.distinct()
	