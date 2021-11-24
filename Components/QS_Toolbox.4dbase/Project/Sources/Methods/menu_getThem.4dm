//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
SET MENU BAR:C67(1)
C_OBJECT:C1216($data)
ARRAY TEXT:C222($whatRef;0x0000)
ARRAY TEXT:C222($whatMenu;0x0000)
ARRAY TEXT:C222($whatSubRef;0x0000)
ARRAY TEXT:C222($whatSubMenu;0x0000)

$data:=New object:C1471

$refMenu_t:=Get menu bar reference:C979  // Should be 1 ;-)
$nbLignes_l:=Count menu items:C405($refMenu_t)
GET MENU ITEMS:C977($refMenu_t;$whatMenu;$whatRef)  // Get Menu titles

LH_clearList (Form:C1466.LH)
Form:C1466.my_LH:=New list:C375
APPEND TO LIST:C376(Form:C1466.my_LH;"Processing data...";0)
OBJECT SET LIST BY REFERENCE:C1266(*;"myLH";Choice list:K42:19;Form:C1466.my_LH)
OBJECT SET ENTERABLE:C238(*;"myLH";False:C215)

$list:=New list:C375

For ($menu_l;1;Size of array:C274($whatMenu))
	
	$refMenu_t:=$whatRef{$menu_l}  //menu sélectionné
	GET MENU ITEMS:C977($refMenu_t;$whatSubMenu;$whatSubRef)
	
	If (Size of array:C274($whatSubMenu)>0)
		
		$sublist:=New list:C375
		Form:C1466.count:=Form:C1466.count+1
		APPEND TO LIST:C376($list;$whatMenu{$menu_l};Form:C1466.count;$sublist;False:C215)
		
		For ($lineMenu;1;Size of array:C274($whatSubMenu))
			
			$data.list:=$sublist
			$data.menu:=$refMenu_t
			$data.line:=$lineMenu
			$data.menuTitle:=$whatSubMenu{$lineMenu}
			$data.menuRef:=$whatSubRef{$lineMenu}
			menu_toHLlist ($data)
			
		End for 
	End if 
	
End for 

LH_assign ($list)