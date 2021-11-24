//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
If (Form:C1466.txtQuery#"")
	$currErrMethode:=Method called on error:C704
	ON ERR CALL:C155("BASE_noERROR")
	
	Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.query(Form:C1466.txtQuery)
	ON ERR CALL:C155($currErrMethode)
	MM_updateInformation 
Else 
	ALERT:C41("No request to execute.")
End if 