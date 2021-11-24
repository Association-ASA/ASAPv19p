//%attributes = {"invisible":true,"shared":true}
var $start : Boolean
$start:=True:C214

ON ERR CALL:C155("Base_NoError")

If (Storage:C1525.QS_TBX_SHARED_DATA#Null:C1517)
	If (Storage:C1525.QS_TBX_SHARED_DATA.QS_initDone#Null:C1517)
		If (Storage:C1525.QS_TBX_SHARED_DATA.QS_initDone=True:C214)
			$newProcess:=New process:C317("_MNU_Start"; 0; "QST_Menu"; "__Menu_og"; *)
			$start:=False:C215
		End if 
	End if 
End if 

If ($start)
	QS_TOOLBOX
End if 