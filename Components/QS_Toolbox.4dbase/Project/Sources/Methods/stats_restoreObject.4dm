//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // restore_object_with_font_number
$continue:=True:C214

If (Version type:C495 ?? 64 bit version:K5:25)
	CONFIRM:C162("not 32-bit! continue?")
	$continue:=(OK=1)
End if 

If ($continue)
	
	C_COLLECTION:C1488($paths)
	C_OBJECT:C1216($path)
	C_TEXT:C284($methodPath;$formName;$objectName)
	
	C_LONGINT:C283($t;$f;$o)  //iterator for tables,forms,objects
	ARRAY TEXT:C222($formNames;0)
	ARRAY TEXT:C222($objectNames;0)
	
	$paths:=New collection:C1472
	
	For ($t;0;Get last table number:C254)
		If (Is table number valid:C999($t)) | ($t=0)
			If ($t#0)
				FORM GET NAMES:C1167(Table:C252($t)->;$formNames;*)
			Else 
				FORM GET NAMES:C1167($formNames;*)
			End if 
			For ($f;1;Size of array:C274($formNames))
				$path:=New object:C1471
				$formName:=$formNames{$f}
				If ($t#0)
					FORM LOAD:C1103(Table:C252($t)->;$formName;*)
					$methodPath:=METHOD Get path:C1164(Path table form:K72:5;Table:C252($t)->;$formName;*)
				Else 
					FORM LOAD:C1103($formName;*)
					$methodPath:=METHOD Get path:C1164(Path project form:K72:3;$formName;*)
				End if 
				FORM GET OBJECTS:C898($objectNames;*)
				For ($o;1;Size of array:C274($objectNames))
					$objectName:=$objectNames{$o}
					$stylesheetName:=OBJECT Get style sheet:C1258(*;$objectName)
					If ($stylesheetName="")
						$path.path:=$methodPath
						$path.objects:=New object:C1471
						$path.objects[$objectName]:=New object:C1471("fontFamily";OBJECT Get font:C1069(*;$objectName))
					End if 
				End for 
				If (Not:C34(OB Is empty:C1297($path)))
					$paths.push($path)
				End if 
				FORM UNLOAD:C1299
			End for 
		End if 
	End for 
	
	$signature:="  // code added by "+Current method name:C684+"\r"
	For each ($path;$paths)
		
		$code:=""
		
		METHOD GET CODE:C1190($path.path;$code;Code with tokens:K72:18;*)
		$addCode:=(0=Position:C15($signature;$code;*))
		$codeSnippet:=""
		If ($addCode)
			$codeSnippet:=$signature
			$codeSnippet:=$codeSnippet+"If (Form event:C388=On Load:K2:1) | (Form event:C388=On Header:K2:17) | (Form event:C388=On Printing Detail:K2:18) | (Form event:C388=On Printing Break:K2:19) | (Form event:C388=On Printing Footer:K2:20)\r"
			For each ($objectName;$path.objects)
				$codeSnippet:=$codeSnippet+"OBJECT SET FONT:C164(*;\""+$objectName+"\";\""+$path.objects[$objectName].fontFamily+"\")\r"
			End for each 
			
			$codeSnippet:=$code+"\r"+$codeSnippet+"End if\r"
			
			METHOD SET CODE:C1194($path.path;$codeSnippet;*)
			
		End if 
		
	End for each 
	
End if 