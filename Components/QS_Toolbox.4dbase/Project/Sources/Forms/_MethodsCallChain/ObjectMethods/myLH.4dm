  // Depending of the version, analyse is not made by the same way

ARRAY TEXT:C222($atKeys;0)
ARRAY TEXT:C222($atValues;0)
C_LONGINT:C283($key;$key2)

GET LIST ITEM:C378(*;"myLH";*;$refItem;$textItem;$subList;$isOpen)  // Get the refItem of the selected one
GET LIST ITEM PARAMETER ARRAYS:C1195(*;"myLH";*;$atKeys;$atValues)  // get parameter arrays for the selected item
$key:=Find in array:C230($atKeys;"type")
$key2:=Find in array:C230($atKeys;"path")

If ($key>0)
	If ($key2>0)
		Form:C1466.name:=$atValues{$key2}
	End if 
End if 