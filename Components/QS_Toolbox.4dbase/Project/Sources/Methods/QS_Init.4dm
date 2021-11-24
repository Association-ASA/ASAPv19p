//%attributes = {"invisible":true,"shared":true}
// check minimal 4D version required
If (QST_minimalVersion)
	
	If (Count parameters:C259=2)
		
		QS_Toolbox_init_start($1; $2)
	Else 
		C_POINTER:C301($pt)
		QS_Toolbox_init_start($pt; True:C214)
	End if 
	
	If (Count parameters:C259=3)
		C_OBJECT:C1216($3)
		signal_addResult($3; Current method name:C684)
	End if 
	
End if 
KILL WORKER:C1390