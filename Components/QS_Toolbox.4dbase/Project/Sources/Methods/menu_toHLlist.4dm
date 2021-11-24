//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_OBJECT:C1216($1; $data)
C_TEXT:C284($refMenu_t; $whatSubMenu)
C_LONGINT:C283($lineMenu; $Souslist0)

$data:=$1

$list:=$data.list
$refMenu_t:=$data.menu
$lineMenu:=$data.line
$whatSubRef:=$data.menuRef
$whatSubMenu:=$data.menuTitle

//$pic_command:=PIC_GetPicture("images/methods/icns_command.png")

If ($whatSubRef#"")
	
	$subList:=New list:C375
	$data.list:=$subList
	$data.menu:=$refMenu_t
	$data.menuRef:=$whatSubRef
	menu_toHLlist($data)
	
Else 
	Form:C1466.count:=Form:C1466.count+1
	$itemMenu:=Get menu item:C422($refMenu_t; $lineMenu)
	$method_t:=Get menu item method:C981($refMenu_t; $lineMenu)
	StorageCounter("get")
	
	$txt:=""
	If ($methode_t#"")
		$txt:=" (method: "+$method_t+")"
	End if 
	
	
	$racine:="Menu"
	//$Souslist99:=LH_updateTB(->$Souslist0; ->$pic_command; $racine)
	$Souslist99:=LH_updateTBpath(->$Souslist0; "images/methods/icns_command.png"; $racine)
	SET LIST ITEM PARAMETER:C986($Souslist0; 0; "path"; "")
	SET LIST ITEM PARAMETER:C986($Souslist0; 0; "type"; $racine)
	SET LIST ITEM PARAMETER:C986($Souslist0; 0; "clicked"; "")
	StorageCounter("set")
	
	
End if 