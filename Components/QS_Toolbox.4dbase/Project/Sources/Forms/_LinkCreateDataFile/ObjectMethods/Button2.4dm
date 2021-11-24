C_TEXT:C284($sep;$CreateDataPath_t;$DataFilename_t;$CreateDataFile_t)
C_LONGINT:C283($isFound;$len)

$DataFilename_t:=(OBJECT Get pointer:C1124(Object named:K67:5;"DataFilename_t"))->
$CreateDataPath_t:=(OBJECT Get pointer:C1124(Object named:K67:5;"CreateDataPath_t"))->

If ($DataFilename_t#"")
	
	$CreateDataFile_t:=$CreateDataPath_t+$DataFilename_t+".4DD"
	
	$sep:=":"
	$len:=Length:C16($CreateDataFile_t)
	$isFound:=0
	$isFound:=Position:C15($sep;$CreateDataFile_t;0;$len)
	
	If ($isFound#0)
		
		Form:C1466.Path_data_file:="file://"+Convert path system to POSIX:C1106($CreateDataFile_t)
		
		ACCEPT:C269
		
	Else 
		ALERT:C41("Please enter a Path")
		Form:C1466.Path_data_file:=""
	End if 
	
Else 
	
	ALERT:C41("Please enter a Data File Name")
	Form:C1466.Path_data_file:=""
	
End if 