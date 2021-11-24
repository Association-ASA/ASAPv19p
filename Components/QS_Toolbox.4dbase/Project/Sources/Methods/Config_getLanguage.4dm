//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_TEXT:C284($0)

// QS - Patrick EMANUEL, 04/09/21 - 08:00:42
// To secure completely the language
If (Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_LANGUAGE="")
	Use (Storage:C1525)
		Use (Storage:C1525.QS_TBX_SHARED_DATA)
			Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_LANGUAGE:="EN"
		End use 
	End use 
End if 

$0:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_LANGUAGE