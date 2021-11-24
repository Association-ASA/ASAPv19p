//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // compares two objects. If they are the same (ie. they have exactly the same elements and values),
  // the method returns true. Thanks to Vincent de Lachaux for the original code which has been changed
  // slightly to more closely match my style.

C_OBJECT:C1216($1;$oFirst)
C_OBJECT:C1216($2;$oSecond)
C_BOOLEAN:C305($0;$fIsEqual)

$oFirst:=$1
$oSecond:=$2
$fIsEqual:=False:C215  // defaul to false

C_LONGINT:C283($x;$y;$lFirstItemCount;$lSecondItemCount;$lFirstPropertyCount;$lSecondPropertyCount)
ARRAY LONGINT:C221($alFirstType;0x0000)
ARRAY TEXT:C222($atFirstProperty;0x0000)
ARRAY LONGINT:C221($alSecondType;0x0000)
ARRAY TEXT:C222($atSecondProperty;0x0000)

OB GET PROPERTY NAMES:C1232($oFirst;$atFirstProperty;$alFirstType)
OB GET PROPERTY NAMES:C1232($oSecond;$atSecondProperty;$alSecondType)
$lFirstPropertyCount:=Size of array:C274($atFirstProperty)
$lSecondPropertyCount:=Size of array:C274($atSecondProperty)

If ($lFirstPropertyCount=$lSecondPropertyCount)  // they won't be equal if they have different property counts
	
	If ($lFirstPropertyCount>0)
		
		  // sort arrays because the properties could be in a different order
		SORT ARRAY:C229($atFirstProperty;$alFirstType)
		SORT ARRAY:C229($atSecondProperty;$alSecondType)
		
		  // now compare each property
		
		For ($x;1;$lFirstPropertyCount)
			
			Case of 
					
				: (Length:C16($atFirstProperty{$x})#Length:C16($atSecondProperty{$x}))  // if the property names aren't the same length
					$fIsEqual:=False:C215
					
				: (Position:C15($atFirstProperty{$x};$atSecondProperty{$x};*)#1)  // check property name (case sensitive)
					$fIsEqual:=False:C215
					
				: ($alFirstType{$x}#$alSecondType{$x})  // check property type
					$fIsEqual:=False:C215
					
				: ($alFirstType{$x}=Is object:K8:27)
					
					  // compare the two objects
					$fIsEqual:=OB_IsEqual (\
						OB Get:C1224($oFirst;$atFirstProperty{$x};Is object:K8:27);\
						OB Get:C1224($oSecond;$atFirstProperty{$x};Is object:K8:27))
					
				: ($alFirstType{$x}=Object array:K8:28)
					
					  // in an object array we can massage all the array types back into text except object themselves.
					  // so we get two sets of arrays, one text and the other objects. Then we can deal with either kind
					  // as we walk through each element.
					
					ARRAY OBJECT:C1221($aoFirst;0x0000)  // reset arrays
					ARRAY TEXT:C222($atFirst;0x0000)
					ARRAY OBJECT:C1221($aoSecond;0x0000)
					ARRAY TEXT:C222($atSecond;0x0000)
					OB GET ARRAY:C1229($oFirst;$atFirstProperty{$x};$aoFirst)  // get text and object types
					OB GET ARRAY:C1229($oFirst;$atFirstProperty{$x};$atFirst)
					OB GET ARRAY:C1229($oSecond;$atFirstProperty{$x};$aoSecond)
					OB GET ARRAY:C1229($oSecond;$atFirstProperty{$x};$atSecond)
					
					$lFirstItemCount:=Size of array:C274($aoFirst)
					$lSecondItemCount:=Size of array:C274($aoSecond)
					
					If ($lFirstItemCount=$lSecondItemCount)
						
						For ($y;1;$lFirstItemCount;1)
							
							If ((OB Is defined:C1231($aoFirst{$y})) & (OB Is defined:C1231($aoSecond{$y})))  // if they are both objects
								$fIsEqual:=OB_IsEqual ($aoFirst{$y};$aoSecond{$y})
							Else   // compare text
								$fIsEqual:=($atFirst{$y}=$atSecond{$y})
							End if 
							
							If ($fIsEqual=False:C215)
								$y:=$lFirstItemCount+1  // abort loop
							End if 
							
						End for 
						
					Else 
						
						$fIsEqual:=False:C215
						
					End if 
					
				Else   // for any other object type, we simply compare the values
					
					$fIsEqual:=(OB Get:C1224($oFirst;$atFirstProperty{$x})=OB Get:C1224($oSecond;$atFirstProperty{$x}))
					
			End case 
			
			If ($fIsEqual=False:C215)
				$x:=$lFirstPropertyCount+1  // abort loop
			End if 
			
		End for 
		
	Else   // if there are not elements in either one, they are both equal
		
		$fIsEqual:=True:C214
		
	End if 
End if 

$0:=$fIsEqual
