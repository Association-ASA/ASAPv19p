//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_COLLECTION:C1488($1)
		If ($1.length>0)
			CALL WORKER:C1389("QST_job";"lb_collectionToPasteboard";$1)
		Else 
			ALERT:C41("Nothing to copy.")
		End if 
		
End case 
