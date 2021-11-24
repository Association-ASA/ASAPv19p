Class constructor
	
	
Function menu($options : Collection)->$es : Object
	
	var $o : Object
	var $c : Collection
	var $VarChoixUtilisateur : Integer
	
	$c:=New collection:C1472
	For each ($o; $options)
		$c.push($o.titre)
	End for each 
	$VarChoixUtilisateur:=Pop up menu:C542($c.join(";"))
	
	If ($VarChoixUtilisateur>0)
		$o:=$options[$VarChoixUtilisateur-1]
		$isMethode:=Bool:C1537(OB Get:C1224($o; "methode"; Is text:K8:3)#"")
		
		If ($isMethode)
			$methode:=$o.methode
			If (OB Is defined:C1231($o; "param"))
				$param:=$o.param
				EXECUTE METHOD:C1007($methode; *; $param)
				
			Else 
				EXECUTE METHOD:C1007($methode)
			End if 
			
		Else 
			$action:=$o.action
			
			Case of 
					
				: ($action="all")
					Form:C1466.precedent:=cs:C1710.interface.new()._precedent()
					$es:=Form:C1466.esInitiale
					
				: ($action="selections")
					Form:C1466.precedent:=cs:C1710.interface.new()._precedent()
					var $es; $entity : Object
					$es:=ds:C1482[Form:C1466.table].newSelection().copy()
					
					For each ($e; Form:C1466.selection)
						$entity:=ds:C1482[Form:C1466.table].get($e.entity.UUID)
						$es.add($entity)
					End for each 
					
				: ($action="lesAutres")
					Form:C1466.precedent:=cs:C1710.interface.new()._precedent()
					var $es; $entity : Object
					
					$es:=ds:C1482[Form:C1466.table].newSelection().copy()
					$es2:=ds:C1482[Form:C1466.table].newSelection().copy()
					
					For each ($e; Form:C1466.esColl)
						$entity:=ds:C1482[Form:C1466.table].get($e.entity.UUID)
						$es.add($entity)
					End for each 
					
					For each ($e; Form:C1466.selection)
						$entity:=ds:C1482[Form:C1466.table].get($e.entity.UUID)
						$es2.add($entity)
					End for each 
					$es:=$es.minus($es2)
					
					
				: ($action="etendre")
/* similaire à 'LesAutres' mais avec :
$es:=$es.or($es2)
*/
					Form:C1466.precedent:=cs:C1710.interface.new()._precedent()
					
					
				: ($action="cherche")
					Form:C1466.precedent:=cs:C1710.interface.new()._precedent()
					
					
				: ($action="oups")
					$es:=Form:C1466.precedent
					
			End case 
			// Form.es:=Form.es
			
		End if 
		
	End if 
	
	
Function _precedent()->$avant : Object
	
	var $avant; $entity : Object
	$avant:=ds:C1482[Form:C1466.table].newSelection().copy()
	
	For each ($e; Form:C1466.esColl)
		$entity:=ds:C1482[Form:C1466.table].get($e.entity.UUID)
		$avant.add($entity)
	End for each 
	