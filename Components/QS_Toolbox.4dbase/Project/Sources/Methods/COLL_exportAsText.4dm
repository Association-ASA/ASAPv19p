//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------------------------
// Name: COLL_exportAsText
// Description: Method will take a collection and return the contents as
// a text separated by lines.
//
// Parameters:
// $1 (POINTER) - Pointer to a collection
// Output:
// $0 (TEXT) - TEXT
// E.g. [0]:123
// [1]:false
// [2]:test
// [3]:{"prop":"value"}
// ----------------------------------------------------------------------
// https://kb.4d.com/assetid=77947

C_POINTER:C301($1; $col)
C_TEXT:C284($0; $colText)
C_LONGINT:C283($i)
C_COLLECTION:C1488($temp)

If (Count parameters:C259=1)
	$col:=$1
	$return:=Char:C90(13)+Char:C90(10)
	$tab:=Char:C90(Tab:K15:37)
	$temp:=New collection:C1472
	
	ARRAY TEXT:C222($tabProperties; 0)
	ARRAY LONGINT:C221($tabTypes; 0)
	
	For ($i; 0; $col->length-1)
		If (Value type:C1509($col->[$i])=Is object:K8:27)
			CLEAR VARIABLE:C89($tabProperties)
			CLEAR VARIABLE:C89($tabTypes)
			OB GET PROPERTY NAMES:C1232($col->[$i]; $tabProperties; $tabTypes)
			
			$colText:=$colText+"["+String:C10($i)+"]: "
			
			For ($j; 1; Size of array:C274($tabProperties))
				$colText:=$colText+$tabProperties{$j}+": "
				Case of 
					: (Value type:C1509($col->[$i][$tabProperties{$j}])=Is object:K8:27)
						$colText:=$colText+JSON Stringify:C1217($col->[$i][$tabProperties{$j}])+$tab
						
					: (Value type:C1509($col->[$i][$tabProperties{$j}])=Is collection:K8:32)
						If (OB Is empty:C1297($col->[$i][$tabProperties{$j}]))
							$temp:=$col->[$i][$tabProperties{$j}]
							$colText:=$colText+COLL_exportAsText(->$temp)+$tab
						Else 
							$colText:=$colText+$tab
						End if 
						
					Else 
						$colText:=$colText+$tabProperties{$j}+": "+String:C10(OB Get:C1224($col->[$i]; $tabProperties{$j}))+$tab
				End case 
				
			End for 
			
			// $colText:=$colText+"["+String($i)+"]:"+JSON Stringify($col->[$i])+$return
		Else 
			$colText:=$colText+"["+String:C10($i)+"]:"+String:C10($col->[$i])
			$colText:=$colText+$return
			
		End if 
	End for 
End if 

$0:=$colText