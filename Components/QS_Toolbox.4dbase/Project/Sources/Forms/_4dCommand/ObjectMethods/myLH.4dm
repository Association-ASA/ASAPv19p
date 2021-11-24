// Depending of the version, analyse is not made by the same way

ARRAY TEXT:C222($atKeys; 0)
ARRAY TEXT:C222($atValues; 0)
C_LONGINT:C283($key; $key2)
C_TEXT:C284(Content_4DC)

GET LIST ITEM PARAMETER ARRAYS:C1195(*; "myLH"; *; $atKeys; $atValues)  // get parameter arrays for the selected item
$key:=Find in array:C230($atKeys; "type")
$key2:=Find in array:C230($atKeys; "path")

If ($key>0)
	If ($key2>0)
		Form:C1466.name:=$atValues{$key2}
	End if 
	
	If ($atValues{$key}#"")
		displayInfo("")
		
		Case of 
			: (Form event code:C388=On Clicked:K2:4)
				If (Right click:C712)
				Else 
					
					// To prepare the codeMirror displaying
					//WA SET PAGE CONTENT(*; "webZone"; "<html><body><font face=\"Verdana\" size=\"2\">"+$codePreview+"</font></body></html>"; "")
					Case of 
							
						: ($atValues{$key}="Method")
							
							METHOD GET CODE:C1190($atValues{$key2}; $codePreview; *)
							$firstNL:=Position:C15("\r"; $codePreview)
							If ($firstNL>0)
								Content_4DC:=Substring:C12($codePreview; $firstNL+1)
								METHOD_codeMirror_display
								WA REFRESH CURRENT URL:C1023(*; "webZone")
							End if 
							
						Else 
							COMMANDS_getSyntax
							
					End case 
				End if 
				
			: (Form event code:C388=On Double Clicked:K2:5)
				If (Right click:C712)
				Else 
					
					Case of 
							
						: ($atValues{$key}="Method")
							METHOD OPEN PATH:C1213($atValues{$key2}; *)
							
					End case 
				End if 
				
		End case 
	End if 
End if 