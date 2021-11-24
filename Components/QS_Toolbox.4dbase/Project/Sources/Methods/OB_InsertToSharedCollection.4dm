//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  //Method:OB_insertToSharedCollection
  //$1:Collection to copy from
  //$2:Shared Collection to copy to
  // https://kb.4d.com/assetid=78197

C_COLLECTION:C1488($1;$2)
C_LONGINT:C283($counter;$shift)

$shift0:=$2.length

For ($counter;0;$1.length-1)
	$shift:=$shift0+$counter
	
	Case of 
		: (Value type:C1509($1[$counter])=Is object:K8:27)
			Use ($2)
				  //Element type is object, copy with OB_CopyObject
				$2[$shift]:=New shared object:C1526
				OB_CopyToSharedObject ($1[$counter];$2[$shift])
			End use 
			
		: (Value type:C1509($1[$counter])=Is collection:K8:32)
			  //Element type is collection, copy with OB_CopyCollection //Element type is collection, copy with OB_CopyCollection//Element type is collection, copy with OB_CopyCollection
			Use ($2)
				$2[$shift]:=New shared collection:C1527
				OB_CopyToSharedCollection ($1[$counter];$2[$shift])
			End use 
		Else 
			  // Other supported types can be copied directly.
			Use ($2)
				$2[$shift]:=$1[$counter]
			End use 
	End case 
	
End for 