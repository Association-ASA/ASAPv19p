//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
var $1 : Text
If (Form event code:C388=On End URL Loading:K2:47)
	If ($1#"")
		var $wa_p : Pointer
		$wa_p:=OBJECT Get pointer:C1124(Object named:K67:5; "webZone")
		WA EXECUTE JAVASCRIPT FUNCTION:C1043($wa_p->; "setContent"; *; $1)
	End if 
End if 