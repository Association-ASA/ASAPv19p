//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
#DECLARE($module : Text)

If (QST_minimalVersion)
	var $start : Boolean
	$start:=True:C214
	
	If (Storage:C1525.QS_TBX_SHARED_DATA#Null:C1517)
		If (Storage:C1525.QS_TBX_SHARED_DATA.QS_initDone#Null:C1517)
			If (Storage:C1525.QS_TBX_SHARED_DATA.QS_initDone=True:C214)
				CALL WORKER:C1389("QST_"+$module; "__"+$module)
				$start:=False:C215
			Else 
				ALERT:C41("Settings is not finished. Try again in few moment.")
			End if 
		End if 
	End if 
	
	If ($start)
		var $pt : Pointer
		var $signal : Object
		var $var : Text
		$pt:=->$var
		
		$signal:=New signal:C1641
		signal_setNew($signal; 1)
		CALL WORKER:C1389("QST_init"; "QS_init"; $Pt; 1; $signal)
		$signal.wait()
		
		CALL WORKER:C1389("QST_"+$module; "__"+$module)
		
	End if 
End if 