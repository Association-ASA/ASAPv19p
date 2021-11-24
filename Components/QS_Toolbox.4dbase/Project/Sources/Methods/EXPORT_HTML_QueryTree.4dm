//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
/*
▶️ 💬: $param
▶️ []: $methodList
--
◀️ 💬: $html :
*/

#DECLARE($param : Text; $methodList : Collection)->$html : Text

C_TEXT:C284($Ref)
C_BOOLEAN:C305($subFolder)
C_LONGINT:C283($long; $pos)
C_OBJECT:C1216($method)
C_COLLECTION:C1488($col)

$col:=New collection:C1472
$col.push("\r")
$col.push("<ul class=\"jqueryFileTree\">")
$col.push("<li class=\"directory collapsed\">")
$col.push("<a href=\"\" class=\"directory\">"+$param+" ("+String:C10($methodList.length)+")</a>")
$col.push("<ul class=\"jqueryFileTree\" style=\"display:none;\">")
$Ref:=""

If ($methodList.length>0)
	
	$subFolder:=Match regex:C1019("[.]"; $methodList[0].name; 1; $pos; $long)
	
	For each ($method; $methodList)
		
		$methodName:=$method.name
		TOOL_trimCharacters(->$methodName)
		
		If ($subFolder)
			$subFolder:=Match regex:C1019("[.]"; $methodName; 1; $pos; $long)
			$Racine:=Substring:C12($methodName; 1; $pos-1)
			$End:=Substring:C12($methodName; $pos+$long)
			
			If ($Racine#$Ref)
				If ($Ref#"")
					$col.push("</ul></li>")
				End if 
				$col.push("<li class=\"directory collapsed\"><a href=\"\" class=\"directory\">"+$Racine+"</a><ul class=\"jqueryFileTree\" style=\"display:none;\">")
				$ref:=$Racine
			End if 
			$col.push("<li class=\"file ext_txt\"><a href=\"methods/"+$methodName+".html\" target=\"methodFrame\">"+$End+"</a></li>")
			
		Else 
			$col.push("<li class=\"file ext_txt\"><a href=\"methods/"+$methodName+".html\" target=\"methodFrame\">"+$methodName+"</a></li>")
		End if 
		
	End for each 
	
	If ($subFolder)
		$col.push("</ul></li>")
	End if 
	
End if 

$col.push("</ul>")
$col.push("</li>")
$col.push("</ul>")
$col.push("\r")

$html:=$col.join("\r")