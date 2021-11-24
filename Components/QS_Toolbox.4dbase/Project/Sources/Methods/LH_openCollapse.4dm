//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
#DECLARE($l : Integer; $expand : Boolean)

var $asublist; $itemRef : Integer
var $itemText : Text
var $toExpand : Boolean

If ($expand)
	ARRAY LONGINT:C221($selects; 0x0000)
	$select:=Selected list items:C379($l; $selects; *)
	
	For ($i; 1; Count list items:C380($l; *))
		SELECT LIST ITEMS BY POSITION:C381($l; $i)
		GET LIST ITEM:C378($l; *; $itemRef; $itemText; $asublist; $toExpand)
		If ($toExpand=(Not:C34($expand)))
			SET LIST ITEM:C385($l; *; $itemText; $itemRef; $asublist; $expand)
		End if 
		
	End for 
	
	SELECT LIST ITEMS BY REFERENCE:C630($l; $select; $selects)
	
Else 
	
	If (Count parameters:C259=5)
		var $3; $4; $5 : Pointer
		
		$lists:=$3
		$sublists:=$4
		$labels:=$5
		
	Else 
		ARRAY LONGINT:C221($_lists; 0x0000)
		ARRAY LONGINT:C221($_sublists; 0x0000)
		ARRAY TEXT:C222($_labels; 0x0000)
		$lists:=->$_lists
		$sublists:=->$_sublists
		$labels:=->$_labels
		
	End if 
	
	For ($i; 1; Count list items:C380($l))
		GET LIST ITEM:C378($l; $i; $itemRef; $itemText; $asublist; $toExpand)
		If (Is a list:C621($asublist))
			LH_openCollapse($asublist; $expand; $lists; $sublists; $labels)
			
			If (Not:C34($expand)) & ($toExpand)
				APPEND TO ARRAY:C911($lists->; $itemRef)
				APPEND TO ARRAY:C911($sublists->; $asublist)
				APPEND TO ARRAY:C911($labels->; $itemText)
			End if 
		End if 
	End for 
	
	If (Count parameters:C259#5)
		For ($i; 1; Size of array:C274($_lists))
			$itemRef:=$_lists{$i}
			$asublist:=$_sublists{$i}
			$itemText:=$_labels{$i}
			SET LIST ITEM:C385($l; $itemRef; $itemText; $itemRef; $asublist; $expand)
		End for 
	End if 
	
End if 