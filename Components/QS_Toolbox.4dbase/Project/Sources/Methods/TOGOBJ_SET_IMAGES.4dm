//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // method: TOGOBJ_SET_IMAGES
  // set left, right, button image properties into toggle object.
  // $1 (Object) - Toggle object
  // $2 (Picture) - Left picture
  // ($3) (Picture) - Right picture
  // ($4) (Picture) - Button picture

C_OBJECT:C1216($togObj)
C_TEXT:C284($bEnc;$lEnc;$rEnc;$button)
C_PICTURE:C286($2;$lPic;$3;$rPic;$4;$buttonPic)
C_POINTER:C301($buttonPtr)
$togObj:=$1

If (Count parameters:C259>=2)
	
	$lPic:=$2
	$lEnc:=UTIL_PIC_TO_B64_TEXT ($lPic)
	TOGCTN_SET_IMAGE ($togObj;$lPic)  // set container background based off button position
	
	If (Count parameters:C259>=3)
		
		$rPic:=$3
		$rEnc:=UTIL_PIC_TO_B64_TEXT ($rPic)
		
		If (Count parameters:C259>=4)
			
			$buttonPic:=$4
			
			TOGOBJ_GET_VAL ($togObj;"Button";->$button)
			$buttonPtr:=OBJECT Get pointer:C1124(Object named:K67:5;$button)
			$buttonPtr->:=$buttonPic
			$bEnc:=UTIL_PIC_TO_B64_TEXT ($buttonPic)
			
		End if 
	End if 
End if 

OB SET:C1220($togObj;"Button Picture";$bEnc;"Left Picture";$lEnc;"Right Picture";$rEnc)
