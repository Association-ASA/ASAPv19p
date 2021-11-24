//%attributes = {"shared":true,"invisible":false,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
var $pt : Pointer
var $var : Text

Case of 
	: (Count parameters:C259=0)
		$pt:=->$var
		
	Else 
		var $1 : Pointer
		If ($1=Null:C1517)
			$pt:=->$var
			
		Else 
			$pt:=$1
			
		End if 
		
End case 

CALL WORKER:C1389("QST_init"; "QS_Init"; $pt; False:C215)  // initial value