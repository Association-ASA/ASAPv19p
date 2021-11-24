//%attributes = {"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
var $Code; $Method : Text
var $methodFound : Collection

$Method:=Request:C163("Method Name to transform with Tokens (case sensitive):")

// Check method name regarding the hosted method
$methodFound:=Storage:C1525.allMethods.filter("CM_displayByType"; "Path project method"; $Method)

If ($methodFound.length=1)
	
	displayInfo("Processing the translation...")
	IDLE:C311
	$onError:=Method called on error:C704
	ON ERR CALL:C155("BASE_noERROR")
	METHOD GET CODE:C1190($Method; $Code; Code with tokens:K72:18; *)
	
	If (Not:C34(Shift down:C543))
		$Method:=$Code
	Else 
		MM_removeFirstLine(->$code)
		$Method:=$Code
	End if 
	
	ON ERR CALL:C155($onError)
Else 
	$Method:=""
	ALERT:C41("Error in the method name. Check it before retry.")
End if 

(OBJECT Get pointer:C1124(Object named:K67:5; "codeTo"))->:=$Method
displayInfo("Translation done.")
