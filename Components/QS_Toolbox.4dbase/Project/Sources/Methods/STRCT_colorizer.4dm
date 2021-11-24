//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_TEXT:C284($backColor;$frontColor)
C_OBJECT:C1216($0;$cells;$otmp)


If (OB Is defined:C1231(This:C1470.color))
	
	C_LONGINT:C283($red;$green;$blue)
	$otmp:=This:C1470.color
	$red:=Num:C11($otmp.red) << 16
	$green:=Num:C11($otmp.green) << 8
	$blue:=Num:C11($otmp.blue)
	
	$rgb:=$red+$green*$blue
	
	If ($rgb=color RGB black) | ($rgb=color RGB white) | (Num:C11($otmp.alpha)=0)  // automatique
		
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
	
	$cells:=New object:C1471("fill";"#"+Substring:C12(Str_longToHexa ($background);3);"stroke";"#"+Substring:C12(Str_longToHexa ($foreground);3);"cell";New object:C1471())
	
Else 
	
	
	$backColor:=Form:C1466.colorBackground
	$frontColor:=Form:C1466.colorText
	$cells:=New object:C1471("fill";"#"+$backColor;"stroke";"#"+$frontColor;"cell";New object:C1471())
	
	
End if 



$0:=$cells