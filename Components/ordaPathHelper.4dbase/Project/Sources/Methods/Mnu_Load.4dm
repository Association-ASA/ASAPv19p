//%attributes = {}
  //Mnu_Load (menuRef_t;domRef_t)
  //Description
  //charge dans le menu référencé par $1
  //sa description en ref xml $2
  //cf. Mnu_LoadFromFile

  //© Vincent de Lachaux * 04/02/09

C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($j_l;$Lon_modifier)
C_TEXT:C284($Dom_node;$Mnu_menuReference;$Mnu_menu;$Txt_attributeName;$Txt_attributeValue)
C_TEXT:C284($Txt_label;$Txt_type)

If (False:C215)
	C_TEXT:C284(Mnu_Load ;$1)
	C_TEXT:C284(Mnu_Load ;$2)
End if 

$Mnu_menuReference:=$1
$Dom_node:=DOM Get first child XML element:C723($2)
If (OK=1)
	Repeat 
		DOM GET XML ELEMENT NAME:C730($Dom_node;$Txt_type)
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_node;"text";$Txt_label)
		If ($Txt_label=":xliff:@")
			$Txt_label:=Get localized string:C991(Delete string:C232($Txt_label;1;7))
		End if 
		If ($Txt_type="menu")
			$Mnu_menu:=Create menu:C408
			Mnu_Load ($Mnu_menu;$Dom_node)  //>>>>>>>>RECURSIVE
			APPEND MENU ITEM:C411($Mnu_menuReference;$Txt_label;$Mnu_menu)
		Else 
			APPEND MENU ITEM:C411($Mnu_menuReference;$Txt_label)
			If ($Txt_label#"-@")
				For ($j_l;1;DOM Count XML attributes:C727($Dom_node);1)
					DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_node;$j_l;$Txt_attributeName;$Txt_attributeValue)
					Case of 
						: ($Txt_attributeName="reference")
							SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;$Txt_attributeValue)
						: ($Txt_attributeName="shortcut")
							SET MENU ITEM SHORTCUT:C423($Mnu_menuReference;-1;Character code:C91($Txt_attributeValue);Get menu item modifiers:C980($Mnu_menuReference;-1))
						: ($Txt_attributeName="shift")
							$Lon_modifier:=Get menu item modifiers:C980($Mnu_menuReference;-1)
							If ($Txt_attributeValue="true")
								$Lon_modifier:=$Lon_modifier ?+ Shift key bit:K16:4
							Else 
								$Lon_modifier:=$Lon_modifier ?- Shift key bit:K16:4
							End if 
							SET MENU ITEM SHORTCUT:C423($Mnu_menuReference;-1;Get menu item key:C424($Mnu_menuReference;-1);$Lon_modifier)
						: ($Txt_attributeName="alt")
							$Lon_modifier:=Get menu item modifiers:C980($Mnu_menuReference;-1)
							If ($Txt_attributeValue="true")
								$Lon_modifier:=$Lon_modifier ?+ Option key bit:K16:8
							Else 
								$Lon_modifier:=$Lon_modifier ?- Option key bit:K16:8
							End if 
							SET MENU ITEM SHORTCUT:C423($Mnu_menuReference;-1;Get menu item key:C424($Mnu_menuReference;-1);$Lon_modifier)
						: ($Txt_attributeName="standard_action")
							SET MENU ITEM PROPERTY:C973($Mnu_menuReference;-1;"4D_standard_action";$Txt_attributeValue)
						: ($Txt_attributeName="enable")
							SET MENU ITEM PROPERTY:C973($Mnu_menuReference;-1;"4D_enable";$Txt_attributeValue)
						: ($Txt_attributeName="method")
							SET MENU ITEM METHOD:C982($Mnu_menuReference;-1;$Txt_attributeValue)
						: ($Txt_attributeName="icon")
							SET MENU ITEM ICON:C984($Mnu_menuReference;-1;"File:"+$Txt_attributeValue)
						: ($Txt_attributeName="mark")
							SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18)*Num:C11($Txt_attributeValue="true"))
						: ($Txt_attributeName="style")
							SET MENU ITEM STYLE:C425($Mnu_menuReference;-1;Num:C11($Txt_attributeValue))
					End case 
				End for 
			End if 
		End if 
		$Dom_node:=DOM Get next sibling XML element:C724($Dom_node)
	Until (OK=0)
Else 
	TRACE:C157
End if 
