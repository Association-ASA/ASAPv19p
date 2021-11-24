//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // XXXX - Need to be evaluate
  // method: ObjectBestSize
  // i am using this one in my latest DB.

C_POINTER:C301($1;$FieldPtr)
C_LONGINT:C283($2;$defaultFontSize;$3;$fieldVarWidth;$bestWidth;$bestHeight)

$FieldPtr:=$1

If (Count parameters:C259>1)
	$defaultFontSize:=$2
Else 
	$defaultFontSize:=OBJECT Get font size:C1070($FieldPtr->)
End if 

OBJECT GET COORDINATES:C663($FieldPtr->;$left;$top;$right;$bottom)
$fieldVarHeight:=$bottom-$top

If (Count parameters:C259>2)
	$fieldVarWidth:=$3
Else 
	$fieldVarWidth:=$right-$left
End if 

OBJECT SET FONT SIZE:C165($FieldPtr->;$defaultFontSize)
OBJECT GET BEST SIZE:C717($FieldPtr->;$bestWidth;$bestHeight)
$count:=0

While ($bestWidth>$fieldVarWidth) & ($defaultFontSize>1)
	
	$defaultFontSize:=$defaultFontSize-1
	OBJECT SET FONT SIZE:C165($FieldPtr->;$defaultFontSize)
	OBJECT GET BEST SIZE:C717($FieldPtr->;$bestWidth;$bestHeight;$fieldVarWidth)
	$count:=$count+1
	
End while 

  //
OBJECT GET COORDINATES:C663($FieldPtr->;$left;$top;$right;$bottom)

While ($bestHeight>$fieldVarHeight)
	
	$defaultFontSize:=$defaultFontSize-1
	OBJECT SET FONT SIZE:C165($FieldPtr->;$defaultFontSize)
	OBJECT GET BEST SIZE:C717($FieldPtr->;$bestWidth;$bestHeight;$fieldVarWidth)
	$count:=$count+1
	
End while 
