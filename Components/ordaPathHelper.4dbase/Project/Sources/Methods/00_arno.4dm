//%attributes = {}

TRACE:C157

$f1:=Structure file:C489
$f2:=Structure file:C489(*)


If (False:C215)
	
	$c:=New collection:C1472()
	For ($i;0;20)
		$c.push($i)
	End for 
	$c.remove(1)
	$c.remove(1;1)
	$c.remove(1;2)
	$c.remove(10;9)
End if 

