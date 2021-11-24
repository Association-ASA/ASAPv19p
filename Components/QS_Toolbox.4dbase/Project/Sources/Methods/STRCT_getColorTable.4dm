//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_OBJECT:C1216($1;$oTable;$otmp)
$oTable:=$1

$foreground:=color RGB black
$background:=color RGB white

If (OB Is defined:C1231($oTable;"color")=True:C214)
	C_LONGINT:C283($red;$green;$blue)
	$otmp:=$oTable.color
	$red:=Num:C11($otmp.red) << 16
	$green:=Num:C11($otmp.green) << 8
	$blue:=Num:C11($otmp.blue)
	
	$rgb:=$red+$green*$blue
	
	If ($rgb=color RGB black) | ($rgb=color RGB white)  // automatique
		
		$foreground:=color RGB black
		$background:=color RGB white
		
	Else 
		
		Col_RGBtoHSL ($rgb;->$teinte;->$saturation;->$luminance)
		
		$saturation:=40
		$luminance:=40
		$foreground:=Col_HSLtoRGB ($teinte;$saturation;$luminance)
		
		$saturation:=10
		$luminance:=100
		$background:=Col_HSLtoRGB ($teinte;$saturation;$luminance)
		
	End if 
	
End if 
Form:C1466.colorBackground:=Substring:C12(Str_longToHexa ($background);3)
Form:C1466.colorText:=Substring:C12(Str_longToHexa ($foreground);3)