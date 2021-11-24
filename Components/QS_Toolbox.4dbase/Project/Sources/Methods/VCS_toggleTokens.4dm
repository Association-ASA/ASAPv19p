//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		var $colLines : Collection
		var $txtIndent; $txtLine : Text
		var $length; $pos : Integer
		var $hasIndent : Boolean
		
		$colLines:=New collection:C1472
		$colLines:=Split string:C1554((OBJECT Get pointer:C1124(Object named:K67:5; "codeFrom"))->; Char:C90(13))  // create a code-lines-collection from my method-text
		(OBJECT Get pointer:C1124(Object named:K67:5; "codeFrom"))->:=""  // ...my method-text (with or without tokens) set first to empty
		
		// ...now fill my method-text again (with or without tokens) from splitted lines in $colLines
		For each ($txtLine; $colLines)
			$hasIndent:=Match regex:C1019("^\\t+"; $txtLine; 1; $pos; $length)
			If ($hasIndent)
				$txtIndent:="\t"*$length
			Else 
				$txtIndent:=""
			End if 
			
			If (Form:C1466.toggleViewTokens=1)
				// remove all tokens
				// - CommentParts in code are correctly ignored: // some comment :C000 is here my pattern...
				// - StringExpressions in code are correctly ignored: $x:=Replace string(":C000";"")
				(OBJECT Get pointer:C1124(Object named:K67:5; "codeFrom"))->:=(OBJECT Get pointer:C1124(Object named:K67:5; "codeFrom"))->+$txtIndent+Parse formula:C1576($txtLine)+Char:C90(13)
				
			Else 
				// create/add tokens
				// by current 4DVersion(commands, constants, ...)
				// and by currentStuffsFromOwnDB (table, fields, plugin-functions ...)
				// - CommentParts in code are correctly ignored: // some comment :C000 is here my pattern...
				// - StringExpressions in code are correctly ignored: $x:=Replace string(":C000";"")
				(OBJECT Get pointer:C1124(Object named:K67:5; "codeFrom"))->:=(OBJECT Get pointer:C1124(Object named:K67:5; "codeFrom"))->+$txtIndent+Parse formula:C1576($txtLine; Formula out with tokens:K88:3)+Char:C90(13)
			End if 
		End for each 
		
End case 
