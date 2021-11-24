
If (QS_miniVersionR (3))
	
	Case of 
		: (Form event code:C388=On Data Change:K2:15)
			C_TEXT:C284($CommentMethod)
			$CommentMethod:=(OBJECT Get pointer:C1124(Object named:K67:5;"comment_txt"))->
			METHOD SET COMMENTS:C1193(Form:C1466.currentMethod;$CommentMethod;*)
			MM_commentInMarkdown (Form:C1466.currentMethod)
			
	End case 
End if 
