//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_TEXT:C284($1;$Path_t;$TimeStampExported;$TimeStamp_Export)
C_BOOLEAN:C305($found_b)
C_COLLECTION:C1488($icol)

$Path_t:=$1
$TimeStampExported:=VCS_Get_TimeStampExported ($Path_t)
$found_b:=(Num:C11($TimeStampExported)#0)
LISTBOX SELECT ROW:C912(*;"Exports_lb";0;lk remove from selection:K53:3)
LISTBOX SELECT ROW:C912(*;"Exported_lb";0;lk remove from selection:K53:3)

If ($found_b)
	$icol:=Form:C1466.exportList.indices("uniqueID = :1";$TimeStampExported)
	$indice:=0
	
	If ($icol.length>0)
		$indice:=$icol[0]
		Form:C1466.exportListCurrent:=Form:C1466.exportList[$indice]
		$TimeStamp_Export:=Form:C1466.exportListCurrent.uniqueID
		LISTBOX SELECT ROW:C912(*;"Exports_lb";$icol[0]+1;lk add to selection:K53:2)
		OBJECT SET SCROLL POSITION:C906(*;"Exports_lb";$icol[0]+1;*)
		
	Else 
		$TimeStamp_Export:=String:C10($indice)
	End if 
	
	VCS_List_All_Exported ($TimeStamp_Export)
	If ($indice>=0)
		C_BOOLEAN:C305($result)
		$icol:=Form:C1466.exported.indices("path = :1";$Path_t)
		If ($icol.length>0)
			LISTBOX SELECT ROW:C912(*;"Exported_lb";$icol[0]+1;lk add to selection:K53:2)
			OBJECT SET SCROLL POSITION:C906(*;"Exported_lb";$icol[0]+1;*)
			Form:C1466.oldPath:=Form:C1466.exported[$icol[0]].path
			Form:C1466.oldVersion:=VCS_UpdateOldVersion (Form:C1466.exported[$icol[0]].timeStamp;Form:C1466.oldPath)
			$FenetreInformation:="Previous saved version of "+$Path_t+" was on "+String:C10(Date:C102(Form:C1466.exportListCurrent.timeStamp))+"."
		Else 
			Form:C1466.oldPath:=""
			Form:C1466.oldVersion:=""
			$FenetreInformation:=$Path_t+": previous version has not been found."
		End if 
		
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"Compare_VCS";"insertInEditor";$result;"mergeright";Form:C1466.oldVersion)
		
	End if 
	
Else 
	
	$FenetreInformation:=$Path_t+" is a new Method and hasn't been saved yet."
End if 
displayInfo ($FenetreInformation)