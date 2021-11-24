//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_LONGINT:C283($0)

If (Form:C1466.exportList.length>0)
	$0:=Num:C11(Form:C1466.exportList.max("uniqueID"))
Else 
	$0:=0
End if 