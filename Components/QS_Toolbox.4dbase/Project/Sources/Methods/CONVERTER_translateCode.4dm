//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_TEXT:C284($newCode)
//C_TEXT($from; $to; $newCode)
//$from:=Form.mySelectFrom
//$to:=Form.mySelectTo

Case of 
	: (Form:C1466.mySelectFrom=Form:C1466.mySelectTo)
		ALERT:C41("From = To! Are you sure?")
		
	: ((OBJECT Get pointer:C1124(Object named:K67:5; "codeFrom"))->="")
		ALERT:C41("From code is empty!")
		
	Else 
		
		//$newCode:=TRANS_Translation((OBJECT Get pointer(Object named; "codeFrom"))->; $From; $To)
		$newCode:=TRANS_Translation((OBJECT Get pointer:C1124(Object named:K67:5; "codeFrom"))->)
		(OBJECT Get pointer:C1124(Object named:K67:5; "codeTo"))->:=$newCode
		
End case 