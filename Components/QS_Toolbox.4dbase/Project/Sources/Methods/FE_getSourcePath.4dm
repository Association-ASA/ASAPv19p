//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}


C_OBJECT:C1216($path)
$path:=QS_s_Get_DB_Name
If (Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_hostInProjectMode=True:C214))
	$formsPath:=$path.parentFolder+Replace string:C233("Sources/forms"; "/"; Folder separator:K24:12)
End if 
