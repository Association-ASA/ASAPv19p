//%attributes = {}
  //Mnu_Release (refMenu_t)
  //efface de la mémoire le menu référencé par $1
  //ainsi que ses sous-menus
  //recursive

  //© vdl * 21/07/06

C_TEXT:C284($1)

C_LONGINT:C283($i_l)
C_TEXT:C284($refMnu_t)
ARRAY TEXT:C222($label_at;0)
ARRAY TEXT:C222($ref_at;0)

If (False:C215)
	C_TEXT:C284(Mnu_Release ;$1)
End if 

ASSERT:C1129(Count parameters:C259>0;Current method name:C684)

$refMnu_t:=$1

If (Length:C16($refMnu_t)>0)
	GET MENU ITEMS:C977($refMnu_t;$label_at;$ref_at)
	For ($i_l;1;Size of array:C274($ref_at);1)
		If (Length:C16($ref_at{$i_l})>0)  //sous menu
			Mnu_Release ($ref_at{$i_l})  //#Recursive
		End if 
	End for 
	RELEASE MENU:C978($refMnu_t)
End if 
