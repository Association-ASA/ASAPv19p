C_TEXT:C284($sep;$StructureFilename_t;$CreateStructurePath_t;$CreateStructureFile_t)
C_LONGINT:C283($isFound;$len)

$StructureFilename_t:=(OBJECT Get pointer:C1124(Object named:K67:5;"StructureFilename_t"))->
$CreateStructurePath_t:=(OBJECT Get pointer:C1124(Object named:K67:5;"CreateStructurePath_t"))->

If ($StructureFilename_t#"")
	
	$CreateStructureFile_t:=$CreateStructurePath_t+$StructureFilename_t+".4DB"
	
	$sep:=":"
	$len:=Length:C16($CreateStructureFile_t)
	$isFound:=Position:C15($sep;$CreateStructureFile_t)
	
	If ($isFound>0)
		
		Form:C1466.Path_structure_file:="file://"+Convert path system to POSIX:C1106($CreateStructureFile_t)
		
		ACCEPT:C269
		
	Else 
		ALERT:C41("Please enter a Path")
		Form:C1466.Path_structure_file:=""
	End if 
	
Else 
	ALERT:C41("Please enter a File Name")
	Form:C1466.Path_structure_file:=""
End if 