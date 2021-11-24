C_TEXT:C284($temp)
C_REAL:C285($Options)
$Options:=Alias selection:K24:10+Package open:K24:8+Use sheet window:K24:11
$temp:=Select document:C905("";"*";"Select the data file";$Options)

If (OK=1)
	(OBJECT Get pointer:C1124(Object named:K67:5;"lcl_data_file_t"))->:="file://"+Convert path system to POSIX:C1106(Document)
Else 
	(OBJECT Get pointer:C1124(Object named:K67:5;"lcl_data_file_t"))->:=""
End if 

LINKS_UpdateDOM 