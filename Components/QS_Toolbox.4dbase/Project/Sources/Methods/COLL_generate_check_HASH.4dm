//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------------------------
  // Name: COLL_generate_check_HASH
  // Description: Method will take a collection and create a hash
  // collection as well as verifying a hashed collection.
  // 
  // Parameters:
  // $1 (COLLECTION) - Collection to hash
  // $2 (COLLECTION) - Hash collection to verify original collection

  // E.g. [0]:0 // Successful hash generated for original collection
  // [0]: // No Hash collection created
  // [0]:N // Fail where 'N' is number times hash is inaccurate
  // [0]:-1 // Invalid number of parameters
  // ----------------------------------------------------------------------
  // https://kb.4d.com/assetid=77955

C_COLLECTION:C1488($1;$origCol;$collect)
C_COLLECTION:C1488($2;$hashCol)
C_COLLECTION:C1488($0)
C_LONGINT:C283($i;$count)
C_TEXT:C284($text)

If (Count parameters:C259>0)
	$origCol:=$1
	$collect:=New collection:C1472
	
	If (Count parameters:C259=2)
		$hashCol:=$2
		$count:=0
	End if 
	
	For ($i;0;$origCol.length-1)
		If ((Value type:C1509($origCol[$i])=Is object:K8:27) | (Value type:C1509($origCol[$i])=\
			Is collection:K8:32) | (Value type:C1509($origCol[$i])=Is pointer:K8:14))
			
			$text:=Generate digest:C1147(JSON Stringify:C1217($origCol[$i]);SHA512 digest:K66:5)
		Else 
			$text:=Generate digest:C1147(String:C10($origCol[$i]);SHA512 digest:K66:5)
		End if 
		
		If (Count parameters:C259=1)
			$collect.push($text)
		Else 
			If ($text#$hashCol[$i])
				$count:=$count+1
			End if 
		End if 
	End for 
	
	If (Count parameters:C259=1)
		$0:=$collect
	Else 
		$0:=$collect.push($count)
	End if 
Else 
	$0:=New collection:C1472(-1)
End if 