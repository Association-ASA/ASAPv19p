//%attributes = {}
// LB_getColumnClicked
// Parameters:
// 
// ----------------------------------------------------
// Description:
// 
// ----------------------------------------------------
// Creation: https://discuss.4d.com/t/detecting-a-listbox-header-column-number/11038/11
//

/* Test

$event_o$headerName:=LB_getColumnClicked("name")
$headerNumber:=LB_getColumnClicked("number")
$headerTitle:=LB_getColumnClicked("title")
$headerPtr:=LB_getColumnClicked("pointer")

*/

C_VARIANT:C1683($0)
C_TEXT:C284($1; $toGet)

If (Count parameters:C259>=1)
	$toGet:=$1
	
	C_OBJECT:C1216($event_o)
	$event_o:=FORM Event:C1606
	If ($event_o.description="On Header Click")
		Case of 
			: ($toGet="name")
				$0:=$event_o.headerName
			: ($toGet="number")
				$0:=$event_o.column
			: ($toGet="title")
				$0:=OBJECT Get title:C1068(*; $event_o.headerName)
			: ($toGet="pointer")
				$0:=OBJECT Get pointer:C1124(Object named:K67:5; $event_o.headerName)
		End case 
	End if 
End if 


