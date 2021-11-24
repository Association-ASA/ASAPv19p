//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // XXXX - Need to be evaluate
  // method: Font_SetBestSize_Jut
  // this is from an older DB of mine still in use

  // when printing documents that need to be fancier than your standard report, such as name tags, calendars, and catalog pages,
  // you often run into text (like people's `names) that's too big for the space you've allocated.

  // rather than just truncating this text, you can use 4D's BEST OBJECT SIZE command to adjust the form object's font size until
  // the text it contains fits perfectly. Just `pass the form object to this method, a long with the starting font size.

  // this procedure will get the object's current width, and determine if the text already fits. If it doesn't, it reduces the object's font
  // size in 1 point increments until the text `fits. This routine also moves the text down as it decreases the font size to keep the text vertically centered.
  //
  // ` Method: Font_SetBestSize_Jut (->vName;Starting Font Size)
  //
  // parameters

C_POINTER:C301($1;$ObjectPointer)
C_LONGINT:C283($2;$OriginalFontSize)
C_POINTER:C301(${3})  // add additional pointers to vars that need to be the same size and font.
C_LONGINT:C283($vMinFont)

  // ----------------------------------------------------

C_LONGINT:C283($BestWidth;$BestHeight;$ObjectWidth;$NewFontSize)
C_LONGINT:C283($left;$top;$right;$bottom;$ObjectWidth;$ObjectHeight)
$NewFontSize:=-1

$ObjectPointer:=$1

If (Count parameters:C259>2)
	
	$length:=Length:C16($1->)
	
	For ($i;3;Count parameters:C259)
		If (Length:C16(${$i}->)>$length)
			$length:=Length:C16(${$i}->)
			$ObjectPointer:=${$i}
		End if 
	End for 
	
End if 

$OriginalFontSize:=$2
$NewFontSize:=$OriginalFontSize

OBJECT GET COORDINATES:C663($ObjectPointer->;$left;$top;$right;$bottom)
$ObjectWidth:=$right-$left
$ObjectHeight:=$bottom-$Top

OBJECT SET FONT SIZE:C165($ObjectPointer->;$OriginalFontSize)
OBJECT GET BEST SIZE:C717($ObjectPointer->;$BestWidth;$BestHeight)

While ($BestWidth>$ObjectWidth) & ($NewFontSize#$vMinFont)
	
	$NewFontSize:=$NewFontSize-1
	$ObjectHeight:=$ObjectHeight-1
	OBJECT SET FONT SIZE:C165($ObjectPointer->;$NewFontSize)
	OBJECT MOVE:C664($ObjectPointer->;0;1;0;-1)
	
	If (Count parameters:C259>2)
		
		If ($ObjectPointer#$1)
			
			$ObjectPointer2:=$1
			OBJECT SET FONT SIZE:C165($ObjectPointer2->;$NewFontSize)
			OBJECT MOVE:C664($ObjectPointer2->;0;1;0;-1)
			
		End if 
		
		For ($i;3;Count parameters:C259)
			
			$ObjectPointer2:=${$i}
			
			If ($ObjectPointer2#$ObjectPointer)
				OBJECT SET FONT SIZE:C165($ObjectPointer2->;$NewFontSize)
				OBJECT MOVE:C664($ObjectPointer2->;0;1;0;-1)
			End if 
			
		End for 
	End if 
	
	OBJECT GET BEST SIZE:C717($ObjectPointer->;$BestWidth;$BestHeight)
	
End while 

$vMinFont:=0
