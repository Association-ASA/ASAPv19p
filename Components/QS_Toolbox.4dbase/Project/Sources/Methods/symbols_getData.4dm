//%attributes = {"invisible":true}
C_TEXT:C284($symbols; $0)

If (Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_hostInProjectMode))
	$source:=Folder:C1567(fk logs folder:K87:17; *).file(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName+"_symbols.txt")
	$filePath:=$source.platformPath
	
Else 
	$path:=Path to object:C1547(Structure file:C489(*))
	$filePath:=$path.parentFolder+$path.name+"_symbols.txt"
	
	If (Test path name:C476($filePath)#Is a document:K24:1)
		$filePath:=$path.parentFolder+$path.name+".4DB_symbols.txt"
	End if 
End if 

If (Test path name:C476($filePath)=Is a document:K24:1)
	$varSource:=""
	$varSourceName:=""
	$symbols:=Document to text:C1236($filePath; "UTF-8")
End if 

$0:=$symbols