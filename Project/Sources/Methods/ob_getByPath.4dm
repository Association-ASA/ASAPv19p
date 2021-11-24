//%attributes = {}
//%attributes = {}
/*  OB_get_byPath (object; xPath) -> value
$1: object or entity
$2: dotted notation path to a property
$0: value or Undefined
 Created by: Kirk as KBrooks, Created: 05/13/21, 16:15:53
 ------------------
Purpose: Supports getting values from a string path. For an entity this
can also be a path along a relation as long as it's a many to one

COLLECTIONS
3 syntax for collections:
 collection                            the collection is returned
 collection[n]                         n is the index. Returns null if invalid index
 collection[<property> = '<criteria>'] performs a simple query on <property> = criteria

The query returns only the first element found or null.

*/

#DECLARE($object : Object; $xPath : Text)->$value : Variant

var $path_c : Collection
var $property_t; $queryStr : Text
var $done : Boolean
var $i; $valueType : Integer
ARRAY LONGINT:C221($aLen; 0)
ARRAY LONGINT:C221($aPos; 0)

$path_c:=Split string:C1554($2; "."; sk ignore empty strings:K86:1+sk trim spaces:K86:2)

If ($path_c.length>0)
	$value:=$object
	
	For each ($property_t; $path_c) While ((Value type:C1509($value)#Is undefined:K8:13) & (Not:C34($done)))
		$i:=-1
		$queryStr:=""
		
		Case of 
			: (Match regex:C1019("(.+)\\[(\\d+)\\]"; $property_t; 1; $aPos; $aLen))  //  a collection index
				$i:=Num:C11(Substring:C12($property_t; $aPos{2}; $aLen{2}))
				$property_t:=Substring:C12($property_t; $aPos{1}; $aLen{1})
				
			: (Match regex:C1019("(.+)\\[(.+)\\]"; $property_t; 1; $aPos; $aLen))  //    a collection query
				$queryStr:=Substring:C12($property_t; $aPos{2}; $aLen{2})
				$property_t:=Substring:C12($property_t; $aPos{1}; $aLen{1})
				
		End case 
		
		$valueType:=Value type:C1509($value)
		
		Case of 
			: ($valueType#Is object:K8:27) & ($valueType#Is collection:K8:32)
				$value:=$value[$property_t]
				$done:=True:C214
				
			: ($i>-1)  //  collection index
				If ($i<=($value[$property_t].length-1))
					$value:=$value[$property_t][$i]
				Else 
					$value:=Null:C1517
				End if 
				
			: ($queryStr#"")
				var $temp_c : Collection
				$temp_c:=$value[$property_t]
				$temp_c:=$temp_c.query($queryStr)
				
				If ($temp_c.length>0)
					$value:=$temp_c[0]
				Else 
					$value:=Null:C1517
				End if 
				
			Else   //  return the collection or object
				$value:=$value[$property_t]
				
		End case 
	End for each 
	
End if 