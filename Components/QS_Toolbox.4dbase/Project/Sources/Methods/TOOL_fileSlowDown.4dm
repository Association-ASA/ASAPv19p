//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 25/12/17, 21:24:38
// ----------------------------------------------------
// Méthode : QS_FILE_Slow_Down
// Description
// Due to very fast speed machine, need to check the end of creation of the file
//
// Paramètres
// ----------------------------------------------------

#DECLARE($docPath_t : Text)

C_BOOLEAN:C305($stop)
$stop:=False:C215
$Count:=0

C_LONGINT:C283($MaxLoop)
$MaxLoop:=Storage:C1525.QS_TBX_SHARED_WITH_SERVER.QS_TBX_MAX_LOOP

Use (Storage:C1525)
	Use (Storage:C1525.QS_TBX_SHARED_DATA)
		Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_crossReference:=False:C215
	End use 
End use 

$time:=2
While ((Test path name:C476($docPath_t)#Is a document:K24:1) & (Not:C34($stop)))
	
	$count:=$count+1
	Case of 
		: (Count parameters:C259=1)
			$time:=2
			
		: (Count parameters:C259=2)  // WE assume that this one could take time, we increase the time at each step
			$time:=$time+2
			If ($time>20)
				$time:=20  // a Third of a second
			End if 
	End case 
	PROCESS_sleep($time)
	
	If (Test path name:C476($docPath_t)=Is a document:K24:1)
		$stop:=True:C214
	Else 
		$stop:=Choose:C955($Count>$MaxLoop; True:C214; False:C215)
	End if 
	
End while 