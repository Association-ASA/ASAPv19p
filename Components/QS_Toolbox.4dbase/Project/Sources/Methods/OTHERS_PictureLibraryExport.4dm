//%attributes = {"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_TEXT:C284($Mess;$Meth)

$Version:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DVersion

If (Version type:C495 ?? 64 bit version:K5:25)
	ALERT:C41("You are in 64 bits version.\nPICTs could not be converted.\nTo do the conversion, open "+$Version+" with the 32 bits version and retry.")
	
Else 
	$Meth:="IMG_Template_Export_Library"
	$Mess:=""
	
	QS_TOOL_Execute_OnHost ($Meth;$Mess)
	$path_t:=Get 4D folder:C485(Current resources folder:K5:16;*)+Replace string:C233("QS_Toolbox_export_library/";"/";Folder separator:K24:12)
	ARRAY TEXT:C222($TbDocList;0x0000)
	DOCUMENT LIST:C474($path_t;$TbDocList;Ignore invisible:K24:16)
	
	$txt:="Library exportation finished.\r"
	$txt:=$txt+"Folder "+$path_t+" contains "+String:C10(Size of array:C274($TbDocList))+" files."
	displayInfo ($txt;"blue")
End if 