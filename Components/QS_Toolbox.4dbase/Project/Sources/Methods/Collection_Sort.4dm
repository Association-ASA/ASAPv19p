//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // Collections_Sort(Object)
  //By: Tony Ringsmuth 06/10/20, 17:26:46

  //FUNCTION: 
  // Like 4D's "MULTI SORT ARRAY", but for collections.
  //--------------------------------------------------------------------------------
  //PARAMETERS
  //$1: Object: propties:
  //      collectionsOb:  an object of collections to be ordered
  //      criteria: the ordering criteria:  see https://doc.4d.com/4Dv18/4D/18/collectionorderBy.305-4505869.en.html
  //         criteria Example: ("Last_Name, First_Name") or ("Last_Name desc, First_Name asc")

  //--------------------------------------------------------------------------------
  //REVISION HISTORY
  //06/10/20: New

  //C_OBJECT($Es)
  //$Es:=ds.Person.query("ID < 100")

  //C_COLLECTION($LN_c;$FN_c;$ID_c)
  //$LN_c:=$Es.Last_Name
  //$FN_c:=$Es.First_Name
  //$ID_c:=$Es.ID

  //$ResEnt_c:=New collection  //This is just to show that we could also "bring along for the ride" collections of any content.
  //For ($ii;1;$Es.length)
  //$ResEnt_c[$ii-1]:=$Es[$ii-1]
  //End for 

  //$Cols_ob:=New object(\
"Last_Name";$LN_c\
;"First_Name";$FN_c\
;"ID";$ID_c\
;"SourceEntity";$ResEnt_c\)

  //Collection_Sort(New object("collectionsOb";$Cols_ob;"criteria";"Last_Name asc, First_Name"))


  //--------------------------------------------------------------------------------

C_OBJECT:C1216($1)

C_OBJECT:C1216($Collections_ob)
$Collections_ob:=$1.collectionsOb  //a collection: the list of collections

  //$SuperCol will be one collection, with the same number of rows as the many collections
  //  where each row will be an object containing properties: that are from the table of collections
C_COLLECTION:C1488($SuperCol)
$SuperCol:=New collection:C1472

ARRAY TEXT:C222($aPN;0)
OB GET PROPERTY NAMES:C1232($Collections_ob;$aPN)

C_LONGINT:C283($MaxLen_i;$Len_i;$ii;$Row_i)
$MaxLen_i:=-1
For ($ii;1;Size of array:C274($aPN))
	If (Value type:C1509($Collections_ob[$aPN{$ii}])=Is collection:K8:32)
		$Len_i:=$Collections_ob[$aPN{$ii}].length
		If ($Len_i>$MaxLen_i)
			$MaxLen_i:=$Len_i
		End if 
	End if 
End for 

If ($MaxLen_i>-1)
	For ($Row_i;1;$MaxLen_i)
		$SuperCol[$Row_i-1]:=New object:C1471
	End for 
	
	C_TEXT:C284($PN_t)
	C_COLLECTION:C1488($Col_c)
	
	For ($ii;1;Size of array:C274($aPN))
		$PN_t:=$aPN{$ii}
		If (Value type:C1509($Collections_ob[$PN_t])=Is collection:K8:32)
			$Col_c:=$Collections_ob[$PN_t]
			For ($Row_i;1;$Col_c.length)
				$SuperCol[$Row_i-1][$PN_t]:=$Col_c[$Row_i-1]
			End for 
		End if 
	End for 
	
	$SuperCol:=$SuperCol.orderBy($1.criteria)
	
	  // Our "super collection" is now sorted: 
	  //  put it's items back to the original collections in the new order
	For ($ii;1;Size of array:C274($aPN))
		$PN_t:=$aPN{$ii}
		If (Value type:C1509($Collections_ob[$PN_t])=Is collection:K8:32)
			$Col_c:=$Collections_ob[$PN_t]
			For ($Row_i;1;$Col_c.length)
				$Col_c[$Row_i-1]:=$SuperCol[$Row_i-1][$PN_t]
			End for 
		End if 
	End for 
	
End if 