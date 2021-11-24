C_TEXT:C284(Content_t2;$CommentMethod)
C_POINTER:C301($wa_p)

Case of 
	: (Form event code:C388=On End URL Loading:K2:47)
		If (Content_t2#"")
			$wa_p:=OBJECT Get pointer:C1124(Object named:K67:5;"webComment")
			WA EXECUTE JAVASCRIPT FUNCTION:C1043($wa_p->;"setContent";*;Content_t2)
		End if 
		
	: (Form event code:C388=On Losing Focus:K2:8)
		$wa_p:=OBJECT Get pointer:C1124(Object named:K67:5;"webComment")
		WA EXECUTE JAVASCRIPT FUNCTION:C1043($wa_p->;"getContent";$CommentMethod)
		METHOD SET COMMENTS:C1193(Form:C1466.currentMethod;$CommentMethod;*)
		
End case 